//Bibliotecas
#Include "Totvs.ch"
#Include "RESTFul.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} WSRESTFUL ZWPRODUTOS
CADASTRO DE PRODUTO
@author Fabio Favaretto
@since 20/05/2023
@version 1.0
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

WSRESTFUL ZWPRODUTOS DESCRIPTION 'CADASTRO DE PRODUTO'
    //Atributos
    WSDATA id         AS STRING
    WSDATA updated_at AS STRING
    WSDATA limit      AS INTEGER
    WSDATA page       AS INTEGER
 
    //Métodos
    WSMETHOD GET    ID     DESCRIPTION 'Retorna o registro pesquisado' WSSYNTAX '/ZWPRODUTOS/get_id?{id}'                       PATH 'get_id'        PRODUCES APPLICATION_JSON
    WSMETHOD GET    ALL    DESCRIPTION 'Retorna todos os registros'    WSSYNTAX '/ZWPRODUTOS/get_all?{updated_at, limit, page}' PATH 'get_all'       PRODUCES APPLICATION_JSON
    WSMETHOD POST   NEW    DESCRIPTION 'Inclusão de registro'          WSSYNTAX '/ZWPRODUTOS/new'                               PATH 'new'           PRODUCES APPLICATION_JSON
    WSMETHOD PUT    UPDATE DESCRIPTION 'Atualização de registro'       WSSYNTAX '/ZWPRODUTOS/update'                            PATH 'update'        PRODUCES APPLICATION_JSON
    WSMETHOD DELETE ERASE  DESCRIPTION 'Exclusão de registro'          WSSYNTAX '/ZWPRODUTOS/erase'                             PATH 'erase'         PRODUCES APPLICATION_JSON
END WSRESTFUL

/*/{Protheus.doc} WSMETHOD GET ID
Busca registro via ID
@author Fabio Favaretto
@since 20/05/2023
@version 1.0
@param id, Caractere, String que será pesquisada através do MsSeek
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

WSMETHOD GET ID WSRECEIVE id WSSERVICE ZWPRODUTOS
    Local lRet       := .T.
    Local jResponse  := JsonObject():New()
    Local cAliasWS   := 'SB1'

    //Se o id estiver vazio
    If Empty(::id)
        //SetRestFault(500, 'Falha ao consultar o registro') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'ID001'
        jResponse['error']    := 'ID vazio'
        jResponse['solution'] := 'Informe o ID'
    Else
        DbSelectArea(cAliasWS)
        (cAliasWS)->(DbSetOrder(1))

        //Se não encontrar o registro
        If ! (cAliasWS)->(MsSeek(FWxFilial(cAliasWS) + ::id))
            //SetRestFault(500, 'Falha ao consultar ID') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
            Self:setStatus(500) 
            jResponse['errorId']  := 'ID002'
            jResponse['error']    := 'ID não encontrado'
            jResponse['solution'] := 'Código ID não encontrado na tabela ' + cAliasWS
        Else
            //Define o retorno
            jResponse['codigo'] := (cAliasWS)->B1_CODIGO 
            jResponse['descr'] := (cAliasWS)->B1_DESCR 
            jResponse['tipo'] := (cAliasWS)->B1_TIPO 
            jResponse['um'] := (cAliasWS)->B1_UM 
            jResponse['locpad'] := (cAliasWS)->B1_LOCPAD 
            jResponse['xsubgru'] := (cAliasWS)->B1_XSUBGRU 
            jResponse['proc'] := (cAliasWS)->B1_PROC 
            jResponse['localiz'] := (cAliasWS)->B1_LOCALIZ 
            jResponse['posibi'] := (cAliasWS)->B1_POSIBI 
            jResponse['origem'] := (cAliasWS)->B1_ORIGEM 
            jResponse['garent'] := (cAliasWS)->B1_GARENT 
        EndIf
    EndIf

    //Define o retorno
    Self:SetContentType('application/json')
    Self:SetResponse(jResponse:toJSON())
Return lRet

/*/{Protheus.doc} WSMETHOD GET ALL
Busca todos os registros através de paginação
@author Fabio Favaretto
@since 20/05/2023
@version 1.0
@param updated_at, Caractere, Data de alteração no formato string 'YYYY-MM-DD' (somente se tiver o campo USERLGA / USERGA na tabela)
@param limit, Numérico, Limite de registros que irá vir (por exemplo trazer apenas 100 registros)
@param page, Numérico, Número da página que irá buscar (se existir 1000 registros dividido por 100 terá 10 páginas de pesquisa)
@obs Codigo gerado automaticamente pelo Autumn Code Maker

    Poderia ser usado o FWAdapterBaseV2(), mas em algumas versões antigas não existe essa funcionalidade
    então a paginação foi feita manualmente

