//Bibliotecas
#Include "Totvs.ch"
#Include "TopConn.ch"
#Include "RPTDef.ch"
#Include "FWPrintSetup.ch"

//Alinhamentos
#Define PAD_LEFT    0
#Define PAD_RIGHT   1
#Define PAD_CENTER  2

//Cor(es)
Static nCorCinza := RGB(110, 110, 110)
Static nCorLinha := RGB(217, 255, 226)

/*/{Protheus.doc} User Function zJob06
Listagem de Produtos Vendidos
@author Atilio
@since 18/04/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zJob06()
	Local aArea      := FWGetArea()
	Local aPergs     := {}
    Local dDataHoje  := Date()
	Local dDataDe    := FirstDate(dDataHoje)
	Local dDataAte   := LastDate(dDataHoje)
    Local lContinua  := .F.
    Private lJobPvt  := .F.
	
	//Se nao tiver aberto o dicionario (rotina executada sem abrir o Protheus)
	If Select("SX2") <= 0
		cEmprJob := "99"
		cFiliJob  := "01"
		
		RPCSetEnv(cEmprJob, cFiliJob, "Administrador", "", "", "")
		lJobPvt := .T.
		
        //Atualiza os parâmetros em memória
        MV_PAR01  := MonthSub(dDataHoje, 3)
        MV_PAR02  := dDataHoje
        lContinua := .T.

    //Senão, somente se o usuário confirmar a pergunta
	Else

        //Adicionando os parametros do ParamBox
        aAdd(aPergs, {1, "Data De",  dDataDe,   "", ".T.", "", ".T.", 80,  .F.})
        aAdd(aPergs, {1, "Data Até", dDataAte,  "", ".T.", "", ".T.", 80,  .T.})
        
        //Se a pergunta for confirma, cria o relatorio
        lContinua := ParamBox(aPergs, "Informe os parametros")
	EndIf
	
	If lContinua
		Processa({|| fImprime()})
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fImprime
Faz a impressão do relatório zJob06
@author Atilio
@since 18/04/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImprime()
    Local aArea        := GetArea()
    Local nTotAux      := 0
    Local nAtuAux      := 0
    Local cQryAux      := ''
    Local cCaminho     := ''
    Local cArquivo     := 'zJob06'+RetCodUsr()+'_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.pdf'
    Local cPara        := ""
    Local cAssunto     := ""
    Local cMensagem    := ""
    Local aAnexos      := {}
    Private oPrintPvt
    Private oBrushLin  := TBrush():New(,nCorLinha)
    Private cHoraEx    := Time()
    Private nPagAtu    := 1
    Private cLogoEmp   := fLogoEmp()
    //Linhas e colunas
    Private nLinAtu    := 0
    Private nLinFin    := 800
    Private nColIni    := 010
    Private nColFin    := 580
    Private nColMeio   := (nColFin-nColIni)/2
    //Colunas dos relatorio
    Private nColProdut    := nColIni
    Private nColDescri    := nColIni + 70
    Private nColQtdVen    := nColIni + 195
    Private nColDatEmi    := nColIni + 295
    Private nColPedido    := nColIni + 385
    Private nColNomCli    := nColIni + 455
    //Declarando as fontes
    Private cNomeFont  := 'Arial'
    Private oFontDet   := TFont():New(cNomeFont, 9, -11, .T., .F., 5, .T., 5, .T., .F.)
    Private oFontDetN  := TFont():New(cNomeFont, 9, -13, .T., .T., 5, .T., 5, .T., .F.)
    Private oFontRod   := TFont():New(cNomeFont, 9, -8,  .T., .F., 5, .T., 5, .T., .F.)
    Private oFontMin   := TFont():New(cNomeFont, 9, -7,  .T., .F., 5, .T., 5, .T., .F.)
    Private oFontTit   := TFont():New(cNomeFont, 9, -15, .T., .T., 5, .T., 5, .T., .F.)
     
    //Monta a consulta de dados
    cQryAux := " SELECT "		+ CRLF
	cQryAux += "    B1_COD, "		+ CRLF
	cQryAux += "    B1_DESC, "		+ CRLF
	cQryAux += "    C6_QTDVEN, "		+ CRLF
	cQryAux += "    C5_EMISSAO, "		+ CRLF
	cQryAux += "    C5_NUM, "		+ CRLF
	cQryAux += "    A1_NOME "		+ CRLF
	cQryAux += " FROM "		+ CRLF
	cQryAux += "    " + RetSQLName("SB1") + " SB1 "		+ CRLF
	cQryAux += "    INNER JOIN " + RetSQLName("SC6") + " SC6 ON ( "		+ CRLF
	cQryAux += "        C6_FILIAL = '" + FWxFilial("SC6") + "' "		+ CRLF
	cQryAux += "        AND C6_PRODUTO = B1_COD "		+ CRLF
	cQryAux += "        AND SC6.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryAux += "    ) "		+ CRLF
	cQryAux += "    INNER JOIN " + RetSQLName("SC5") + " SC5 ON ( "		+ CRLF
	cQryAux += "        C5_FILIAL = C6_FILIAL "		+ CRLF
	cQryAux += "        AND C5_NUM = C6_NUM "		+ CRLF
    cQryAux += "        AND C5_TIPO NOT IN ('B', 'D') "		+ CRLF
	cQryAux += "        AND C5_EMISSAO >= '" + dToS(MV_PAR01) + "' "		+ CRLF
	cQryAux += "        AND C5_EMISSAO <= '" + dToS(MV_PAR02) + "' "		+ CRLF
	cQryAux += "        AND SC5.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryAux += "    ) "		+ CRLF
	cQryAux += "    INNER JOIN " + RetSQLName("SA1") + " SA1 ON ( "		+ CRLF
	cQryAux += "        A1_FILIAL = '" + FWxFilial("SA1") + "' "		+ CRLF
	cQryAux += "        AND A1_COD = C5_CLIENTE "		+ CRLF
	cQryAux += "        AND A1_LOJA = C5_LOJACLI "		+ CRLF
	cQryAux += "        AND SA1.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryAux += "    ) "		+ CRLF
	cQryAux += " WHERE "		+ CRLF
	cQryAux += "    B1_FILIAL = '" + FWxFilial("SB1") + "' "		+ CRLF
	cQryAux += "    AND SB1.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryAux += " ORDER BY "		+ CRLF
	cQryAux += "    B1_COD"		+ CRLF
    PLSQuery(cQryAux, 'QRY_AUX')
 
    //Define o tamanho da régua
    DbSelectArea('QRY_AUX')
    QRY_AUX->(DbGoTop())
    Count to nTotAux
    ProcRegua(nTotAux)
    QRY_AUX->(DbGoTop())
     
    //Somente se tiver dados
    If ! QRY_AUX->(EoF())
        //Se for via JOB, muda as parametrizações
        If lJobPvt
            //Define o caminho dentro da protheus data
            cCaminho := "\x_tst\"
            
            //Se não existir a pasta na Protheus Data, cria ela
            If ! ExistDir(cCaminho)
                MakeDir(cCaminho)
            EndIf
            
            //Cria o objeto FWMSPrinter
            oPrintPvt := FWMSPrinter():New(cArquivo, IMP_PDF, .F., '', .T., .F., , , .T., .T., , .F.)
            oPrintPvt:cPathPDF := cCaminho
            
        Else
            //Definindo o diretório como a temporária do S.O.
            cCaminho  := GetTempPath()
            
            //Criando o objeto do FMSPrinter
            oPrintPvt := FWMSPrinter():New(cArquivo, IMP_PDF, .F., "", .T., , @oPrintPvt, "", , , , .T.)
            oPrintPvt:cPathPDF := GetTempPath()
        EndIf
        
        //Efetua outras definições do relatório
        oPrintPvt:SetResolution(72)
        oPrintPvt:SetPortrait()
        oPrintPvt:SetPaperSize(DMPAPER_A4)
        oPrintPvt:SetMargin(0, 0, 0, 0)
 
        //Imprime os dados
        fImpCab()
        While ! QRY_AUX->(EoF())
            nAtuAux++
            IncProc('Imprimindo registro ' + cValToChar(nAtuAux) + ' de ' + cValToChar(nTotAux) + '...')
 
            //Se atingiu o limite, quebra de pagina
            fQuebra()
             
            //Faz o zebrado ao fundo
            If nAtuAux % 2 == 0
                oPrintPvt:FillRect({nLinAtu - 2, nColIni, nLinAtu + 12, nColFin}, oBrushLin)
            EndIf
 
            //Imprime a linha atual
            oPrintPvt:SayAlign(nLinAtu, nColProdut, Alltrim(QRY_AUX->B1_COD),                                     oFontDetN,  70, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColDescri, Alltrim(QRY_AUX->B1_DESC),                                    oFontDet,  125, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColQtdVen, Alltrim(Transform(QRY_AUX->C6_QTDVEN, "@E 999,999,999.99")),  oFontDet,  100, 10, /*nClrText*/, PAD_RIGHT,  /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColDatEmi, dToC(QRY_AUX->C5_EMISSAO),                                    oFontDet,   90, 10, /*nClrText*/, PAD_CENTER, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColPedido, Alltrim(QRY_AUX->C5_NUM),                                     oFontDet,   70, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColNomCli, Alltrim(QRY_AUX->A1_NOME),                                    oFontDet,  125, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
 
            nLinAtu += 15
            oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)
 
            //Se atingiu o limite, quebra de pagina
            fQuebra()
             
            QRY_AUX->(DbSkip())
        EndDo
        fImpRod()
        
        //Se for via job, imprime o arquivo para gerar corretamente o pdf
        If lJobPvt
            oPrintPvt:Print()

            //Aguarda dois segundos e faz o disparo do email
            Sleep(2000)
            cPara     := "contato@atiliosistemas.com"
            cAssunto  := "Listagem de Produtos Vendidos em PDF"
            cMensagem := "Ola.<br>Verifique o arquivo em anexo!<br>Periodo do relatorio: " + dToC(MV_PAR01) + " ate " + dToC(MV_PAR02)
            aAdd(aAnexos, cCaminho + cArquivo)
            GPEMail(cAssunto, cMensagem, cPara, aAnexos)
            
        //Se for via manual, mostra o relatório
        Else
            oPrintPvt:Preview()
        EndIf
    ElseIf ! lJobPvt
        MsgStop('Não foi encontrado informações com os parâmetros informados!', 'Atenção')
    EndIf
    QRY_AUX->(DbCloseArea())
     
    RestArea(aArea)
