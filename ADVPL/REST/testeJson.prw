#include "protheus.ch"

user function JsonObj()
local cJSON as char
local cError as char
local nLoop as numeric
local jJSON

//JSON que será utilizado, ainda em formato string
cJSON := '[{"id":30,"ativo":true,"codigo":"000001","nome_comercial":"BEBEDOURO ROSCAVEL"}]'

//Cria o objeto de parser do JSON
jJSON := JSONObject():New()

//Efetuar o parser do JSON
cError := jJSON:fromJSON(cJSON)

//Se vazio, significa que o parser ocorreu sem erros
if Empty(cError)
    ConOut("Leitura do JSON:")

    // ****************************************
    // Essa é a parte importante. Neste ponto, 
    // você precisa listar as propriedades
    // existentes no seu objeto JSON ao invés
    // de simplesmente utilizar a função Len
    // no objeto JSON.
    // ****************************************

    aNames := jJSON:GetNames()

    //Como o JSON é um array, criado um laço para a exibição de valores
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
