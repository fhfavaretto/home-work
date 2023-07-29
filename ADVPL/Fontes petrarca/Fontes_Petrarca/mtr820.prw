#INCLUDE "MATR820.CH"
#INCLUDE "FIVEWIN.CH"

Static cAliasTop

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � MTR820  � Autor � Paulo Boschetti       � Data � 07.07.92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ordens de Producao                                         ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe e � MTR820(void)                                              ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
User Function Mtr820()
Local titulo  := STR0039 //"Ordens de Producao"
Local cString := "SC2"
Local wnrel   := "MTR820"
Local cDesc   := STR0001	//"Este programa ira imprimir a Rela��o das Ordens de Produ��o"
Local aOrd    := {STR0002,STR0003,STR0004,STR0005}	//"Por Numero"###"Por Produto"###"Por Centro de Custo"###"Por Prazo de Entrega"
Local tamanho := "P"

Private aReturn  := {STR0006,1,STR0007, 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"
Private cPerg    :="MTR820"
Private nLastKey := 0
Private lItemNeg := .F.
//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
pergunte("MTR820",.F.)
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01            // Da OP                                 �
//� mv_par02            // Ate a OP                              �
//� mv_par03            // Da data                               �
//� mv_par04            // Ate a data                            �
//� mv_par05            // Imprime roteiro de operacoes          �
//� mv_par06            // Imprime codigo de barras              �
//� mv_par07            // Imprime Nome Cientifico               �
//� mv_par08            // Imprime Op Encerrada                  �
//� mv_par09            // Impr. por Ordem de                    �
//� mv_par10            // Impr. OP's Firmes, Previstas ou Ambas �
//� mv_par11            // Impr. Item Negativo na Estrutura      �
//����������������������������������������������������������������
If !ChkFile("SH8",.F.)
	Help(" ",1,"SH8EmUso")
	Return
Endif
//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc,"","",.F.,aOrd,.F.,Tamanho)

lItemNeg := GetMv("MV_NEGESTR") .And. mv_par11 == 1

If nLastKey == 27
	dbSelectArea("SH8")
	dbClearFilter()
	dbCloseArea()
	//��������������������������������������������������������������Ŀ
	//� Retira o SH8 da variavel cFopened ref. a abertura no MNU     �
	//����������������������������������������������������������������
	ClosFile("SH8")
	dbSelectArea("SC2")
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	dbSelectArea("SH8")
	dbClearFilter()
	dbCloseArea()
	//��������������������������������������������������������������Ŀ
	//� Retira o SH8 da variavel cFopened ref. a abertura no MNU     �
	//����������������������������������������������������������������
	ClosFile("SH8")
	dbSelectArea("SC2")
	Return
Endif

RptStatus({|lEnd| R820Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � R820Imp  � Autor � Waldemiro L. Lustosa  � Data � 13.11.95 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relat�rio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820			                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function R820Imp(lEnd,wnRel,titulo,tamanho)

//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Local CbCont,cabec1,cabec2
Local limite     := 80
Local nQuant     := 1
Local nomeprog   := "MTR820"
Local nTipo      := 18
Local cProduto   := SPACE(LEN(SC2->C2_PRODUTO))
Local cQtd,i,nBegin
Local cIndSC2    := CriaTrab(NIL,.F.), nIndSC2

#IFDEF TOP
	Local bBlockFiltro := {|| .T.}
#ENDIF	

Private aArray   := {}
Private li       := 80

cAliasTop  := "SC2"

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para Impressao do Cabecalho e Rodape    �
//����������������������������������������������������������������
cbtxt    := SPACE(10)
cbcont   := 0
m_pag    := 0
//��������������������������������������������������������������Ŀ
//� Monta os Cabecalhos                                          �
//����������������������������������������������������������������
cabec1 := ""
cabec2 := ""

dbSelectArea("SC2")

#IFDEF TOP
	cAliasTop := GetNextAlias()
	cQuery := "SELECT SC2.C2_FILIAL, SC2.C2_NUM, SC2.C2_ITEM, SC2.C2_SEQUEN, SC2.C2_ITEMGRD, SC2.C2_DATPRF, "
	cQuery += "SC2.C2_DATRF, SC2.C2_PRODUTO, SC2.C2_DESTINA, SC2.C2_PEDIDO, SC2.C2_ROTEIRO, SC2.C2_QUJE, "
	cQuery += "SC2.C2_PERDA, SC2.C2_QUANT, SC2.C2_DATPRI, SC2.C2_CC, SC2.C2_DATAJI, SC2.C2_DATAJF, "
	cQuery += "SC2.C2_STATUS, SC2.C2_OBS, SC2.C2_TPOP, SC2.C2_COR, SC2.C2_MATPRIM, SC2.C2_ACABAME, SC2.C2_RECEITA, "
	cQuery += "SC2.C2_GRAVTIN, SC2.C2_PRODHOR, SC2.C2_PRODTOT, SC2.C2_CONSMPH, SC2.C2_CONSMPT, SC2.C2_CICLO, "
    cQuery += "SC2.C2_CAVIDAD, SC2.C2_PESOLIQ, SC2.C2_PESOBRU, SC2.C2_ENTREG1, SC2.C2_ENTREG2, SC2.C2_ENTREG3, "
	cQuery += "SC2.C2_ENTREG4, SC2.C2_QTDPV1, SC2.C2_QTDPV2, SC2.C2_QTDPV3, SC2.C2_QTDPV4, SC2.C2_CLIPV1, "
	cQuery += "SC2.C2_CLIPV2, SC2.C2_CLIPV3, SC2.C2_CLIPV4, SC2.C2_USUARIO, SC2.C2_INFTRYO, "
	cQuery += "SC2.R_E_C_N_O_  SC2RECNO, SC2.C2_XACAB, SC2.C2_XTON, SC2.C2_XCODCOR, SC2.C2_XTABCOR, SC2.C2_XOBS " 
	cQuery += "FROM "+RetSqlName("SC2")+" SC2 WHERE "
	cQuery += "SC2.C2_FILIAL='"+xFilial("SC2")+"' AND SC2.D_E_L_E_T_=' ' AND "
	If	Upper(TcGetDb()) $ 'ORACLE,DB2,POSTGRES,INFORMIX'
		cQuery += "SC2.C2_NUM || SC2.C2_ITEM || SC2.C2_SEQUEN || SC2.C2_ITEMGRD >= '" + mv_par01 + "' AND "
		cQuery += "SC2.C2_NUM || SC2.C2_ITEM || SC2.C2_SEQUEN || SC2.C2_ITEMGRD <= '" + mv_par02 + "' AND "
	Endif
	cQuery += "SC2.C2_DATPRF BETWEEN '" + Dtos(mv_par03) + "' AND '" + Dtos(mv_par04) + "' "
	If mv_par08 == 2
		cQuery += "AND SC2.C2_DATRF = ' '"
	Endif	
	If aReturn[8] == 4
		cQuery += "ORDER BY SC2.C2_FILIAL+SC2.C2_DATPRF"
	Else
		cQuery += "ORDER BY " + SqlOrder(SC2->(IndexKey(aReturn[8])))
	EndIf
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTop,.T.,.T.)
	aEval(SC2->(dbStruct()), {|x| If(x[2] <> "C" .And. FieldPos(x[1]) > 0, TcSetField(cAliasTop,x[1],x[2],x[3],x[4]),Nil)})
	dbSelectArea(cAliasTop)
#ELSE
	If aReturn[8] == 4
		IndRegua("SC2",cIndSC2,"C2_FILIAL+DTOS(C2_DATPRF)",,,STR0008)	//"Selecionando Registros..."
	Else
		dbSetOrder(aReturn[8])
	EndIf
	dbSeek(xFilial("SC2"))
#ENDIF

If ! Empty(aReturn[7])
	bBlockFiltro := &("{|| " + aReturn[7] + "}")
Endif	

SetRegua(SC2->(LastRec()))

While !Eof()
	
	IF lEnd
		@ Prow()+1,001 PSay STR0009	//"CANCELADO PELO OPERADOR"
		Exit
	EndIF
	
	IncRegua()
	

	If C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD < xFilial('SC2')+mv_par01 .or. C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD > xFilial('SC2')+mv_par02
		dbSkip()
		Loop
	EndIf   
		
	#IFNDEF TOP		
		If  C2_DATPRF < mv_par03 .Or. C2_DATPRF > mv_par04
			dbSkip()
			Loop
		Endif
		
		If !(Empty(C2_DATRF)) .And. mv_par08 == 2
			dbSkip()
			Loop
		Endif
	#ENDIF

	If !Empty(aReturn[7])
		#IFDEF TOP
			SC2->(dbGoto((cAliasTop)->SC2RECNO))
		#ENDIF	

		If !(SC2->(Eval(bBlockFiltro)))
			(cAliasTop)->(dbSkip())
			Loop                 
		EndIf	
	Endif	

	//-- Valida se a OP deve ser Impressa ou n�o
	If !MtrAValOP(mv_par10,"SC2",cAliasTop)
		dbSkip()
		Loop
	EndIf
	
	cProduto  := C2_PRODUTO
	nQuant    := aSC2Sld(cAliasTop)
	
	dbSelectArea("SB1")
	dbSeek(xFilial()+cProduto)
	
	//��������������������������������������������������������������Ŀ
	//� Adiciona o primeiro elemento da estrutura , ou seja , o Pai  �
	//����������������������������������������������������������������
	AddAr820(nQuant)
	
	MontStruc((cAliasTop)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD),nQuant)
	
	If mv_par09 == 1
		aSort( aArray,2,, { |x, y| (x[1]+x[8]) < (y[1]+y[8]) } )
	Else
		aSort( aArray,2,, { |x, y| (x[8]+x[1]) < (y[8]+y[1]) } )
	ENDIF
	
	//���������������������������������������������������������Ŀ
	//� Imprime cabecalho                                       �
	//�����������������������������������������������������������
	cabecOp(Tamanho)
	
	For I := 2 TO Len(aArray)
		
		@Li ,   0 PSay aArray[I][1]    	 				   	// CODIGO PRODUTO
		For nBegin := 1 To Len(Alltrim(aArray[I][2])) Step 31
			@li,016 PSay Substr(aArray[I][2],nBegin,31)
			li++
		Next nBegin
		Li--
		cQtd := Alltrim(Transform(aArray[I][5],PesqPictQt("D4_QUANT",14)))
		@Li , (46+11-Len(cQtd)) PSay cQtd					// QUANTIDADE
		@Li ,  57 PSay "|"+aArray[I][4]+"|"			  	// UNIDADE DE MEDIDA
		@li ,  61 PSay aArray[I][6]+"|"                  	// ALMOXARIFADO
		@li ,  64 PSay Substr(aArray[I][7],1,12)         	// LOCALIZACAO
		@li ,  76 PSay "|"+aArray[I][8]                  	// SEQUENCIA
		Li++
		@Li ,  00 PSay __PrtThinLine()
		Li++
		   
		//���������������������������������������������������������Ŀ
		//� Se nao couber, salta para proxima folha                 �
		//�����������������������������������������������������������
		IF li > 63
			Li := 0
			CabecOp(Tamanho)		// imprime cabecalho da OP
		EndIF
		
	Next I
	
	If mv_par05 == 1
		RotOper()   	// IMPRIME ROTEIRO DAS OPERACOES
	Endif
	
	//��������������������������������������������������������������Ŀ
	//� Imprimir Relacao de medidas para Cliente == HUNTER DOUGLAS.  �
	//����������������������������������������������������������������
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek("SMX")
	If Found() .And. (cAliasTop)->C2_DESTINA == "P"
		R820Medidas()
	EndIf
	
*	m_pag++
	Li := 0					// linha inicial - ejeta automatico
	aArray:={}
	
	dbSelectArea(cAliasTop)
	dbSkip()
	
EndDO

dbSelectArea("SH8")
dbCloseArea()

//��������������������������������������������������������������Ŀ
//� Retira o SH8 da variavel cFopened ref. a abertura no MNU     �
//����������������������������������������������������������������
ClosFile("SH8")

dbSelectArea("SC2")
#IFDEF TOP
	(cAliasTop)->(dbCloseArea())
#ELSE	
	If aReturn[8] == 4
		RetIndex("SC2")
		Ferase(cIndSC2+OrdBagExt())
	EndIf
#ENDIF
dbClearFilter()
dbSetOrder(1)

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return NIL

/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   � AddAr820 � Autor � Paulo Boschetti       � Data � 07/07/92 ���
�������������������������������������������������������������������������Ĵ��
��� Descri��o� Adiciona um elemento ao Array                              ���
�������������������������������������������������������������������������Ĵ��
��� Sintaxe  � AddAr820(ExpN1)                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpN1 = Quantidade da estrutura                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
Static Function AddAr820(nQuantItem)
Local cDesc := SB1->B1_DESC
Local cRoteiro:=""
//�����������������������������������������������������������Ŀ
//� Verifica se imprime nome cientifico do produto. Se Sim    �
//� verifica se existe registro no SB5 e se nao esta vazio    �
//�������������������������������������������������������������
If mv_par07 == 1
	dbSelectArea("SB5")
	dbSeek(xFilial()+SB1->B1_COD)
	If Found() .and. !Empty(B5_CEME)
		cDesc := B5_CEME
	EndIf
ElseIf mv_par07 == 2
	cDesc := SB1->B1_DESC
Else
	//�����������������������������������������������������������Ŀ
	//� Verifica se imprime descricao digitada ped.venda, se sim  �
	//� verifica se existe registro no SC6 e se nao esta vazio    �
	//�������������������������������������������������������������
	If (cAliasTop)->C2_DESTINA == "P"
		dbSelectArea("SC6")
		dbSetOrder(1)
		dbSeek(xFilial()+(cAliasTop)->C2_PEDIDO+(cAliasTop)->C2_ITEM)
		If Found() .and. !Empty(C6_DESCRI) .and. C6_PRODUTO==SB1->B1_COD
			cDesc := C6_DESCRI
		ElseIf C6_PRODUTO # SB1->B1_COD
			dbSelectArea("SB5")
			dbSeek(xFilial()+SB1->B1_COD)
			If Found() .and. !Empty(B5_CEME)
				cDesc := B5_CEME
			EndIf
		EndIf
	EndIf
EndIf

//�����������������������������������������������������������Ŀ
//� Verifica se imprime ROTEIRO da OP ou PADRAO do produto    �
//�������������������������������������������������������������
If !Empty((cAliasTop)->C2_ROTEIRO)
	cRoteiro:=(cAliasTop)->C2_ROTEIRO
Else
	If !Empty(SB1->B1_OPERPAD)
		cRoteiro:=SB1->B1_OPERPAD
	Else
		dbSelectArea("SG2")
		If dbSeek(xFilial()+(cAliasTop)->C2_PRODUTO+"01")
			RecLock("SB1",.F.)
			Replace B1_OPERPAD With "01"
			MsUnLock()
			cRoteiro:="01"
		EndIf
	EndIf
EndIf

dbSelectArea("SB2")
dbSeek(xFilial()+SB1->B1_COD+SD4->D4_LOCAL)
dbSelectArea("SD4")
AADD(aArray, {SB1->B1_COD,cDesc,SB1->B1_TIPO,SB1->B1_UM,nQuantItem,D4_LOCAL,SB2->B2_LOCALIZ,D4_TRT,cRoteiro } )

/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   � MontStruc� Autor � Ary Medeiros          � Data � 19/10/93 ���
�������������������������������������������������������������������������Ĵ��
��� Descri��o� Monta um array com a estrutura do produto                  ���
�������������������������������������������������������������������������Ĵ��
��� Sintaxe  � MontStruc(ExpC1,ExpN1,ExpN2)                               ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpC1 = Codigo do produto a ser explodido                  ���
���          � ExpN1 = Quantidade base a ser explodida                    ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
/*/
Static Function MontStruc(cOp,nQuant)

dbSelectArea("SD4")
dbSetOrder(2)
dbSeek(xFilial()+cOp)

While !Eof() .And. D4_FILIAL+D4_OP == xFilial()+cOp
	//���������������������������������������������������������Ŀ
	//� Posiciona no produto desejado                           �
	//�����������������������������������������������������������
	dbSelectArea("SB1")
	dbSeek(xFilial()+SD4->D4_COD)
	If SD4->D4_QUANT > 0 .Or. (lItemNeg .And. SD4->D4_QUANT < 0)
		AddAr820(SD4->D4_QUANT)
	EndIf
	dbSelectArea("SD4")
	dbSkip()
Enddo

dbSetOrder(1)

Return

/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   � CabecOp  � Autor � Paulo Boschetti       � Data � 07/07/92 ���
�������������������������������������������������������������������������Ĵ��
��� Descri��o� Monta o cabecalho da Ordem de Producao                     ���
�������������������������������������������������������������������������Ĵ��
��� Sintaxe  � CabecOp()                                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
/*/
Static Function CabecOp(Tamanho)

Local cCabec1 := SM0->M0_NOME+STR0010	//"        O R D E M   D E   P R O D U C A O       NRO :"
Local cCabec2 := STR0011				//"  C O M P O N E N T E S                                  |  |  |            |   "
Local cCabec3 := STR0012				//"CODIGO          DESCRICAO                      QUANTIDADE|UM|AL|LOCALIZACAO |SEQ"
//								           012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                        			       1         2         3         4         5         6         7         8
Local nBegin

If li # 5
	li := 0
Endif

Cabec("","","","",Tamanho,18,{cCabec1+(cAliasTop)->(C2_NUM+C2_ITEM+C2_SEQUEN)},.F.)

Li+=2
IF (mv_par06 == 1) .And. aReturn[5] # 1
	//���������������������������������������������������������Ŀ
	//� Imprime o codigo de barras do numero da OP              �
	//�����������������������������������������������������������
	oPr := ReturnPrtObj()   
	cCode := (cAliasTop)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)
	MSBAR3("CODE128",2.0,0.5,Alltrim(cCode),oPr,Nil,Nil,Nil,nil ,1.5 ,Nil,Nil,Nil)
	Li += 5
