#INCLUDE "totvs.ch"
#INCLUDE "fwmbrowse.ch"


User Function MVCZF1()
	Local oBrowse
//Criação do Objeto do Tipo Browsers
	oBrowse := FWMBrowse():New()

//define Tabela(ALias) a ser usado pela browser
	oBrowse:SetAlias('ZF1')

//Define Descrição do Objeto do Tipo Browsers
	oBrowse:SetDescription("Cadastro de Contas")

/*legendas
    Lista de cores para utilizar na Legenda
    01	WHITE	BR_BRANCO
    02	GRAY	BR_CINZA
    03	GREEN	BR_VERDE
    04	RED	BR_VERMELHO
    05	BROWN	BR_MARROM
    06	BLUE	BR_AZUL
    07	YELLOW	BR_AMARELO
    08	BLACK	BR_PRETO
    09	PINK	BR_PINK
    10	F12_MARR	BR_VIOLETA
    11	ORANGE	BR_PRETO_0
    12	LIGHTBLU	BR_PRETO_1
    13	 	BR_PRETO_3
    14	 	BR_CANCEL
    15	 	BR_VERDE_ESCURO
    16	 	BR_MARROM
    17	 	BR_MARRON_OCEAN
    18	 	BR_AZUL_CLARO
    */

//	oBrowse:addLegend("expressão","cor da legenda","Descrição da legenda")

//filtro padrão do browser 

//	oBrowse:SetFilterDefault("expressão")

//desabilita os detalhes do browse - não gosto mais tem cliente que usa
	oBrowse:DisableDetails()

//	oBrowse:SetMenuDef('MVCZF1')



//Ativa o browse
	oBrowse:ACTIVATE()

RETURN



static function MenuDef()
local aRotina as array

aRotina := {}

aAdd(aRotina, {"Pesquisar", "AxPesqui", 0, 1})
aAdd(aRotina, {"Visualizar", "AxVisual", 0, 2})
aAdd(aRotina, {"Incluir", "AxInclui", 0, 3})
aAdd(aRotina, {"Alterar", "AxAltera", 0, 4})
aAdd(aRotina, {"Excluir", "AxDeleta", 0, 5})

return aRotina

