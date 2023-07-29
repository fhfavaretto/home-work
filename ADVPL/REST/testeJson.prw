#include "protheus.ch"

user function JsonObj()
local cJSON as char
local cError as char
local nLoop as numeric
local jJSON

//JSON que ser� utilizado, ainda em formato string
cJSON := '[{"id":30,"ativo":true,"codigo":"000001","nome_comercial":"BEBEDOURO ROSCAVEL"}]'

//Cria o objeto de parser do JSON
jJSON := JSONObject():New()

//Efetuar o parser do JSON
cError := jJSON:fromJSON(cJSON)

//Se vazio, significa que o parser ocorreu sem erros
if Empty(cError)
    ConOut("Leitura do JSON:")

    // ****************************************
    // Essa � a parte importante. Neste ponto, 
    // voc� precisa listar as propriedades
    // existentes no seu objeto JSON ao inv�s
    // de simplesmente utilizar a fun��o Len
    // no objeto JSON.
    // ****************************************

    aNames := jJSON:GetNames()

    //Como o JSON � um array, criado um la�o para a exibi��o de valores
    for nLoop := 1 to Len(aNames)

        cIndice := aNames[nLoop]

        ConOut("", Replicate("=", 15) + Space(2) + cValToChar(nLoop) + Space(2) + Replicate("=", 15))

        //Valores do JSON
        ConOut("id = " + cValToChar(jJSON[cIndice]["id"]))
        ConOut("ativo = " + cValToChar(jJSON[cIndice]["ativo"]))
        ConOut("codigo = " + jJSON[cIndice]["codigo"])
        ConOut("nome_comercial = " + jJSON[cIndice]["nome_comercial"])
    next
else
    //Em caso de erros do parser, exibe os mesmos no console
    ConOut("Erro no parser do JSON:", cError)
endif

return nil