Return

/*/{Protheus.doc} fLogoEmp
Função que retorna o logo da empresa conforme configuração da DANFE
@author Atilio
@since 18/04/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fLogoEmp()
    Local cLogo       := "\x_imagens\logo.png"
Return cLogo

/*/{Protheus.doc} fImpCab
Função que imprime o cabeçalho do relatório
@author Atilio
@since 18/04/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImpCab()
    Local cTexto   := ''
    Local nLinCab  := 015
     
    //Iniciando Pagina
    oPrintPvt:StartPage()
    
    //Imprime o logo
    If File(cLogoEmp)
        oPrintPvt:SayBitmap(005, nColIni, cLogoEmp, 030, 030)
    EndIf
     
    //Cabecalho
    cTexto := 'Produtos Vendidos'
    oPrintPvt:SayAlign(nLinCab, nColMeio-200, cTexto, oFontTit, 400, 20, , PAD_CENTER, )
     
    //Linha Separatoria
    nLinCab += 020
    oPrintPvt:Line(nLinCab,   nColIni, nLinCab,   nColFin)
     
    //Atualizando a linha inicial do relatorio
    nLinAtu := nLinCab + 5
    
    If nPagAtu == 1
        //Imprimindo os parâmetros
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Data De', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, dToC(MV_PAR01), oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Data Até', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, dToC(MV_PAR02), oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)
        nLinAtu += 5
    EndIf
    
    oPrintPvt:SayAlign(nLinAtu, nColProdut, 'Produto',         oFontMin,  70, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColDescri, 'Descrição',       oFontMin, 125, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColQtdVen, 'Qtde Vendida',    oFontMin, 100, 10, /*nClrText*/, PAD_RIGHT,  /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColDatEmi, 'Emissão',         oFontMin,  90, 10, /*nClrText*/, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColPedido, 'Pedido',          oFontMin,  70, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColNomCli, 'Nome do Cliente', oFontMin, 125, 10, /*nClrText*/, PAD_LEFT,   /*nAlignVert*/)
    nLinAtu += 15