@see http://autumncodemaker.com
/*/

WSMETHOD GET ALL WSRECEIVE updated_at, limit, page WSSERVICE ZWPRODUTOS
    Local lRet       := .T.
    Local jResponse  := JsonObject():New()
    Local cQueryTab  := ''
    Local nTamanho   := 10
    Local nTotal     := 0
    Local nPags      := 0
    Local nPagina    := 0
    Local nAtual     := 0
    Local oRegistro
    Local cAliasWS   := 'SB1'

    //Efetua a busca dos registros
    cQueryTab := " SELECT " + CRLF
    cQueryTab += "     TAB.R_E_C_N_O_ AS TABREC " + CRLF
    cQueryTab += " FROM " + CRLF
    cQueryTab += "     " + RetSQLName(cAliasWS) + " TAB " + CRLF
    cQueryTab += " WHERE " + CRLF
    cQueryTab += "     TAB.D_E_L_E_T_ = '' " + CRLF
    If ! Empty(::updated_at)
        cQueryTab += "     AND ((CASE WHEN SUBSTRING(B1_USERLGA, 03, 1) != ' ' THEN " + CRLF
        cQueryTab += "        CONVERT(VARCHAR,DATEADD(DAY,((ASCII(SUBSTRING(B1_USERLGA,12,1)) - 50) * 100 + (ASCII(SUBSTRING(B1_USERLGA,16,1)) - 50)),'19960101'),112) " + CRLF
        cQueryTab += "        ELSE '' " + CRLF
        cQueryTab += "     END) >= '" + StrTran(::updated_at, '-', '') + "') " + CRLF
    EndIf
    cQueryTab += " ORDER BY " + CRLF
    cQueryTab += "     TABREC " + CRLF
    TCQuery cQueryTab New Alias 'QRY_TAB'

    //Se não encontrar registros
    If QRY_TAB->(EoF())
        //SetRestFault(500, 'Falha ao consultar registros') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'ALL003'
        jResponse['error']    := 'Registro(s) não encontrado(s)'
        jResponse['solution'] := 'A consulta de registros não retornou nenhuma informação'
    Else
        jResponse['objects'] := {}

        //Conta o total de registros
        Count To nTotal
        QRY_TAB->(DbGoTop())

        //O tamanho do retorno, será o limit, se ele estiver definido
        If ! Empty(::limit)
            nTamanho := ::limit
        EndIf

        //Pegando total de páginas
        nPags := NoRound(nTotal / nTamanho, 0)
        nPags += Iif(nTotal % nTamanho != 0, 1, 0)
        
        //Se vier página
        If ! Empty(::page)
            nPagina := ::page
        EndIf

        //Se a página vier zerada ou negativa ou for maior que o máximo, será 1 
        If nPagina <= 0 .Or. nPagina > nPags
            nPagina := 1
        EndIf

        //Se a página for diferente de 1, pula os registros
        If nPagina != 1
            QRY_TAB->(DbSkip((nPagina-1) * nTamanho))
        EndIf

        //Adiciona os dados para a meta
        jJsonMeta := JsonObject():New()
        jJsonMeta['total']         := nTotal
        jJsonMeta['current_page']  := nPagina
        jJsonMeta['total_page']    := nPags
        jJsonMeta['total_items']   := nTamanho
        jResponse['meta'] := jJsonMeta

        //Percorre os registros
        While ! QRY_TAB->(EoF())
            nAtual++
            
            //Se ultrapassar o limite, encerra o laço
            If nAtual > nTamanho
                Exit
            EndIf

            //Posiciona o registro e adiciona no retorno
            DbSelectArea(cAliasWS)
            (cAliasWS)->(DbGoTo(QRY_TAB->TABREC))
            
            oRegistro := JsonObject():New()
            oRegistro['codigo'] := (cAliasWS)->B1_CODIGO 
            oRegistro['descr'] := (cAliasWS)->B1_DESCR 
            oRegistro['tipo'] := (cAliasWS)->B1_TIPO 
            oRegistro['um'] := (cAliasWS)->B1_UM 
            oRegistro['locpad'] := (cAliasWS)->B1_LOCPAD 
            oRegistro['xsubgru'] := (cAliasWS)->B1_XSUBGRU 
            oRegistro['proc'] := (cAliasWS)->B1_PROC 
            oRegistro['localiz'] := (cAliasWS)->B1_LOCALIZ 
            oRegistro['posibi'] := (cAliasWS)->B1_POSIBI 
            oRegistro['origem'] := (cAliasWS)->B1_ORIGEM 
            oRegistro['garent'] := (cAliasWS)->B1_GARENT 
            aAdd(jResponse['objects'], oRegistro)

            QRY_TAB->(DbSkip())
        EndDo
    EndIf
    QRY_TAB->(DbCloseArea())

    //Define o retorno
    Self:SetContentType('application/json')
    Self:SetResponse(jResponse:toJSON())
Return lRet

/*/{Protheus.doc} WSMETHOD POST NEW
Cria um novo registro na tabela
@author Fabio Favaretto
@since 20/05/2023
@version 1.0
@obs Codigo gerado automaticamente pelo Autumn Code Maker

    Abaixo um exemplo do JSON que deverá vir no body
    * 1: Para campos do tipo Numérico, informe o valor sem usar as aspas
    * 2: Para campos do tipo Data, informe uma string no padrão 'YYYY-MM-DD'

    {
        "codigo": "conteudo",
        "descr": "conteudo",
        "tipo": "conteudo",
        "um": "conteudo",
        "locpad": "conteudo",
        "xsubgru": "conteudo",
        "proc": "conteudo",
        "localiz": "conteudo",
        "posibi": "conteudo",
        "origem": "conteudo",
        "garent": "conteudo"
    }