ENDIF
@Li,00 PSay STR0013+aArray[1][1]+ " " +aArray[1][2]	//"Produto: "
Li++
@Li,00 PSay STR0014+DTOC(dDatabase)						//"Emissao:"
@Li,73 PSay STR0015+TRANSFORM(m_pag,'999')				//"Fol:"
Li++

//���������������������������������������������������������Ŀ
//� Imprime nome do cliente quando OP for gerada            �
//� por pedidos de venda                                    �
//�����������������������������������������������������������
If (cAliasTop)->C2_DESTINA == "P"
	dbSelectArea("SC5")
	dbSetOrder(1)
	If dbSeek(xFilial()+(cAliasTop)->C2_PEDIDO,.F.)
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial()+SC5->C5_CLIENTE+SC5->C5_LOJACLI)
		@Li,00 PSay STR0016	//"Cliente :"
		@Li,10 PSay SC5->C5_CLIENTE+"-"+SC5->C5_LOJACLI+" "+A1_NOME
		dbSelectArea("SG1")
		Li++
	EndIf
EndIf

//���������������������������������������������������������Ŀ
//� Imprime a quantidade original quando a quantidade da    �
//� Op for diferente da quantidade ja entregue              �
//�����������������������������������������������������������
If (cAliasTop)->C2_QUJE + (cAliasTop)->C2_PERDA > 0
	@Li,00 PSay STR0017                 //"Qtde Prod.:"
	@Li,11 PSay aSC2Sld(cAliasTop)		PICTURE PesqPictQt("C2_QUANT",14)
	@Li,26 PSay STR0018                 //"Qtde Orig.:"
	@Li,37 PSay (cAliasTop)->C2_QUANT	PICTURE PesqPictQt("C2_QUANT",14)
