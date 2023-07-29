//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
	
//Constantes
#Define STR_PULA		Chr(13)+Chr(10)
	
/*/{Protheus.doc} relmoeda
Relatrio - Relatorio moedas              
@author zReport
@since 10/07/2023
@version 1.0
	@example
	u_relmoeda()
	@obs Funo gerada pelo zReport()
/*/
	
User Function relmoeda()
	Local aArea   := GetArea()
	Local oReport
	Local lEmail  := .F.
	Local cPara   := ""
	Private cPerg := ""
	
	//Cria as definies do relatrio
	oReport := fReportDef()
	
	//Ser enviado por e-Mail?
	If lEmail
		oReport:nRemoteType := NO_REMOTE
		oReport:cEmail := cPara
		oReport:nDevice := 3 //1-Arquivo,2-Impressora,3-email,4-Planilha e 5-Html
		oReport:SetPreview(.F.)
		oReport:Print(.F., "", .T.)
	//Seno, mostra a tela
	Else
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
Return
	
/*-------------------------------------------------------------------------------*
 | Func:  fReportDef                                                             |
 | Desc:  Funo que monta a definio do relatrio                              |
 *-------------------------------------------------------------------------------*/
	
Static Function fReportDef()
	Local oReport
	Local oSectDad := Nil
	Local oBreak := Nil
	
	//Criao do componente de impresso
	oReport := TReport():New(	"relmoeda",;		//Nome do Relatrio
								"Relatorio moedas",;		//Ttulo
								cPerg,;		//Pergunte ... Se eu defino a pergunta aqui, ser impresso uma pgina com os parmetros, conforme privilgio 101
								{|oReport| fRepPrint(oReport)},;		//Bloco de cdigo que ser executado na confirmao da impresso
								)		//Descrio
	oReport:SetTotalInLine(.F.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9) //Folha A4
	oReport:SetPortrait()
	
	//Criando a seo de dados
	oSectDad := TRSection():New(	oReport,;		//Objeto TReport que a seo pertence
									"Dados",;		//Descrio da seo
									{"QRY_AUX"})		//Tabelas utilizadas, a primeira ser considerada como principal da seo
	oSectDad:SetTotalInLine(.F.)  //Define se os totalizadores sero impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
	//Colunas do relatrio
	TRCell():New(oSectDad, "DATA", "QRY_AUX", "Data", /*Picture*/, 8, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "CAD", "QRY_AUX", "Cad", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "USD", "QRY_AUX", "Usd", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "EUR", "QRY_AUX", "Eur", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "KWD", "QRY_AUX", "Kwd", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "BHD", "QRY_AUX", "Bhd", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "OMR", "QRY_AUX", "Omr", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "JOD", "QRY_AUX", "Jod", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "GBP", "QRY_AUX", "Gbp", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "KYD", "QRY_AUX", "Kyd", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "CHF", "QRY_AUX", "Chf", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
Return oReport
	
/*-------------------------------------------------------------------------------*
 | Func:  fRepPrint                                                              |
 | Desc:  Funo que imprime o relatrio                                         |
 *-------------------------------------------------------------------------------*/
	
Static Function fRepPrint(oReport)
	Local aArea    := GetArea()
	Local cQryAux  := ""
	Local oSectDad := Nil
	Local nAtual   := 0
	Local nTotal   := 0
	
	//Pegando as sees do relatrio
	oSectDad := oReport:Section(1)
	
	//Montando consulta de dados
	cQryAux := ""
	cQryAux += "SELECT M2_DATA AS DATA, M2_MOEDA1 AS CAD, M2_MOEDA2 AS USD, M2_MOEDA3 AS EUR, M2_MOEDA4 AS KWD, M2_MOEDA5 AS BHD, M2_MOEDA6 AS OMR, M2_MOEDA7 AS JOD, M2_MOEDA8 AS GBP, M2_MOEDA9 AS KYD, M2_MOED10 AS CHF"		+ STR_PULA
	cQryAux += "FROM SM2010"		+ STR_PULA
	cQryAux += "WHERE M2_DATA >= DATEADD(DAY, -7, GETDATE());"		+ STR_PULA
	cQryAux := ChangeQuery(cQryAux)
	
	//Executando consulta e setando o total da rgua
	TCQuery cQryAux New Alias "QRY_AUX"
	Count to nTotal
	oReport:SetMeter(nTotal)
	
	//Enquanto houver dados
	oSectDad:Init()
	QRY_AUX->(DbGoTop())
	While ! QRY_AUX->(Eof())
		//Incrementando a rgua
		nAtual++
		oReport:SetMsgPrint("Imprimindo registro "+cValToChar(nAtual)+" de "+cValToChar(nTotal)+"...")
		oReport:IncMeter()
		
		//Imprimindo a linha atual
		oSectDad:PrintLine()
		
		QRY_AUX->(DbSkip())
	EndDo
	oSectDad:Finish()
	QRY_AUX->(DbCloseArea())
	
	RestArea(aArea)
Return