@see http://autumncodemaker.com
/*/

WSMETHOD POST NEW WSRECEIVE WSSERVICE ZWPRODUTOS
    Local lRet              := .T.
    Local aDados            := {}
    Local jJson             := Nil
    Local cJson             := Self:GetContent()
    Local cError            := ''
    Local nLinha            := 0
    Local cDirLog           := '\x_logs\'
    Local cArqLog           := ''
    Local cErrorLog         := ''
    Local aLogAuto          := {}
    Local nCampo            := 0
    Local jResponse         := JsonObject():New()
    Local cAliasWS          := 'SB1'
    Private lMsErroAuto     := .F.
    Private lMsHelpAuto     := .T.
    Private lAutoErrNoFile  := .T.
 
    //Se não existir a pasta de logs, cria
    IF ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIF    

    //Definindo o conteúdo como JSON, e pegando o content e dando um parse para ver se a estrutura está ok
    Self:SetContentType('application/json')
    jJson  := JsonObject():New()
    cError := jJson:FromJson(cJson)
 
    //Se tiver algum erro no Parse, encerra a execução
    IF ! Empty(cError)
        //SetRestFault(500, 'Falha ao obter JSON') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'NEW004'
        jResponse['error']    := 'Parse do JSON'
        jResponse['solution'] := 'Erro ao fazer o Parse do JSON'

    Else
		DbSelectArea(cAliasWS)
       
		//Adiciona os dados do ExecAuto
		aAdd(aDados, {'B1_CODIGO',   jJson:GetJsonObject('codigo'),   Nil})
		aAdd(aDados, {'B1_DESCR',   jJson:GetJsonObject('descr'),   Nil})
		aAdd(aDados, {'B1_TIPO',   jJson:GetJsonObject('tipo'),   Nil})
		aAdd(aDados, {'B1_UM',   jJson:GetJsonObject('um'),   Nil})
		aAdd(aDados, {'B1_LOCPAD',   jJson:GetJsonObject('locpad'),   Nil})
		aAdd(aDados, {'B1_XSUBGRU',   jJson:GetJsonObject('xsubgru'),   Nil})
		aAdd(aDados, {'B1_PROC',   jJson:GetJsonObject('proc'),   Nil})
		aAdd(aDados, {'B1_LOCALIZ',   jJson:GetJsonObject('localiz'),   Nil})
		aAdd(aDados, {'B1_POSIBI',   jJson:GetJsonObject('posibi'),   Nil})
		aAdd(aDados, {'B1_ORIGEM',   jJson:GetJsonObject('origem'),   Nil})
		aAdd(aDados, {'B1_GARENT',   jJson:GetJsonObject('garent'),   Nil})
		
		//Percorre os dados do execauto
		For nCampo := 1 To Len(aDados)
			//Se o campo for data, retira os hifens e faz a conversão
			If GetSX3Cache(aDados[nCampo][1], 'X3_TIPO') == 'D'
				aDados[nCampo][2] := StrTran(aDados[nCampo][2], '-', '')
				aDados[nCampo][2] := sToD(aDados[nCampo][2])
			EndIf
		Next

		//Chama a inclusão automática
		MsExecAuto({|x, y| MATA010(x, y)}, aDados, 3)

		//Se houve erro, gera um arquivo de log dentro do diretório da protheus data
		If lMsErroAuto
			//Monta o texto do Error Log que será salvo
			cErrorLog   := ''
			aLogAuto    := GetAutoGrLog()
			For nLinha := 1 To Len(aLogAuto)
				cErrorLog += aLogAuto[nLinha] + CRLF
			Next nLinha

			//Grava o arquivo de log
			cArqLog := 'ZWPRODUTOS_New_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.log'
			MemoWrite(cDirLog + cArqLog, cErrorLog)

			//Define o retorno para o WebService
			//SetRestFault(500, cErrorLog) //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
           Self:setStatus(500) 
			jResponse['errorId']  := 'NEW005'
			jResponse['error']    := 'Erro na inclusão do registro'
			jResponse['solution'] := 'Nao foi possivel incluir o registro, foi gerado um arquivo de log em ' + cDirLog + cArqLog + ' '
			lRet := .F.

		//Senão, define o retorno
		Else
			jResponse['note']     := 'Registro incluido com sucesso'
		EndIf

    EndIf

    //Define o retorno
    Self:SetResponse(jResponse:toJSON())
Return lRet

/*/{Protheus.doc} WSMETHOD PUT UPDATE
Atualiza o registro na tabela
@author Fabio Favaretto
@since 20/05/2023
@version 1.0
@param id, Caractere, String que será pesquisada através do MsSeek
@obs Codigo gerado automaticamente pelo Autumn Code Maker

    Abaixo um exemplo do JSON que deverá vir no body
    * 1: Para campos do tipo Numérico, informe o valor sem usar as aspas
    * 2: Para campos do tipo Data, informe uma string no padrão 'YYYY-MM-DD'

    {
        "codigo": "conteudo",
        "descr": "conteudo",
        "tipo": "conteudo",
        "um": "conteudo",
        "locpad": "conteudo",
        "xsubgru": "conteudo",
        "proc": "conteudo",
        "localiz": "conteudo",
        "posibi": "conteudo",
        "origem": "conteudo",
        "garent": "conteudo"
    }

