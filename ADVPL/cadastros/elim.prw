//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zElimRes
Fun��o que executa a elimina��o de res�duo de forma autom�tica
@type  Function
@author Atilio
@since 03/09/2021
/*/

User Function zElimRes(param_name)
    Local aArea
    Local lContinua   := .F.
    Private lJob      := .F.

    //Se o ambiente n�o estiver em p�, sobe para usar de maneira autom�tica
    If Select("SX2") == 0
        lJob := .T.
        lContinua := .T.
		RPCSetEnv("99", "01", "", "", "", "")
    EndIf
    aArea := GetArea()

    //Se n�o for modo autom�tico, mostra uma pergunta
    If ! lJob
        lContinua := MsgYesNo("Deseja executar a elimina��o de res�duo autom�tica?", "Aten��o")
    EndIf

    //Se for continuar, faz a chamada para a realiza��o das baixas
    If lContinua
        Processa({|| fElimina()}, "Eliminando...")
    EndIf
Return

Static Function fElimina()
    Local cInicio   := Time()
    Local cTermino  := ""
    Local cTotal    := ""
    Local cMensagem := ""
    Local cTitulo   := ""
    Local cPerg     := "MTA235"

    //Define os par�metros
    fSetValue(cPerg, "MV_PAR01", 100)                                 //Percentual m�ximo
    fSetValue(cPerg, "MV_PAR02", MonthSub(Date(), 2))                 //Data de Emiss�o De
    fSetValue(cPerg, "MV_PAR03", Date())                              //Data de Emiss�o At�
    fSetValue(cPerg, "MV_PAR04", "000000")                            //Solicita��o / Pedido De
    fSetValue(cPerg, "MV_PAR05", "ZZZZZZ")                            //Solicita��o / Pedido At�
    fSetValue(cPerg, "MV_PAR06", Space(TamSX3("B1_COD")[1]))          //Produto De
    fSetValue(cPerg, "MV_PAR07", Replicate("Z", TamSX3("B1_COD")[1])) //Produto At�
    fSetValue(cPerg, "MV_PAR08", 1)                                   //Eliminar res�duo por (1=Pedido de Compra; 2=Aut de Entrega; 3=Pedido/Aut Entrega; 4=Contr. Parceria; 5=Solic. Compras)
    fSetValue(cPerg, "MV_PAR09", Space(TamSX3("A2_COD")[1]))          //Fornecedor De
    fSetValue(cPerg, "MV_PAR10", Replicate("Z", TamSX3("A2_COD")[1])) //Fornecedor At�
    fSetValue(cPerg, "MV_PAR11", MonthSub(Date(), 2))                 //Data de Entrega De
    fSetValue(cPerg, "MV_PAR12", Date())                              //Data de Entrega At�
    fSetValue(cPerg, "MV_PAR13", 2)                                   //Elimina SC com OP (1=Sim; 2=N�o)
    fSetValue(cPerg, "MV_PAR14", "    ")                              //Item De
    fSetValue(cPerg, "MV_PAR15", "ZZZZ")                              //Item At�
    fSetValue(cPerg, "MV_PAR16", 2)                                   //Contabiliza Pedido (1=Sim; 2=N�o)
    fSetValue(cPerg, "MV_PAR17", 2)                                   //Mostrar Lan�amento Cont�bil (1=Sim; 2=N�o)

    //Coloca a pergunta para a mem�ria
    Pergunte(cPerg, .F.)

    //Chama a rotina padr�o
    lMsErroAuto := .F.
    MsExecAuto({|x| MATA235(x)}, .T.)
    cTermino := Time()
    cTotal   := ElapTime(cInicio, cTermino)

    //Se houver erro
    If lMsErroAuto
        //Se n�o for Job, exibe a mensagem de erro
        If ! lJob
            MostraErro()
        EndIf
    Else
        //Se n�o for Job, exibe mensagem de t�rmino
        If ! lJob
            cTitulo   := "Processamento terminado"
            cMensagem := "Come�ou �s <b>"     + cInicio  + "</b><br>"
            cMensagem += "Terminou �s <b>"    + cTermino + "</b><br>"
            cMensagem += "Tempo Total de <b>" + cTotal   + "</b><br>"

            FWAlertSuccess(cMensagem, cTitulo)
        EndIf
    EndIf
Return

Static Function fSetValue(cPergunta, cParametro, xConteudo)
    //Tratativa, se houver a fun��o nova criada pela TOTVS aciona ela, do contr�rio, aciona a customizada
    If ExistBlock("SetMVValue")
        SetMVValue(cPergunta, cParametro, xConteudo)
    Else
        u_zAtuPerg(cPergunta, cParametro, xConteudo)
    EndIf
Return