Else
	@Li,00 PSay STR0019			//"Quantidade :"
	@Li,15 PSay (cAliasTop)->C2_QUANT - (cAliasTop)->C2_QUJE	PICTURE PesqPictQt("C2_QUANT",14)
Endif

@Li,56 PSay STR0020	//"INICIO             F I M"
Li++
@Li,00 PSay STR0021+aArray[1][4]			//"Unid. Medida : "
@Li,42 PSay STR0022+DTOC((cAliasTop)->C2_DATPRI)	//"Prev. : "
@Li,62 PSay STR0022+DTOC((cAliasTop)->C2_DATPRF)	//"Prev. : "
Li++
@Li,00 PSay STR0023+(cAliasTop)->C2_CC				//"C.Custo: "
@Li,42 PSay STR0024+DTOC((cAliasTop)->C2_DATAJI)	//"Ajuste: "
@Li,62 PSay STR0024+DTOC((cAliasTop)->C2_DATAJF)	//"Ajuste: "
Li++
If (cAliasTop)->C2_STATUS == "S"
	@Li,00 PSay "Status: OP Sacramentada"
ElseIf (cAliasTop)->C2_STATUS == "U"
	@Li,00 PSay "Status: OP Suspensa"
ElseIf (cAliasTop)->C2_STATUS $ " N"
	@Li,00 PSay "Status: OP Normal"
