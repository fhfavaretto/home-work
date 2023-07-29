//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
	
//Constantes
#Define STR_PULA		Chr(13)+Chr(10)
	
/*/{Protheus.doc} xRelper
Relatrio - Relatorio Fat. Periodo        
@author zReport
@since 21/06/2023
@version 1.0
	@example
	u_xRelper()
	@obs Funo gerada pelo zReport()
/*/
	
User Function xRelper()
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
	oReport := TReport():New(	"xRelper",;		//Nome do Relatrio
								"Relatorio Fat. Periodo",;		//Ttulo
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
	TRCell():New(oSectDad, "D2_FILIAL", "QRY_AUX", "Filial", /*Picture*/, 4, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_ITEM", "QRY_AUX", "Item", /*Picture*/, 2, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_COD", "QRY_AUX", "Produto", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_TOTAL", "QRY_AUX", "Vlr.Total", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_VALIPI", "QRY_AUX", "Vlr.IPI", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_TES", "QRY_AUX", "Tipo Saida", /*Picture*/, 3, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_CF", "QRY_AUX", "Cod. Fiscal", /*Picture*/, 5, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_CLIENTE", "QRY_AUX", "Cliente", /*Picture*/, 6, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_LOJA", "QRY_AUX", "Loja", /*Picture*/, 2, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "A1_NOME", "QRY_AUX", "Nome", /*Picture*/, 40, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_DOC", "QRY_AUX", "Num. Docto.", /*Picture*/, 9, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_SERIE", "QRY_AUX", "Serie", /*Picture*/, 3, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_EMISSAO", "QRY_AUX", "Emissao", /*Picture*/, 8, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_ICMSRET", "QRY_AUX", "ICMS Solid.", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_SEGURO", "QRY_AUX", "Vlr. Seguro", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_VALFRE", "QRY_AUX", "Vlr. Frete", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_DESPESA", "QRY_AUX", "Vlr. Despesa", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_DEL", "QRY_AUX", "D2_del", /*Picture*/, 1, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "A1_DEL", "QRY_AUX", "A1_del", /*Picture*/, 1, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "F4_DUPLIC", "QRY_AUX", "Gera Dupl.", /*Picture*/, 1, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "F4_DEL", "QRY_AUX", "F4_del", /*Picture*/, 1, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_QUANT", "QRY_AUX", "Quantidade", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "A1_NREDUZ", "QRY_AUX", "N Fantasia", /*Picture*/, 20, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_PEDIDO", "QRY_AUX", "No do Pedido", /*Picture*/, 6, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "A1_EST", "QRY_AUX", "Estado", /*Picture*/, 2, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "D2_VALICM", "QRY_AUX", "Vlr.ICMS", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "C6_PRCVEN", "QRY_AUX", "Prc Unitario", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "C6_PRCVEN2", "QRY_AUX", "Preço Unit 2", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "C6_DEL", "QRY_AUX", "C6_del", /*Picture*/, 1, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
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
	cQryAux += "SELECT DISTINCT                       SD2010.D2_FILIAL, SD2010.D2_ITEM, SD2010.D2_COD, SD2010.D2_TOTAL, SD2010.D2_VALIPI, SD2010.D2_TES, SD2010.D2_CF,                       SD2010.D2_CLIENTE, SD2010.D2_LOJA, SA1010.A1_NOME, SD2010.D2_DOC, SD2010.D2_SERIE, SD2010.D2_EMISSAO,                       SD2010.D2_ICMSRET, SD2010.D2_SEGURO, SD2010.D2_VALFRE, SD2010.D2_DESPESA, SD2010.D_E_L_E_T_ AS D2_DEL,                       SA1010.D_E_L_E_T_ AS A1_DEL, SF4010.F4_DUPLIC, SF4010.D_E_L_E_T_ AS F4_DEL, SD2010.D2_QUANT, SA1010.A1_NREDUZ,                       SD2010.D2_PEDIDO, SA1010.A1_EST, SD2010.D2_VALICM, SC6010.C6_PRCVEN, SC6010.C6_PRCVEN2, SC6010.D_E_L_E_T_ AS C6_DEL FROM         SD2010 INNER JOIN                       SA1010 ON SD2010.D2_CLIENTE = SA1010.A1_COD AND SD2010.D2_LOJA = SA1010.A1_LOJA INNER JOIN                       SF4010 ON SD2010.D2_TES = SF4010.F4_CODIGO INNER JOIN                       SC6010 ON SD2010.D2_FILIAL = SC6010.C6_FILIAL AND SD2010.D2_COD = SC6010.C6_PRODUTO AND                       SD2010.D2_PEDIDO = SC6010.C6_NUM AND SD2010.D2_ITEMPV = SC6010.C6_ITEM WHERE     (SD2010.D_E_L_E_T_ = '') AND (SA1010.D_E_L_E_T_ = '') AND (SF4010.F4_DUPLIC = 'S' OR SF4010.F4_CODIGO = '995') AND (SF4010.D_E_L_E_T_ = '') AND (SC6010.D_E_L_E_T_ = '') AND                       (SD2010.D2_EMISSAO BETWEEN '20230501' AND '20230531') AND                       (SD2010.D2_SERIE   BETWEEN '   ' AND 'ZZZ') AND                      (SD2010.D2_CLIENTE   BETWEEN '      ' AND 'ZZZZZZ') AND                       (SD2010.D2_LOJA      BETWEEN '  ' AND 'ZZ') ORDER BY  SD2010.D2_FILIAL,  SD2010.D2_EMISSAO,   SD2010.D2_SERIE,  SD2010.D2_DOC,   SA1010.A1_NOME, SD2010.D2_CF"		+ STR_PULA
	cQryAux := ChangeQuery(cQryAux)
	
	//Executando consulta e setando o total da rgua
	TCQuery cQryAux New Alias "QRY_AUX"
	Count to nTotal
	oReport:SetMeter(nTotal)
	TCSetField("QRY_AUX", "D2_EMISSAO", "D")
	
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
