#INCLUDE "TOTVS.CH"

#define FT_NAME	1 
#define FT_DATE	3
#define FT_TIME	4

static __cSlash    as character
static __cDirIN    as character
static __cNumSeq   as character
static __aCodEdi   as array
static __aExcEdi   as array
static __lCkoRepro as logical
   
User Function xmlInnip()
    Local aArea     := GetArea()
    Local aParamBox := {}

    // barra de acordo com S.O.
    __cSlash := iIf(IsSrvUnix(), "/", "\")

    // diretório para cópia dos arquivos
    __cDirIN := allTrim(getNewPar("MV_NGINN", "/importadorxml/inn"))
    __cDirIN := iIf(empty(__cDirIN), "/importadorxml/inn", __cDirIN)

    // valida se possui barra ao final
    if (right(__cDirIN, 01) != __cSlash)
        __cDirIN += __cSlash
    endIf

    // caso não exista, cria diretório
    if (!existDir(__cDirIN))
        FWMakeDir(__cDirIN, .F.)
    endIf

    // códigos EDI
    __aCodEdi := &(GetNewPar("MV_COLEDI",'{}'))
    __aExcEdi := &(GetNewPar("MV_EXCEDI",'{}'))

    __lCkoRepro := CKO->(FieldPos("CKO_DOC")) > 0 .AND.;
        CKO->(FieldPos("CKO_SERIE")) > 0 .AND.;
        CKO->(FieldPos("CKO_NOMFOR")) > 0 .AND.;
        !Empty(SDS->(IndexKey(4)))

    __cNumSeq := FWTimeStamp() + StrZero( Randomize(0,999),3 ) + "_0000"
     
    //Adicionando os parâmetros que serão utilizados
    aAdd( aParamBox,{3,"Tipo de página", 1,{"Importar Pasta","Importar Arquivo"},60,"",.T.} )
     
    //Se a pergunta for confirmada
    If ParamBox( aParamBox, "TRANSFERENCIA XML PARA SERVIDOR")
        Processa({|| openFileOrDir(MV_PAR01 == 01)}, "Processando...")
    endIf
     
    RestArea(aArea)
Return

/*/{Protheus.doc} openFileOrDir
    rotina responsável por selecionar diretório ou um único arquivo
    @type  Function
    @author Alison Kaique
    @since Oct|22
    @version 1.0

    @param lDir, logical, abre diretório?
/*/
static function openFileOrDir(lDir as logical)
    local cReturn   as character // diretório ou arquivo selecionado
    local cStart    as character // diretório inicial
    local cMessages as character // mensagens de processamento
    local cDriveXML as character // drive XML
    local cDirXML   as character // diretório XML
    local aFiles    as array // arquivos no diretório
    local nCount    as numeric // quantidade de arquivos
    local nIndex    as numeric // índice do arquivo sendo processado

    cStart    := allTrim(getTempPath())
    cMessages := ''

    // valida se possui barra ao final
    if (right(cStart, 01) != __cSlash)
        cStart += __cSlash
    endIf

    // abrir dialog
    cReturn := tFileDialog('All XML Files (*.xml)',;
        iIf(lDir, 'Selecione Diretório com Arquivos XML', 'Selecione Arquivo XML'),;
        ,;
        cStart,;
        .F.,;
        iIf(lDir, GETF_RETDIRECTORY, nil))

    // valida se selecionou algo
    if (!empty(cReturn))
        cReturn := allTrim(cReturn)
        
        // valida se possui barra ao final
        if (lDir .AND. right(cReturn, 01) != __cSlash)
            cReturn += __cSlash
        endIf

        // caso seja diretório, irá recuperar os arquivos
        if (lDir)
            aFiles  := directory(cReturn + "*.xml")
            cDirXML := cReturn
        else
            aFiles  := directory(cReturn)
            cDirXML := ''

            // recupera o diretório XML
            splitPath(cReturn, cDriveXML, cDirXML, /*name*/, /*extension*/)

            cDirXML := allTrim(cDriveXML) + allTrim(cDirXML)

            // valida se possui barra ao final
            if (right(cDirXML, 01) != __cSlash)
                cDirXML += __cSlash
            endIf
        endIf

        // recupera quantidade de arquivos
        nCount := len(aFiles)

        if (nCount > 0)
            procRegua(nCount)

            // percorre arquivos
            for nIndex := 01 to nCount
                // incrementa régua
                incProc('Lendo XML ' + cValToChar(nIndex) + '/' + cValToChar(nCount))

                // verifica se é arquivo
                if (aFiles[nIndex, 05] == 'A')
                    cMessages += 'Arquivo ' + cReturn + aFiles[nIndex, 01] + CRLF + CRLF
                    validXML(aFiles[nIndex], cDirXML, @cMessages)
                    cMessages += replicate('-', 10)  + CRLF
                endIf
            next nIndex
        else
            cMessages += 'Não foram encontrados arquivos no diretório selecionado.' + CRLF
        endIf
    endIf

    // mensagens de processamento
    aviso('TRANSFERENCIA XML PARA SERVIDOR', cMessages, {'OK'}, 03)
return

/*/{Protheus.doc} validXML
    rotina responsável por validar o XML
    @type  Function
    @author Alison Kaique
    @since Oct|22
    @version 1.0

    @param aFileData, array    , dados do arquivo
    @param cDirXML  , character, diretório XML
    @param cMessages, character, mensagens de processamento

    @return isValid, logical, arquivo válido?
/*/
static function validXML(aFileData as array, cDirXML as character, cMessages as character) as logical
    local isValid     as logical // arquiv válido
    local cFileOrigin as character // nome do arquivo na origem
    local cFileDest   as character // nome do arquivo no destino
    
    isValid := processFile(@aFileData, cDirXML, @cMessages)

    // copiar para a pasta
    if (isValid)
        cFileOrigin := allTrim(iIf(len(aFileData) >= 06, aFileData[06], aFileData[FT_NAME]))
        cFileDest   := allTrim(aFileData[FT_NAME])

        if (__copyFile(cDirXML + cFileOrigin, __cDirIN + cFileDest))
            cMessages += 'Copiado com sucesso com nome (' + cFileDest + ').' + CRLF
        else
            cMessages += 'Erro na Cópia.' + CRLF
        endIf
    endIf
return isValid

/*/{Protheus.doc} processFile
    rotina responsável por processar arquivo
    @type  Function
    @author Alison Kaique
    @since Oct|22
    @version 1.0

    @param aFileData, array    , dados do arquivo
    @param cDirXML  , character, diretório XML
    @param cMessages, character, mensagens de processamento

    @return isValid, logical, arquivo válido?
/*/
static function processFile(aFileData as array, cDirXML as character, cMessages as character) as logical
    local isValid  as logical
    local lNewReg  as logical
    local lGrvCKO  as logical
    local nOrder1  as numeric
    local nRecno1  as numeric
    local aCKOData as array
    local cXMl     as character
    local cNameArq as character
    local lImpXML  as logical	
    
    isValid  := .T.
    lNewReg  := .T.
    lGrvCKO  := .T.
    nOrder1  := 0
    nRecno1  := 0
    aCKOData := {}
    cXMl     := ""
    cNameArq := ""
    lImpXML  := CKO->(FieldPos("CKO_ARQXML")) > 0 .AND.;
        !empty(CKO->(IndexKey(5)))

    if convfile(@cXMl, aFileData[FT_NAME], cDirXML, @cMessages)
        nOrder1	:= CKO->(indexOrd())
        nRecno1	:= CKO->(recno())

        // Utilizando o Importador XML é realizada a conversão da nomenclatura do nome
        // do arquivo para que seja interpretado igual ao Totvs Colaboração.	
        If lImpXML
            aFileData := changeFileName(cXMl, @aFileData)
        endIf

        cNameArq := PadR(Lower(aFileData[1]),Len(CKO->CKO_ARQUIV))  

        If subStr(cNameArq,Len(cNameArq)-3,4) <> ".xml"
            cNameArq := PadR(lower(subStr(aFileData[1],1,26)+".xml"), LEN(CKO->CKO_ARQUIV))
        endIf
            
        CKO->(dbSetorder(01)) // CKO_ARQUIV + CKO_STATUS
        if CKO->(dbseek(cNameArq))
            lNewReg	:= .F.
            lGrvCKO := Iif(CKO->CKO_FLAG<>'1',.T.,.F.)	
        endIf
        
        If lImpXML .AND. empty(__aCodEdi)
            __aCodEdi := {"109","214","273","005","252"}
        endIf

        // Verifica se tipo de XML está configurado para ser importado
        If !empty(__aCodEdi)
            If aScan(__aCodEdi,{|x| allTrim(x) == allTrim(subStr(cNameArq, 01, 03))}) == 0
                lGrvCKO := .F.
            endIf
        endIf

        // Verifica se tipo de XML não está configurado como excessão de importação
        If !empty(__aExcEdi)
            If aScan(__aExcEdi,{|x| allTrim(x) == allTrim(subStr(cNameArq, 01, 03))}) > 0
                lGrvCKO   := .F.
                isValid   := .F.
                cMessages += "Tipo de arquivo configurado para não ser processado (MV_EXCEDI)." + CRLF
            endIf
        endIf

        lGrvCKO := .F.

        If lGrvCKO
            Begin Transaction
                
                if (reclock("CKO", lNewReg))
                    CKO->CKO_ARQUIV	:= cNameArq
                    CKO->CKO_CODEDI	:= subStr(cNameArq,1,3)
                    CKO->CKO_XMLRET	:= cXMl
                    CKO->CKO_DT_RET	:= aFileData[FT_DATE] //Data do arquivo
                    CKO->CKO_HR_RET	:= aFileData[FT_TIME] //Hora do arquivo
                    CKO->CKO_DT_IMP	:= Date() //Data da importacao pelo Schedule
                    CKO->CKO_HR_IMP	:= Time() //Hora da importacao pelo Schedule
                    CKO->CKO_STATUS	:= ColCKOStatus()[2][1]
                    CKO->CKO_DESSTA	:= ColCKOStatus()[2][2]
                    CKO->CKO_FLAG	:= "0"
                    
                    If lImpXML //Gravação do nome do arquivo original pelo Importador XML
                        CKO->CKO_ARQXML := aFileData[6] 
                    endIf

                    If __lCkoRepro
                        aCKOData := COLGRVDADOS(cXML,1)
                        If Len(aCKOData) > 0
                            CKO->CKO_DOC	:= aCKOData[1]
                            CKO->CKO_SERIE	:= aCKOData[2]
                            CKO->CKO_NOMFOR	:= aCKOData[3]
                        endIf
                    endIf

                    //Gravação Empresa/Filial
                    aCKOData := COLGRVDADOS(cXML,2)
                    If Len(aCKOData) > 0
                        CKO->CKO_EMPPRO	:= aCKOData[1]
                        CKO->CKO_FILPRO	:= aCKOData[2]
                    endIf
                    CKO->( msUnlock() )
                endIf       
            End Transaction
        endIf	
        
        CKQ->(dbSetOrder(nOrder1))
        CKQ->(dbGoTo(nRecno1))
        
        MsUnLockAll()
    else
        isValid := .F.
        cMessages += 'Erro na Conversão do Arquivo.' + CRLF
    endIf
return isValid

/*/{Protheus.doc} convfile
    rotina responsável por converter arquivo XML em string
    @type  Function
    @author Alison Kaique
    @since Oct|22
    @version 1.0

    @param cXml     , character, buffer XML
    @param cFile    , character, arquivo XML
    @param cDirXML  , character, diretório XML
    @param cMessages, character, mensagens de processamento

    @return isValid , logical  , arquivo válido?
/*/
static function convfile(cXML as character, cFile as character,;
    cDirXML as character, cMessages as character) as logical
    local oFile   as object // objeto do arquivo
    local isValid as logical // arquivo válido?

    oFile := FWFileReader():new(cDirXML + cFile)

    if (oFile:open())
        cXML := ''

        while (oFile:hasLine())
            cXML += oFile:getLine() + CRLF
        endDo

        oFile:close()

        isValid := .T.
    else
        cMessages += 'Erro na Abertura do Arquivo' + CRLF
    endIf
return isValid

/*/{Protheus.doc} getSeq
    rotina responsável por retornar sequencial do arquivo
    @type  Function
    @author Alison Kaique
    @since Oct|22
    @version 1.0

    @param cCodEdi, character, código EDI
    
    @return cArq  , character, sequencial do arquivo
/*/
static function getSeq(cCodEdi as character) as character
    local aArea     as array
    local cArq      as character
    
    aArea     := GetArea()
    __cNumSeq := left(__cNumSeq, len(__cNumSeq) - 04) + soma1(right(__cNumSeq, 04))
    cArq      := cCodEdi + __cNumSeq + ".xml"
    
    RestArea(aArea)
return cArq

/*/{Protheus.doc} changeFileName
    rotina responsável por efetuar a conversão do nome do arquivo XML
    para interpretar igual ao Totvs Colaboração
    @type  Function
    @author Alison Kaique
    @since Oct|22
    @version 1.0

    @param cXml     , character, buffer XML
    @param aFileData, array    , dados do arquivo

    @return aFileData, array   , dados do arquivo
/*/
static function changeFileName(cXml, aFileData) as array
    local nPosPesq  as numeric
    local cXMLEncod as character
    local cError    as character
    local cWarning  as character
    local cCodEdi   as character
    local aArea     as array
    local oFullXML  as object
    local oXml252   as object
    local cXML252   as character
    local nTag      as numeric

    nPosPesq  := 0
    cXMLEncod := ""
    cError    := ""
    cWarning  := ""
    cCodEdi   := ""
    aArea     := GetArea()
    oFullXML  := Nil
    oXml252   := Nil
    cXML252   := Nil
    nTag      := 0

    If SubStr(cXml,1,1) != "<"
        nPosPesq := At("<",cXml)
        cXml     := SubStr(cXml,nPosPesq,Len(cXml)) // Remove caracteres estranhos antes da abertura da tag inicial do arquivo
    EndIf

    cXMLEncod := EncodeUtf8(cXml)

    If Empty(cXMLEncod)
        cXMLEncod 	:= cXml
        cXml 		:= A140IRemASC(cXMLEncod)
        cXMLEncod 	:= EncodeUtf8(cXml)
    EndIf

    If !Empty(cXMLEncod)
        oFullXML := XmlParser(cXMLEncod,"_",@cError,@cWarning)
    EndIf

    //Verifica se estar importando uma NFE ou CTE
    If ValType(oFullXML) == "O"
        Do Case
            Case ValType(XmlChildEx(oFullXML,"_NFEPROC")) == "O" //-- Nota normal, devolucao, beneficiamento, bonificacao
                cCodEdi := "109_"
            Case ValType(XmlChildEx(oFullXML,"_CTE")) == "O" //-- Nota de transporte
                cCodEdi := "214_"		
            Case ValType(XmlChildEx(oFullXML,"_CTEPROC")) == "O" //-- Nota de transporte
                cCodEdi := "214_"
            Case ValType(XmlChildEx(oFullXML,"_CTEOSPROC")) == "O" //-- Nota de transporte CTEOS
                cCodEdi := "273_"
            Case !Empty(AScan(ClassDataArr(oFullXML), {|Att| AllTrim(Upper(Att[1])) == "_BUSINESSCONTENT"})) .And. ValType(XmlChildEx(oFullXML:_BUSINESSCONTENT,"_CUSTOMERGOVINFO")) == "O" .And. ValType(XmlChildEx(oFullXML:_BUSINESSCONTENT,"_ORDERID")) == "O" //-- Pedido de Vendas
                cCodEdi := "005_"
            Case !Empty(AScan(ClassDataArr(oFullXML), {|Att| AllTrim(Upper(Att[1])) == "_BUSINESSCONTENT"})) .And. ValType(XmlChildEx(oFullXML:_BUSINESSCONTENT,"_FUNCMSGPROG")) == "O" //-- Programacao de Entrega
                cCodEdi := "252_"
            Case !Empty(AScan(ClassDataArr(oFullXML), {|Att| AllTrim(Upper(Att[1])) == "_BUSINESSEVENT"}))
                cXml252 := cXMLEncod
                nTag := At('</BusinessEvent>',cXml252)
                If nTag <> 0
                    cXml252 := SubStr(cXml252,nTag+16)
                EndIf
                oXML := XMLParser( cXml252, "_", @cError, @cWarning )
                If oXML <> Nil .And. ;
                Empty(cError) .And. ;
                Empty(cWarning) .And. ;
                !Empty(AScan(ClassDataArr(oXML), {|Att| AllTrim(Upper(Att[1])) == "_BUSINESSCONTENT"})) .And. ;
                ValType(XmlChildEx(oXML:_BUSINESSCONTENT,"_FUNCMSGPROG")) == "O" //-- Programacao de Entrega
                    cCodEdi := "252_"
                EndIf
        EndCase
    Endif

    //Busca pelo arquivo original, verificando se ja foi importado
    CKO->(DbSetOrder(5))
    If CKO->(dbseek(PadR(lower(aFileData[1]),LEN(CKO->CKO_ARQXML)))) .Or. CKO->(dbseek(PadR(upper(aFileData[1]),LEN(CKO->CKO_ARQXML)))) .Or. ;
        CKO->(dbseek(PadR(aFileData[1],LEN(CKO->CKO_ARQXML))))
        aAdd(aFileData,PadR(lower(aFileData[1]),LEN(CKO->CKO_ARQXML)))
        aFileData[1] := CKO->CKO_ARQUIV
    Else
        aAdd(aFileData,PadR(lower(aFileData[1]),LEN(CKO->CKO_ARQXML)))
        aFileData[1] := getSeq(cCodEdi)
    Endif

    RestArea(aArea)

    oFullXML := Nil
    oXML252  := Nil
    DelClassIntF()
Return aFileData