@see http://autumncodemaker.com
/*/

WSMETHOD PUT UPDATE WSRECEIVE id WSSERVICE ZWPRODUTOS
    Local lRet              := .T.
    Local aDados            := {}
    Local jJson             := Nil
    Local cJson             := Self:GetContent()
    Local cError            := ''
    Local nLinha            := 0
    Local cDirLog           := '\x_logs\'
    Local cArqLog           := ''
    Local cErrorLog         := ''
    Local aLogAuto          := {}
    Local nCampo            := 0
    Local jResponse         := JsonObject():New()
    Local cAliasWS          := 'SB1'
    Private lMsErroAuto     := .F.
    Private lMsHelpAuto     := .T.
    Private lAutoErrNoFile  := .T.

    //Se não existir a pasta de logs, cria
    IF ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIF    

    //Definindo o conteúdo como JSON, e pegando o content e dando um parse para ver se a estrutura está ok
    Self:SetContentType('application/json')
    jJson  := JsonObject():New()
    cError := jJson:FromJson(cJson)

    //Se o id estiver vazio
    If Empty(::id)
        //SetRestFault(500, 'Falha ao consultar o registro') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'UPD006'
        jResponse['error']    := 'ID vazio'
        jResponse['solution'] := 'Informe o ID'
    Else
        DbSelectArea(cAliasWS)
        (cAliasWS)->(DbSetOrder(1))

        //Se não encontrar o registro
        If ! (cAliasWS)->(MsSeek(FWxFilial(cAliasWS) + ::id))
            //SetRestFault(500, 'Falha ao consultar ID') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
            Self:setStatus(500) 
            jResponse['errorId']  := 'UPD007'
            jResponse['error']    := 'ID não encontrado'
            jResponse['solution'] := 'Código ID não encontrado na tabela ' + cAliasWS
        Else
 
            //Se tiver algum erro no Parse, encerra a execução
            If ! Empty(cError)
                //SetRestFault(500, 'Falha ao obter JSON') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
                Self:setStatus(500) 
                jResponse['errorId']  := 'UPD008'
                jResponse['error']    := 'Parse do JSON'
                jResponse['solution'] := 'Erro ao fazer o Parse do JSON'

            Else
		         DbSelectArea(cAliasWS)
                
		         //Adiciona os dados do ExecAuto
		         aAdd(aDados, {'B1_CODIGO',   jJson:GetJsonObject('codigo'),   Nil})
		         aAdd(aDados, {'B1_DESCR',   jJson:GetJsonObject('descr'),   Nil})
		         aAdd(aDados, {'B1_TIPO',   jJson:GetJsonObject('tipo'),   Nil})
		         aAdd(aDados, {'B1_UM',   jJson:GetJsonObject('um'),   Nil})
		         aAdd(aDados, {'B1_LOCPAD',   jJson:GetJsonObject('locpad'),   Nil})
		         aAdd(aDados, {'B1_XSUBGRU',   jJson:GetJsonObject('xsubgru'),   Nil})
		         aAdd(aDados, {'B1_PROC',   jJson:GetJsonObject('proc'),   Nil})
		         aAdd(aDados, {'B1_LOCALIZ',   jJson:GetJsonObject('localiz'),   Nil})
		         aAdd(aDados, {'B1_POSIBI',   jJson:GetJsonObject('posibi'),   Nil})
		         aAdd(aDados, {'B1_ORIGEM',   jJson:GetJsonObject('origem'),   Nil})
		         aAdd(aDados, {'B1_GARENT',   jJson:GetJsonObject('garent'),   Nil})
		         
		         //Percorre os dados do execauto
		         For nCampo := 1 To Len(aDados)
		         	//Se o campo for data, retira os hifens e faz a conversão
		         	If GetSX3Cache(aDados[nCampo][1], 'X3_TIPO') == 'D'
		         		aDados[nCampo][2] := StrTran(aDados[nCampo][2], '-', '')
		         		aDados[nCampo][2] := sToD(aDados[nCampo][2])
		         	EndIf
		         Next

		         //Chama a atualização automática
		         MsExecAuto({|x, y| MATA010(x, y)}, aDados, 4)

		         //Se houve erro, gera um arquivo de log dentro do diretório da protheus data
		         If lMsErroAuto
		         	//Monta o texto do Error Log que será salvo
		         	cErrorLog   := ''
		         	aLogAuto    := GetAutoGrLog()
		         	For nLinha := 1 To Len(aLogAuto)
		         		cErrorLog += aLogAuto[nLinha] + CRLF
		         	Next nLinha

		            //Grava o arquivo de log
		            cArqLog := 'ZWPRODUTOS_New_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.log'
		            MemoWrite(cDirLog + cArqLog, cErrorLog)

		            //Define o retorno para o WebService
		            //SetRestFault(500, cErrorLog) //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
		            Self:setStatus(500) 
		            jResponse['errorId']  := 'UPD009'
		            jResponse['error']    := 'Erro na atualização do registro'
		            jResponse['solution'] := 'Nao foi possivel incluir o registro, foi gerado um arquivo de log em ' + cDirLog + cArqLog + ' '
		            lRet := .F.

		         //Senão, define o retorno
		         Else
		         	jResponse['note']     := 'Registro incluido com sucesso'
		         EndIf

		     EndIf
		 EndIf
    EndIf

    //Define o retorno
    Self:SetResponse(jResponse:toJSON())
Return lRet

/*/{Protheus.doc} WSMETHOD DELETE ERASE
Apaga o registro na tabela
@author Fabio Favaretto
@since 20/05/2023
@version 1.0
@param id, Caractere, String que será pesquisada através do MsSeek
@obs Codigo gerado automaticamente pelo Autumn Code Maker

    Abaixo um exemplo do JSON que deverá vir no body
    * 1: Para campos do tipo Numérico, informe o valor sem usar as aspas
    * 2: Para campos do tipo Data, informe uma string no padrão 'YYYY-MM-DD'

    {
        "codigo": "conteudo",
        "descr": "conteudo",
        "tipo": "conteudo",
        "um": "conteudo",
        "locpad": "conteudo",
        "xsubgru": "conteudo",
        "proc": "conteudo",
        "localiz": "conteudo",
        "posibi": "conteudo",
        "origem": "conteudo",
        "garent": "conteudo"
    }