Return

/*/{Protheus.doc} fImpRod
Função que imprime o rodapé e encerra a página
@author Atilio
@since 18/04/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImpRod()
    Local nLinRod:= nLinFin
    Local cTexto := ''
 
    //Linha Separatoria
    oPrintPvt:Line(nLinRod,   nColIni, nLinRod,   nColFin)
    nLinRod += 3
     
    //Dados da Esquerda
    cTexto := dToC(dDataBase) + '     ' + cHoraEx + '     ' + FunName() + ' (zJob06)     ' + UsrRetName(RetCodUsr())
    oPrintPvt:SayAlign(nLinRod, nColIni, cTexto, oFontRod, 500, 10, , PAD_LEFT, )
     
    //Direita
    cTexto := 'Pagina '+cValToChar(nPagAtu)
    oPrintPvt:SayAlign(nLinRod, nColFin-40, cTexto, oFontRod, 040, 10, , PAD_RIGHT, )
     
    //Finalizando a pagina e somando mais um
    oPrintPvt:EndPage()
    nPagAtu++
Return

/*/{Protheus.doc} fQuebra
Função que valida se a linha esta próxima do final, se sim quebra a página
@author Atilio
@since 18/04/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fQuebra()
    If nLinAtu >= nLinFin-10
        fImpRod()
        fImpCab()
    EndIf
Return