EndIf
@Li,42 PSay STR0028							//	"Real  :   /  /      Real  :   /  / "
Li++

//Comeca aqui as alteracoes    (Emerson)
Li:=Li+1
@Li,00 PSay __PrtFatLine()
Li:=Li+1
@Li  ,  0 PSAY "Materia-Prima:"
@Li  , 15 PSAY Posicione("SZ2",1,xFilial("SZ2")+(cAliasTop)->C2_MATPRIM,"Z2_DESCRI")
@Li  , 35 PSAY "Acabamento/Desgalho:"
@Li  , 56 PSAY (cAliasTop)->C2_ACABAME
Li:=Li+1
@Li  ,  0 PSAY "Cor:"
@Li  ,  5 PSAY (cAliasTop)->C2_COR
@Li  , 19 PSAY "Receita:"
@Li  , 28 PSAY (cAliasTop)->C2_RECEITA
@Li  , 35 PSAY "Acab/Serv     :"
@Li  , 51 PSAY Posicione("SZ4",1,xFilial("SZ4")+(cAliasTop)->C2_GRAVTIN,"Z4_DESCRIC")
Li:=Li+1      
@Li  ,  0 PSAY "Producao por Hora  :"
@Li  , 21 PSAY (cAliasTop)->C2_PRODHOR
@Li  , 35 PSAY "Producao Total:"
@Li  , 51 PSAY (cAliasTop)->C2_PRODTOT
Li:=Li+1      
@Li  ,  0 PSAY "Consumo MP por Hora:"
@Li  , 21 PSAY (cAliasTop)->C2_CONSMPH
@Li  , 35 PSAY "Cons.MP Total :"
@Li  , 51 PSAY (cAliasTop)->C2_CONSMPT
Li:=Li+1      
@Li  ,  0 PSAY "Ciclo da Peca      :"
@Li  , 21 PSAY (cAliasTop)->C2_CICLO
@Li  , 35 PSAY "Qtd Cavidades :"
@Li  , 51 PSAY (cAliasTop)->C2_CAVIDAD
Li:=Li+1      
@Li  ,  0 PSAY "Peso Liquido       :"
@Li  , 21 PSAY (cAliasTop)->C2_PESOLIQ
@Li  , 35 PSAY "Peso Bruto    :"
@Li  , 51 PSAY (cAliasTop)->C2_PESOBRU
Li:=Li+1      
Li:=Li+1      

