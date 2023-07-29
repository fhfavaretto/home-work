#include 'protheus.ch'
#include 'tbiconn.ch'
#include 'parmtype.ch'
#Include "TOTVS.ch"




User Function UTLCAD()
Local oDgl1 
local cTituloJanela := "AUXILIAR CONSULTOR"
local oTButton1   
local oTButton2   
local oTButton3   
local oTButton4   
local oTButton5   
local oTButton6   
local oTButton7  
local oTButton8  
local oTButton9  
local oTButton10  
local oTButton11   
local oTButton12   
local oTButton13  
local oTButton14   
local oTButton15   
local oTButton16  
local oTButton17  
local oTButton18   
local oSay1
local oSay2



oDgl1 := TDialog():New(0,0,600,640,cTituloJanela,,,,,CLR_BLACK,CLR_WHITE,,,.T.)


oSay1:= TSay():Create(oDgl1,{||'Rotinas'},10,75,,,,,,.T.,CLR_BLACK,CLR_WHITE,600,60)
oTButton1 := TButton():New( 30, 50,"FTP",oDgl1,{||U_TRANSARQ()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )  // Relatorio Vinculo Funcional
oTButton2 := TButton():New( 60, 50,"Exec Func",oDgl1,{||U_EXECFUNC()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )       //Relatùrio de usuùrios e seus respectivos acessos.
oTButton3 := TButton():New( 90, 50,"Cria Relatorio",oDgl1,{||U_zReport()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )                       // zReport - Criaùùo de usuarios
oTButton4 := TButton():New( 120, 50,"Analise Estoque",oDgl1,{||U_ANALISE()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )           //
oTButton5 := TButton():New( 150,50, "Rel. saldo Estoque",oDgl1,{||U_SALDDIFF()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )               //
oTButton6 := TButton():New( 180,50, "SQL",oDgl1,{|| u_zTiSQL()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )        //



oTButton7 := TButton():New( 30, 200, "IPROTOOLS",oDgl1,{|| U_iprotools()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )              //
oTButton8 := TButton():New( 60, 200, "EXPORTA SXS",oDgl1,{|| U_EXPORDIC()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )    //
oTButton9 := TButton():New( 90, 200, "CONFIG MAIL",oDgl1,{|| U_FSENVMAIL()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )     //
oTButton10 := TButton():New(120,200, "Relatorio Sistema",oDgl1,{|| U_SQLERP()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )            //
oTButton11 := TButton():New(150,200, "Relatorio Database",oDgl1,{|| U_SQLERP()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )            //
oTButton12 := TButton():New(180,200, "em construcao",oDgl1,{|| U_UPDUO02()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )            //
oTButton13 := TButton():New(220,280, "Ajuda ?",oDgl1,{|| U_UPDUO02()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )            //


//oTButton8 := TButton():New( 90,115, "ENCERRAR",oDgl1,{|| oDgl1:End()}, 70,20,,,.F.,.T.,.F.,,.F.,,,.F. )

oDgl1:Activate(,,,.T.) // parametro para ativar a tela marcada como .T. para centralizar no meio


Return






 


