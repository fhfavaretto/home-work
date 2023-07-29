#INCLUDE 'TOTVS.CH'
#Define STR_PULA		Chr(13)+Chr(10)


//Relatório de admitidos e demitidos no mês;



User Function COMR001()
	Local cDir := ""
  //  Local aPergs := {}

    Local aArea   := GetArea()
    Local cDirIni := GetTempPath()
    Local cTipArq := ""
    Local cTitulo := "Seleção de Pasta para Salvar arquivo"
    Local lSalvar := .F.
    Local cPasta  := ""




	//aAdd(aPergs, {1,"Filial De", cFilDe,"", ".T.", "", ".T.", 10,  .F. })
	//aAdd(aPergs, {1,"Filial Até", cFilAte,"", ".T.", "", ".T.", 10,  .T. })
	//aAdd(aPergs, {1,"Emissão De", dDataDe,"", ".T.", "", ".T.", 10,  .T. })
	//aAdd(aPergs, {1,"Emissão Até", dDataAte,"", ".T.", "", ".T.", 10,  .T. })

//	If ParamBox(aPergs, "Informe os parâmetros",)
	
	
 
        cDir := tFileDialog(;
            cTipArq,;                  // Filtragem de tipos de arquivos que serão selecionados
            cTitulo,;                  // Título da Janela para seleção dos arquivos
            ,;                         // Compatibilidade
            cDirIni,;                  // Diretório inicial da busca de arquivos
            lSalvar,;                  // Se for .T., será uma Save Dialog, senão será Open Dialog
            GETF_RETDIRECTORY;         // Se não passar parâmetro, irá pegar apenas 1 arquivo; Se for informado GETF_MULTISELECT será possível pegar mais de 1 arquivo; Se for informado GETF_RETDIRECTORY será possível selecionar o diretório
        )
 
	If Empty(cDir)
		FWAlertInfo("Escolha um destino valido", "Caminho Invalido")
		Return
	EndIf
	//EndIf
    RestArea(aArea)

	FWMsgRun(, {|oSay| procRel(oSay,cDir)},"Extraindo dados..","Aguarde, processando...")

Return
//
Static Function procRel(oSay,cDir)
    //Local  cFilName := FWFilialName()

	Local oFWMsExcel := FWMSEXCEL():New()
	Local cSheet1 := "teste" //Titulo Relatorio
	Local cArqXls := "teste" +dtos(Date()) +StrTran(Time(),":","") +".xml" //Nome do arquivo
	Local cQuery := ""



	oFWMsExcel:AddworkSheet(cSheet1) // não remover
	oFWMsExcel:AddTable (cSheet1,cSheet1) // nao remover
	oFWMsExcel:AddColumn(cSheet1,cSheet1,"CODIGO",1,1)
	oFWMsExcel:AddColumn(cSheet1,cSheet1,"NOME",1,1)
	oFWMsExcel:AddColumn(cSheet1,cSheet1,"NOME FANTASIA",1,1)
    //oFWMsExcel:AddColumn(cSheet1,cSheet1,"CNPJ/CPF",1,1)



	cQuery := ""
    cQuery += "SELECT A1_COD, A1_NOME, A1_NREDUZ "+STR_PULA
    cQuery += "FROM SA1010"+STR_PULA
	//cQuery += "WHERE D_E_L_E_T_ = ' ' "+STR_PULA
	//cQuery += "ORDER BY A1_COD " +STR_PULA



	cQuery := ChangeQuery(cQuery)
	MpSysOpenQuery(cQuery,"TRB")

	dbSelectArea("TRB")
	dbGoTop()

	While !EOF()
		oFWMsExcel:AddRow(cSheet1,cSheet1, {TRB->A1_COD,TRB->A1_NOME,TRB->A1_NREDUZ})

		dbSkip()
	End

	TRB->(dbCloseArea())

	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cDir +cArqXls)

	If File(cDir +cArqXls)
		FWAlertSuccess("A planilha foi salva em "+cDir+" ", "Arquivo Gravado com Sucesso")
		If !ApOleClient( 'MsExcel' )
			Aviso("Atenção", 'Excel nao instalado' + CRLF +'O arquivo esta localizado em: '+ cDir, {"Ok"} )
		Else
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( cDir +cArqXls )
			oExcelApp:SetVisible(.T.)
			oExcelApp:Destroy()
		EndIf
	EndIf

Return