@Li  ,  0 PSAY "Data Entrega PV 1  :"
@Li  , 20 PSAY (cAliasTop)->C2_ENTREG1
@Li  , 35 PSAY "Qtde do PV 1  :"
@Li  , 51 PSAY (cAliasTop)->C2_QTDPV1
Li:=Li+1

@Li  ,  0 PSAY "Data Entrega PV 2  :"
@Li  , 20 PSAY (cAliasTop)->C2_ENTREG2
@Li  , 35 PSAY "Qtde do PV 2  :"
@Li  , 51 PSAY (cAliasTop)->C2_QTDPV2
Li:=Li+1

@Li  ,  0 PSAY "Data Entrega PV 3  :"
@Li  , 20 PSAY (cAliasTop)->C2_ENTREG3
@Li  , 35 PSAY "Qtde do PV 3  :"
@Li  , 51 PSAY (cAliasTop)->C2_QTDPV3
Li:=Li+1                     

@Li  ,  0 PSAY "Data Entrega PV 4  :"
@Li  , 20 PSAY (cAliasTop)->C2_ENTREG4
@Li  , 35 PSAY "Qtde do PV 4  :"
@Li  , 51 PSAY (cAliasTop)->C2_QTDPV4
Li:=Li+1 

@Li  ,  0 PSAY "Cliente PV1:"
@Li  , 20 PSAY (cAliasTop)->C2_CLIPV1
Li:=Li+1 
@Li  ,  0 PSAY "Cliente PV2:"
@Li  , 20 PSAY (cAliasTop)->C2_CLIPV2
Li:=Li+1 
@Li  ,  0 PSAY "Cliente PV3:"
@Li  , 20 PSAY (cAliasTop)->C2_CLIPV3
Li:=Li+1 
@Li  ,  0 PSAY "Cliente PV4:"
@Li  , 20 PSAY (cAliasTop)->C2_CLIPV4
Li:=Li+1 

@Li  ,  0 PSAY REPLICATE("-",22)+" Respons�vel: "+(cAliasTop)->c2_usuario+" Emitente: " + SUBSTR(CUSUARIO,7,15)
LI:=LI+1

@LI  ,  0 PSAY "Informa��es do Try-Out : " +(cAliasTop)->C2_INFTRYO
Li++

If !(Empty((cAliasTop)->C2_OBS))
	@Li,00 PSay "Observa��o: "
	For nBegin := 1 To Len(Alltrim((cAliasTop)->C2_OBS)) Step 50
		@li,012 PSay Substr((cAliasTop)->C2_OBS,nBegin,50)
		li++
	Next nBegin
EndIf
Li++

@Li,00 PSay "Acabamento: "
@li,012 PSay Substr((cAliasTop)->C2_XACAB,1,50)
li++
@Li,00 PSay "Tonalidade: "
@li,012 PSay Substr((cAliasTop)->C2_XTON,1,50)
li++
@Li,00 PSay "Cod. Cor: "
@li,012 PSay Substr((cAliasTop)->C2_XCODCOR,1,50)
li++
@Li,00 PSay "Tab. Cor: "
@li,012 PSay Substr((cAliasTop)->C2_XTABCOR,1,50)
li++
@Li,00 PSay "Obs. PedV: "
@li,012 PSay Substr((cAliasTop)->C2_XOBS,1,50)
li++

//    Termina as alteracoes   (Emerson)
@Li,00 PSay __PrtFatLine()
Li++
@Li,00 PSay cCabec2
Li++
@Li,00 PSay cCabec3
Li++
@Li,00 PSay __PrtFatLine()
Li++

/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   � RotOper  � Autor � Paulo Boschetti       � Data � 18/07/92 ���
�������������������������������������������������������������������������Ĵ��
��� Descri��o� Imprime Roteiro de Operacoes                               ���
�������������������������������������������������������������������������Ĵ��
��� Sintaxe  � RotOper()                                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
Static Function RotOper()

dbSelectArea("SG2")
If dbSeek(xFilial()+aArray[1][1]+aArray[1][9],.F.)
	
	cRotOper()
	
	While !Eof() .And. G2_FILIAL+G2_PRODUTO+G2_CODIGO = xFilial()+aArray[1][1]+aArray[1][9]
		
		dbSelectArea("SH4")
		dbSeek(xFilial()+SG2->G2_FERRAM)
		
		dbSelectArea("SH8")
		dbSetOrder(1)
		dbSeek(xFilial()+(cAliasTop)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)+SG2->G2_OPERAC)
		lSH8 := IIf(Found(),.T.,.F.)
		
		If lSH8
			While !Eof() .And. SH8->H8_FILIAL+SH8->H8_OP+SH8->H8_OPER == xFilial()+(cAliasTop)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)+SG2->G2_OPERAC
				ImpRot(lSH8)
				dbSelectArea("SH8")
				dbSkip()
			End
		Else
			ImpRot(lSH8)
		Endif
		
		dbSelectArea("SG2")
		dbSkip()
		
	EndDo
	
Endif

Return Li

/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   � ImpRot   � Autor � Marcos Bregantim      � Data � 10/07/95 ���
�������������������������������������������������������������������������Ĵ��
��� Descri��o� Imprime Roteiro de Operacoes                               ���
�������������������������������������������������������������������������Ĵ��
��� Sintaxe  � ImpRot()                                                   ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
Static Function ImpRot(lSH8)
Local nBegin

dbSelectArea("SH1")
dbSeek(xFilial()+IIf(lSH8,SH8->H8_RECURSO,SG2->G2_RECURSO))

Verilim()

@Li,00 PSay IIF(lSH8,SH8->H8_RECURSO,SG2->G2_RECURSO)+" "+SUBS(SH1->H1_DESCRI,1,25)
@Li,33 PSay SG2->G2_FERRAM+" "+SUBS(SH4->H4_DESCRI,1,20)
@Li,61 PSay SG2->G2_OPERAC

For nBegin := 1 To Len(Alltrim(SG2->G2_DESCRI)) Step 16
	@li,064 PSay Substr(SG2->G2_DESCRI,nBegin,16)
	li++

   IF li > 60
		Li := 0
		cRotOper()
	EndIF
