#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'

User function teste_stepwiz()
Local oPanel
Local oNewPag
Local cNome   := ""
Local cFornec := ""
Local cCombo1 := ""
Local oStepWiz := nil
Local oDlg := nil
Local oPanelBkg
DEFINE DIALOG oDlg TITLE 'aaaaa' PIXEL
oDlg:nWidth := 1100
oDlg:nHeight := 800
oPanelBkg:= tPanel():New(20,70,"",oDlg,,,,,,300,300)
oStepWiz:= FWWizardControl():New(oPanelBkg)//Instancia a classe FWWizard
oStepWiz:ActiveUISteps()
 
//----------------------
// Pagina 1
//----------------------
oNewPag := oStepWiz:AddStep("1")
//Altera a descrição do step
oNewPag:SetStepDescription("Primeiro passo")
//Define o bloco de construção
oNewPag:SetConstruction({|Panel|cria_pg1(Panel, @cNome, @cFornec)})
//Define o bloco ao clicar no botão Próximo
oNewPag:SetNextAction({||valida_pg1(@cNome, @cFornec)})
//Define o bloco ao clicar no botão Cancelar
oNewPag:SetCancelAction({||Alert("Cancelou na pagina 1"), .T.})
 
//----------------------
// Pagina 2
//----------------------
oNewPag := oStepWiz:AddStep("2", {|Panel|cria_pg2(Panel, @cCombo1)})
oNewPag:SetStepDescription("Segundo passo")
oNewPag:SetNextAction({||valida_pg2(@cCombo1)})
//Define o bloco ao clicar no botão Voltar
oNewPag:SetCancelAction({||Alert("Cancelou na pagina 2"), .T.})
oNewPag:SetPrevAction({||Alert("Ops, voce não pode voltar a partir daqui"), .F.})
oNewPag:SetPrevTitle("Voltar(ou não)")
 
//----------------------
// Pagina 3
//----------------------
oNewPag := oStepWiz:AddStep("3", {|Panel|cria_pn3(Panel)})
oNewPag:SetStepDescription("Terceiro passo")
oNewPag:SetNextAction({||Alert("Fim"), .T.})
oNewPag:SetCancelAction({||Alert("Cancelou na pagina 3"), .T.})
oNewPag:SetCancelWhen({||.F.})
oStepWiz:Activate()
ACTIVATE DIALOG oDlg CENTER
oStepWiz:Destroy()
Return
 
//--------------------------
// Construção da página 1
//--------------------------
Static Function cria_pg1(oPanel, cNome, cFornec)
Local oTGet1
Local oTGet2
oSay1:= TSay():New(10,10,{||'Cliente'},oPanel,,,,,,.T.,,,200,20)
cNome := Space(30)
oTGet1 := TGet():New( 20,10,{|u| if( PCount() > 0, cNome := u, cNome ) } ,oPanel,096,009,"@!",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,cNome,,,, )
oSay2:= TSay():New(40,10,{||'Fornecedor'},oPanel,,,,,,.T.,,,200,20)
cFornec := Space(30)
oTGet2 := TGet():New( 50,10,{|u| if( PCount() > 0, cFornec := u, cFornec ) },oPanel,096,009,"@!",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,cFornec,,,, )
Return
  
 
//----------------------------------------
// Validação do botão Próximo da página 1
//----------------------------------------
Static Function valida_pg1(cNome, cFornec)
MsgInfo("Cliente: " + cNome + chr(13)+chr(10) + "Fornecedor: " + cFornec)
Return .T.
 
//--------------------------
// Construção da página 2
//--------------------------
Static Function cria_pg2(oPanel, cCombo1)
Local aItems := {'Item1','Item2','Item3'}
Local oCombo1
cCombo1:= aItems[1]   
oCombo1 := TComboBox():New(20,20,{|u|if(PCount()>0,cCombo1:=u,cCombo1)},aItems,100,20,oPanel,,{|| },,,,.T.,,,,,,,,,'cCombo1')
Return
  
 
//----------------------------------------
// Validação do botão Próximo da página 2
//----------------------------------------
Static Function valida_pg2(cCombo1)
Local lRet := .F.
If cCombo1 == 'Item3'
    lRet := .T.
Else
    Alert("Você selecionou: " + cCombo1 + " para prossegir selecione Item3")
EndIf
Return lRet
 
//--------------------------
// Construção da página 3
//--------------------------
Static Function cria_pn3(oPanel)
Local oBtnPanel := TPanel():New(0,0,"",oPanel,,,,,,40,40)
oBtnPanel:Align := CONTROL_ALIGN_TOP
oTButton1 := TButton():New( 010, 010, "Botão 01",oBtnPanel,{||alert("Botão 01")}, 80,20,,,.F.,.T.,.F.,,.F.,,,.F. )
oTButton2 := TButton():New( 010, 0200, "Botão 02",oBtnPanel,{||alert("Botão 02")}, 80,20,,,.F.,.T.,.F.,,.F.,,,.F. )
Return
