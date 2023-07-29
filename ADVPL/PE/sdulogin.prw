#INCLUDE 'protheus.ch'
#INCLUDE 'Ap5Mail.ch'
 
/*/{Protheus.doc} User Function SduLogin
Enviar email de aviso que acessou o apsdu
@author Thalys Augusto
@since 15/07/2020
@version 1.0
@type function
/*/
 
User Function SduLogin()
    Local cAssunto := 'Auditoria APSDU' 
    Local cDestinatario := ''
    Local cMensagem := ''
    Local cUser := ParamIXB
     
    //Monta a mensagem do e-Mail
    cMensagem    :=    "Usuário Protheus <b>" +Alltrim(cUser)+ "</b> efetuou login no APSDU na Empresa:<br> No ambiente:"+GetEnvServer()+"<br> através do usuário de rede "
    cMensagem    +=    "<b>" + Alltrim(LogUserName()) + "<br></b> em " + DtoC( Date()) + " às " + Time() 
    cMensagem    +=    " <br> na máquina <b>" + Lower(ComputerName()) + Upper(" (IP "+ GetClientIP()+" / PC: " +GetComputerName()+")</b>")
 
    //Dispara o e-Mail para o destinatario configurado
    cDestinatario := 'fabio.favaretto@upduo.com.br'
    U_UPDUO01(cDestinatario, cAssunto, cMensagem)
Return .T.
 

 