Next nBegin

Li+=1
@Li,00 PSay STR0032+IIF(lSH8,DTOC(SH8->H8_DTINI),Space(8))+" "+IIF(lSH8,SH8->H8_HRINI,Space(5))+" "+STR0033+" ____/ ____/____ ___:___"	//"INICIO  ALOC.: "###" INICIO  REAL :"
Li++
@Li,00 PSay STR0034+IIF(lSH8,DTOC(SH8->H8_DTFIM),Space(8))+" "+IIF(lSH8,SH8->H8_HRFIM,Space(5))+" "+STR0035+" ____/ ____/____ ___:___"	//"TERMINO ALOC.: "###" TERMINO REAL :"
Li++
@Li,00 PSay STR0019	//"Quantidade :"
@Li,13 PSay IIF(lSH8,SH8->H8_QUANT,aSC2Sld(cAliasTop)) PICTURE PesqPictQt("H8_QUANT",14)
@Li,28 PSay STR0036	//"Quantidade Produzida :               Perdas :"
Li++
@Li,00 PSay __PrtThinLine()
Li++

/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   � RotOper  � Autor � Paulo Boschetti       � Data � 18/07/92 ���
�������������������������������������������������������������������������Ĵ��
��� Descri��o� Imprime Roteiro de Operacoes                               ���
�������������������������������������������������������������������������Ĵ��
��� Sintaxe  � RotOper()                                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
Static Function cRotOper()

Local cCabec1 := SM0->M0_NOME+STR0030	//"              ROTEIRO DE OPERACOES              NRO :"
Local cCabec2 := STR0031					//"RECURSO                       FERRAMENTA               OPERACAO"

Li++
@Li,00 PSay __PrtFatLine()
Li++
@Li,00 PSay cCabec1
@Li,67 PSay (cAliasTop)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)
Li++
@Li,00 PSay __PrtFatLine()
Li++
@Li,00 PSay STR0013+aArray[1][1]	//"Produto: "
ImpDescr(aArray[1][2])

//���������������������������������������������������������Ŀ
//� Imprime a quantidade original quando a quantidade da    �
//� Op for diferente da quantidade ja entregue              �
//�����������������������������������������������������������
If (cAliasTop)->C2_QUJE + (cAliasTop)->C2_PERDA > 0
	@Li,00 PSay STR0017                 //"Qtde Prod.:"
	@Li,11 PSay aSC2Sld(cAliasTop)      PICTURE PesqPictQt("C2_QUANT",14)
	@Li,26 PSay STR0018                 //"Qtde Orig.:"
	@Li,37 PSay (cAliasTop)->C2_QUANT   PICTURE PesqPictQt("C2_QUANT",14)
Else
	@Li,00 PSay STR0019            //"Quantidade :"
	@Li,15 PSay aSC2Sld(cAliasTop)	PICTURE PesqPictQt("C2_QUANT",14)
Endif

Li++
@Li,00 PSay STR0023+(cAliasTop)->C2_CC	//"C.Custo: "
Li++
@Li,00 PSay __PrtFatLine()
Li++
@Li,00 PSay cCabec2
Li++
@Li,00 PSay __PrtFatLine()
Li++
Return Li

/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   � Verilim  � Autor � Paulo Boschetti       � Data � 18/07/92 ���
�������������������������������������������������������������������������Ĵ��
��� Descri��o�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Sintaxe  � Verilim()                                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros� 			                                          		  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
*/
Static Function Verilim()

//����������������������������������������������������������������������Ŀ
//� Verifica a possibilidade de impressao da proxima operacao alocada na �
//� mesma folha.																			 �
//� 7 linhas por operacao => (total da folha) 66 - 7 = 59					 �
//������������������������������������������������������������������������
IF Li > 59						// Li > 55
	Li := 0
	cRotOper(0)					// Imprime cabecalho roteiro de operacoes
Endif
Return Li

/*
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    � BARCODE  � Autor � Ricardo Dutra          � Data � 16/08/93 ���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Programa para imprimir codigo de barras                     ���
��������������������������������������������������������������������������Ĵ��
���Sintaxe   � CodBar(ExpC1)								                        ���
��������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                    ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
*/
#define ESC	27
Static Function BarCode(cCodigo)
Local nLargura := 40	// largura de impressao do codigo
Local i, j, l, k, nCarac, cTexto, cEsc, cCode, nLimite, nImp, nBorda, nLin
Local aV0 := { Replicate(Chr(0),7), Chr(0) + Chr(0) + Chr(0) }
Local aV1 := { Replicate(Chr(127),6), Chr(127) + Chr(127) }
Local aImp [50]

nLin := 0							// imprime codigo comeco formulario
cEsc := Chr(ESC)

//��������������������������������������������������������������������Ŀ
//� Reseta a impressora na posicao atual - comeco formulario           �
//����������������������������������������������������������������������
@ 0,0 PSay cEsc + "@"				// reseta a impressora nesta posicao

cTexto := cCodigo
cTexto := "*" + cTexto + "*"		// caracteres de inicio e fim

nImp := 1
aImp [nImp] := ""
nLimite := Len(cTexto)

