User Function MSQUIT()
	Local lLogoff 	:= ParamIxb[1] //vari�vel l�gica que identifica se o P.E. est� sendo executado pelo Logoff.
	Local cUser := PswChave(RetCodUsr())
	//Local cMenu := CFILEXNU
	Local cEmpresas := FWLoadSM0()[1][6]
	Local CFilial   := FWLoadSM0()[1][7]
	Local cAssunto := 'Auditoria Saida do Sistema'
	Local cDestinatario := ''
	Local cMensagem := ''
	FWLoadSM0(.F., .T.) // chama fun��o que realiza a abertura dos prametros iniciais do sistema


	If lLogOff .and. cUser == "Administrador" .or. cUser == "UPDUO01" .or. cUser == "UPDUO02"
		Conout("Usu�rio: "+Alltrim(cUserName)+" efetuou logoff do sistema")


		//Monta a mensagem do e-Mail
		cMensagem := "O Consultor : " + Alltrim(LogUserName()) + "<br>"
		cMensagem += "Com o Usuario:" + Alltrim(cUser) + "<br>"
        cMensagem += "No ambiente:" + GetEnvServer() + "<br>"
		cMensagem += "Na empresa: "+ cEmpresas +"<br>"
		cMensagem += "Na Filial: "+ CFilial +"<br>"
		//cMensagem += "No Modulo:  "+ cMenu +"<br>"
        cMensagem += "<b>SAIU do sistema</b><br>"
		cMensagem += "Na Data de: " + DtoC( Date()) + " �s " + Time() + "<br>"
		cMensagem += "<br> na m�quina <b>" + Lower(ComputerName()) + Upper(" (IP "+ GetClientIP()+" / PC: " +GetComputerName()+")</b>")

		//Dispara o e-Mail para o destinatario configurado
		cDestinatario := 'fabio.favaretto@upduo.com.br'
		U_UPDUO01(cDestinatario, cAssunto, cMensagem)

	Else
		Conout("Usu�rio: "+Alltrim(cUserName)+" saiu totalmente do sistema")
	EndIf

Return