@see http://autumncodemaker.com
/*/

WSMETHOD DELETE ERASE WSRECEIVE id WSSERVICE ZWPRODUTOS
    Local lRet              := .T.
    Local aDados            := {}
    Local jJson             := Nil
    Local cJson             := Self:GetContent()
    Local cError            := ''
    Local nLinha            := 0
    Local cDirLog           := '\x_logs\'
    Local cArqLog           := ''
    Local cErrorLog         := ''
    Local aLogAuto          := {}
    Local nCampo            := 0
    Local jResponse         := JsonObject():New()
    Local cAliasWS          := 'SB1'
    Private lMsErroAuto     := .F.
    Private lMsHelpAuto     := .T.
    Private lAutoErrNoFile  := .T.

    //Se não existir a pasta de logs, cria
    IF ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIF    

    //Definindo o conteúdo como JSON, e pegando o content e dando um parse para ver se a estrutura está ok
    Self:SetContentType('application/json')
    jJson  := JsonObject():New()
    cError := jJson:FromJson(cJson)

    //Se o id estiver vazio
    If Empty(::id)
        //SetRestFault(500, 'Falha ao consultar o registro') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'DEL010'
        jResponse['error']    := 'ID vazio'
        jResponse['solution'] := 'Informe o ID'
    Else
        DbSelectArea(cAliasWS)
        (cAliasWS)->(DbSetOrder(1))

        //Se não encontrar o registro
        If ! (cAliasWS)->(MsSeek(FWxFilial(cAliasWS) + ::id))
            //SetRestFault(500, 'Falha ao consultar ID') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
            Self:setStatus(500) 
            jResponse['errorId']  := 'DEL011'
            jResponse['error']    := 'ID não encontrado'
            jResponse['solution'] := 'Código ID não encontrado na tabela ' + cAliasWS
        Else
 
            //Se tiver algum erro no Parse, encerra a execução
            If ! Empty(cError)
                //SetRestFault(500, 'Falha ao obter JSON') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
                Self:setStatus(500) 
                jResponse['errorId']  := 'DEL012'
                jResponse['error']    := 'Parse do JSON'
                jResponse['solution'] := 'Erro ao fazer o Parse do JSON'

            Else
		         DbSelectArea(cAliasWS)
                
		         //Adiciona os dados do ExecAuto
		         aAdd(aDados, {'B1_CODIGO',   jJson:GetJsonObject('codigo'),   Nil})
		         aAdd(aDados, {'B1_DESCR',   jJson:GetJsonObject('descr'),   Nil})
		         aAdd(aDados, {'B1_TIPO',   jJson:GetJsonObject('tipo'),   Nil})
		         aAdd(aDados, {'B1_UM',   jJson:GetJsonObject('um'),   Nil})
		         aAdd(aDados, {'B1_LOCPAD',   jJson:GetJsonObject('locpad'),   Nil})
		         aAdd(aDados, {'B1_XSUBGRU',   jJson:GetJsonObject('xsubgru'),   Nil})
		         aAdd(aDados, {'B1_PROC',   jJson:GetJsonObject('proc'),   Nil})
		         aAdd(aDados, {'B1_LOCALIZ',   jJson:GetJsonObject('localiz'),   Nil})
		         aAdd(aDados, {'B1_POSIBI',   jJson:GetJsonObject('posibi'),   Nil})
		         aAdd(aDados, {'B1_ORIGEM',   jJson:GetJsonObject('origem'),   Nil})
		         aAdd(aDados, {'B1_GARENT',   jJson:GetJsonObject('garent'),   Nil})
		         
		         //Percorre os dados do execauto
		         For nCampo := 1 To Len(aDados)
		         	//Se o campo for data, retira os hifens e faz a conversão
		         	If GetSX3Cache(aDados[nCampo][1], 'X3_TIPO') == 'D'
		         		aDados[nCampo][2] := StrTran(aDados[nCampo][2], '-', '')
		         		aDados[nCampo][2] := sToD(aDados[nCampo][2])
		         	EndIf
		         Next

		         //Chama a exclusão automática
		         MsExecAuto({|x, y| MATA010(x, y)}, aDados, 5)

		         //Se houve erro, gera um arquivo de log dentro do diretório da protheus data
		         If lMsErroAuto
		         	//Monta o texto do Error Log que será salvo
		         	cErrorLog   := ''
		         	aLogAuto    := GetAutoGrLog()
		         	For nLinha := 1 To Len(aLogAuto)
		         		cErrorLog += aLogAuto[nLinha] + CRLF
		         	Next nLinha

		            //Grava o arquivo de log
		            cArqLog := 'ZWPRODUTOS_New_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.log'
		            MemoWrite(cDirLog + cArqLog, cErrorLog)

		            //Define o retorno para o WebService
		            //SetRestFault(500, cErrorLog) //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
		            Self:setStatus(500) 
		            jResponse['errorId']  := 'DEL013'
		            jResponse['error']    := 'Erro na exclusão do registro'
		            jResponse['solution'] := 'Nao foi possivel incluir o registro, foi gerado um arquivo de log em ' + cDirLog + cArqLog + ' '
		            lRet := .F.

		         //Senão, define o retorno
		         Else
		         	jResponse['note']     := 'Registro incluido com sucesso'
		         EndIf

		     EndIf
		 EndIf
    EndIf

    //Define o retorno
    Self:SetResponse(jResponse:toJSON())
Return lRet