FOR i := 1 TO nLimite
	nCarac := Asc (Substr (cTexto, i, 1))
	
	//����������������������������������������������������������Ŀ
	//� Atribui um codigo a cada caracter                        �
	//������������������������������������������������������������
	
	IF nCarac == 42					// *
		cCode := "2122121222"
	ELSEIF nCarac == 32				// branco
		cCode := "2112221222"
	ELSEIF nCarac == 48				// 0
		cCode := "2221121222"
	ELSEIF nCarac == 49				// 1
		cCode := "1221222212"
	ELSEIF nCarac == 50				// 2
		cCode := "2211222212"
	ELSEIF nCarac == 51				// 3
		cCode := "1211222222"
	ELSEIF nCarac == 52				// 4
		cCode := "2221122212"
	ELSEIF nCarac == 53				// 5
		cCode := "1221122222"
	ELSEIF nCarac == 54				// 6
		cCode := "2211122222"
	ELSEIF nCarac == 55				// 7
		cCode := "2221221212"
	ELSEIF nCarac == 56				// 8
		cCode := "1221221222"
	ELSEIF nCarac == 57				// 9
		cCode := "2211221222"
	ELSEIF nCarac == 65				// A
		cCode := "1222212212"
	ELSEIF nCarac == 66				// B
		cCode := "2212212212"
	ELSEIF nCarac == 67				// C
		cCode := "1212212222"
	ELSEIF nCarac == 68				// D
		cCode := "2222112212"
	ELSEIF nCarac == 69				// E
		cCode := "1222112222"
	ELSEIF nCarac == 70				// F
		cCode := "2212112222"
	ELSEIF nCarac == 71				// G
		cCode := "2222211212"
	ELSEIF nCarac == 72				// H
		cCode := "1222211222"
	ELSEIF nCarac == 73				// I
		cCode := "2212211222"
	ELSEIF nCarac == 74				// J
		cCode := "2222111222"
	ELSEIF nCarac == 75				// K
		cCode := "1222222112"
	ELSEIF nCarac == 76				// L
		cCode := "2212222112"
	ELSEIF nCarac == 77				// M
		cCode := "1212222122"
	ELSEIF nCarac == 78				// N
		cCode := "2222122112"
	ELSEIF nCarac == 79				// O
		cCode := "1222122122"
	ELSEIF nCarac == 80				// P
		cCode := "2212122122"
	ELSEIF nCarac == 81				// Q
		cCode := "2222221112"
	ELSEIF nCarac == 82				// R
		cCode := "1222221122"
	ELSEIF nCarac == 83				// S
		cCode := "2212221122"
	ELSEIF nCarac == 84				// T
		cCode := "2222121122"
	ELSEIF nCarac == 85				// U
		cCode := "1122222212"
	ELSEIF nCarac == 86				// V
		cCode := "2112222212"
	ELSEIF nCarac == 87				// W
		cCode := "1112222222"
	ELSEIF nCarac == 88				// X
		cCode := "2122122212"
	ELSEIF nCarac == 89				// Y
		cCode := "1122122222"
	ELSEIF nCarac == 90				// Z
		cCode := "2112122222"
	ENDIF
	
	//���������������������������������������������������������������Ŀ
	//� Adiciona barras ou espacos ao array de impressao, sendo :     �
	//� - barra grossa  = 6 * Chr(127)                				      �
	//� - barra fina    = 2 * Chr(127)								         �
	//� - espaco grosso = 7 * Chr(0)                                  �
	//� - espaco fino   = 3 * Chr(0) 								         �
	//�																               �
	//� As barras e espacos sao alocados de acordo com os caracteres  �
	//� de cCode, tomados 2 a 2, sendo que o primeiro designa as bar- �
	//� ras e o segundo, os espacos. 								         �
	//� Se o caracter for 1 => barra/espaco grosso					      �
	//� Se o caracter for 2 => barra/espaco fino					         �
	//�����������������������������������������������������������������
	FOR j := 1 to 9 STEP 2
		aImp[nImp] := aImp[nImp] + aV1 [val(substr(cCode,j,1))] + ;
		aV0 [val(substr(cCode,j + 1,1))]
	NEXT
	
	l := len(aImp[nImp])
	
	//����������������������������������������������������������������������Ŀ
	//�Se tamanho do string atual de impressao for maior que 120,				 �
	//�copia o que ultrapassou para o proximo string								 �
	//�Limita o string atual para 120 + caracteres de controle de imp grafica�
	//�Incrementa contador de strings													 �
	//������������������������������������������������������������������������
	IF l > 120
		aImp[nImp+1] := Right(aImp[nImp],l -120)
		aImp[nImp] := cEsc + "L" + Chr(120) + Chr(0) + Left(aImp[nImp],120)
		nImp++
	ENDIF
NEXT

j := Len(aImp[nImp])

//���������������������������������������������������Ŀ
//�Borda esquerda da etiqueta para centrar o codigo   �
//�����������������������������������������������������
nBorda := (nLargura - (j + (nImp - 1) * 120 ) / Len(cTexto)) / 2

IF nBorda < 0
	return -2		// Codigo muito grande p/largura especificada
ENDIF

//��������������������������������������������������������������Ŀ
//� Acrescenta caracteres de controle grafico ao ultimo string   �
//����������������������������������������������������������������
aImp[nImp] := cEsc + "L" + Chr(j)+Chr(0) + aImp[nImp] + cEsc + "3" + Chr(1)

FOR l := 1 to 4					// imprime quatro linhas
	FOR k := 1 to 3				// imprime tres vezes
		FOR i := 1 to nImp		// contador de strings
			@ nLin,nBorda+(i-1)*10 PSay aImp[i]
		NEXT
		nLin++
	NEXT
	
	//��������������������������������������������������������������Ŀ
	//� Seta tamanho de linha para posicionar para a proxima         �
	//����������������������������������������������������������������
	@ nLin,1 PSay cEsc + "3" + Chr(18)
	nLin++
NEXT

//��������������������������������������������������������������������Ŀ
//� Seta tamanho de linha p/ posicionar cursor proxima coluna de texto �
//����������������������������������������������������������������������
@ nLin,1 PSay  cEsc + "3" + Chr(24)
nLin++

@ nLin,1 PSay cEsc + "2"			// cancela espacamentos de linha progrados

//��������������������������������������������������������������������Ŀ
//� Imprime o numero da OP expandido e centralizado, embaixo do codigo �
//����������������������������������������������������������������������
cNumOp := Replicate(" ",3) + cTexto		// para centralizar
@ nLin,nBorda PSay Chr(14) + cNumOp	    // imprime expandido
nLin++
@ nLin,0 PSay Chr(20)					// volta ao normal

RETURN

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � ImpDescr � Autor � Marcos Bregantim      � Data � 31.08.93 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Imprimir descricao do Produto.                             ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � ImpProd(Void)                                              ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MatR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ImpDescr(cDescri)
Local nBegin

For nBegin := 1 To Len(Alltrim(cDescri)) Step 50
	@li,025 PSay Substr(cDescri,nBegin,50)
	li++
Next nBegin

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �R820Medidas� Autor � Jose Lucas           � Data � 25.01.94 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Imprime o registros referentes as medidas do Pedido Filho. ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � R820Medidas(Void)                                          ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MatR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function R820Medidas()
Local aArrayPro := {}, lImpItem := .T.
Local nCntArray := 0,a01 := "",a02 := ""
Local nX:=0,nI:=0,nL:=0,nY:=0
Local cNum:="", cItem:="",lImpCab := .T.
Local nBegin, cProduto:="", cDesc, cDescri, cDescri1, cDescri2

//������������������������������������������������������������Ŀ
//� Imprime Relacao de Medidas do cliente quando OP for gerada �
//� por pedidos de vendas.                                     �
//��������������������������������������������������������������
dbSelectArea("SC5")
dbSetOrder(1)
If dbSeek(xFilial()+(cAliasTop)->C2_PEDIDO,.F.)
	cNum := (cAliasTop)->C2_NUM
	cItem := (cAliasTop)->C2_ITEM
	cProduto := (cAliasTop)->C2_PRODUTO
	//��������������������������������������������������������������Ŀ
	//� Imprimir somente se houver Observacoes.                      �
	//����������������������������������������������������������������
	IF !Empty(SC5->C5_OBSERVA)
		IF li > 53
			@ 03,001 PSay "HUNTER DOUGLAS DO BRASIL LTDA"
			@ 05,008 PSay "CONFIRMACAO DE PEDIDOS  -  "+IIF( SC5->C5_VENDA=="01","ASSESSORIA","DISTRIBUICAO")
			@ 05,055 PSay "No. RMP    : "+SC5->C5_NUM+"-"+SC5->C5_VENDA
			@ 06,055 PSay "DATA IMPRES: "+DTOC(dDataBase)
			li := 07
		EndIF
		li++
		@ li,001 PSay "--------------------------------------------------------------------------------"
		li++
		cDescri := SC5->C5_OBSERVA
		@ li,001 PSay " OBSERVACAO: "
		@ li,018 PSay SubStr(cDescri,1,60)
		For nBegin := 61 To Len(Trim(cDescri)) Step 60
			li++
			cDesc:=Substr(cDescri,nBegin,60)
			@ li,018 PSay cDesc
		Next nBegin
		li++
		cDescri1 := SC5->C5_OBSERV1
		@ li,018 PSay SubStr(cDescri1,1,60)
		For nBegin := 61 To Len(Trim(cDescri1)) Step 60
			li++
			cDesc:=Substr(cDescri1,nBegin,60)
			@ li,018 PSay cDesc
		Next nBegin
		Li++
		cDescri2 := SC5->C5_OBSERV2
		@ li,018 PSay SubStr(cDescri2,1,60)
		For nBegin := 61 To Len(Trim(cDescri2)) Step 60
			li++
			cDesc:=Substr(cDescri2,nBegin,60)
			@ li,018 PSay cDesc
		Next nBegin
		li++
		@ li,001 PSay "--------------------------------------------------------------------------------"
		li++
	EndIf
	
	//��������������������������������������������������������������Ŀ
	//� Carregar as medidas em array para impressao.                 �
	//����������������������������������������������������������������
	dbSelectArea("SMX")
	dbSetOrder(2)
	dbSeek(xFilial()+cNum+cProduto)
	While !Eof() .And. M6_FILIAL+M6_NRREL+M6_PRODUTO == xFilial()+cNum+cProduto
		IF M6_ITEM == cItem
			AADD(aArrayPro,M6_ITEM+" - "+M6_PRODUTO)
			nCntArray++
			cCnt := StrZero(nCntArray,2)
			aArray&cCnt := {}
			While !Eof() .And. M6_FILIAL+M6_NRREL+M6_PRODUTO == xFilial()+cNum+cProduto
				If M6_ITEM == cItem
					AADD(aArray&cCnt,{ Str(M6_QUANT,9,2)," PECAS COM ",M6_COMPTO})
				EndIf
				dbSkip()
			End
		Else
			dbSkip()
		EndIF
	End
	cCnt := StrZero(nCntArray+1,2)
	aArray&cCnt := {}
	
	For nX := 1 TO Len(aArrayPro)
		If li > 58
			R820CabMed()
		EndIF
		@ li,009 PSay aArrayPro[nx]
		Li++
		Li++
		dbSelectArea("SMX")
		dbSetOrder(2)
		dbSeek( xFilial()+cNum+Subs(aArrayPro[nX],06,15) )
		While !Eof() .And. M6_FILIAL+M6_NRREL+M6_PRODUTO == xFilial()+cNum+Subs(aArrayPro[nX],06,15)
			If li > 58
				R820CabMed()
			EndIF
			IF M6_ITEM == Subs(aArrayPro[nX],1,2)
				@ li,002 PSay M6_QUANT
				@ li,013 PSay "PECAS COM"
				@ li,023 PSay M6_COMPTO
				@ li,035 PSay M6_OBS
				li ++
			EndIF
			dbSkip()
		End
		li++
	Next nX
	@ li,001 PSay "--------------------------------------------------------------------------------"
EndIf
Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �R820CabMed � Autor � Jose Lucas           � Data � 25.01.94 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Imprime o cabecalho referentes as medidas do Pedido Filho. ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � R820CabMed(Void)                                           ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MatR820                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function R820CabMed()
Local cCabec1 := SM0->M0_NOME+STR0037	//"               RELACAO DE MEDIDAS             NRO :"

Li := 0

Li++
@Li,00 PSay __PrtFatLine()
Li++
@Li,00 PSay cCabec1
@Li,67 PSay (cAliasTop)->(C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD)
Li++
@Li,00 PSay __PrtFatLine()
Li++
Li++
Return Nil
