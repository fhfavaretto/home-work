#include 'totvs.ch'

/*/{Protheus.doc} YT0002
Programa para consulta de dados cadastrais de empresas a partir de CNPJ enviado via parametro ou por retorno da funcao readvar ()
@type User Function
@author Maico Gustavo
@since 19/06/2023
@version 1.0
@eparam cCNPJ, C, CNPJ a ser pesquisada
/*/

User Function YT0002(cParam)

LocaL cCNPJ    := ''
Local cURL     := ' https://www.receitaws.com.br/vl/cnpj/'
Local cReadVar := readvar()
Local oJsonRet := nil
Local xJsonRet := nil
Local xRet     := nil 


Default cParam := ''


IF empty(cParam)

    IF empty(cReadVar)
       return xRet
    EndIF 

    IF .not. alltrim(cReadvar) $ "M->A1_CGC|M->A2_CGC"
       xRet    := .T.
       return xRet
    EndIF 

    cCNPJ       := &(cReadVar)
    xRet        := .T.

else
    
    cCNPJ       := cParam
    xRet        := array(0)

EndIF

cCNPJ           := strtran(strtran(strtran(cCNPJ,".",""),"-",""),"/","")
cURL            += cCNPJ 

cTxtRet         := httpGet(cURL)
oJsonRet        := jsonObject():new() 
xJsonRet        := oJsonRet:fromJson(fwNoAccent(cTxtRet))

IF valtype(xJsonRet) <> 'U'
     return xRet
EndIF     

cNome          := oJsonRet:getJsonText('nome'                     )
cNome          := fwNoAccent(upper(iif(cNome       == 'null','',cNome    )))

cNomeRe        := oJsonRet:getJsonText('fantasia'                 )
cNomeRe        := fwNoAccent(upper(iif(cNomeRe     == 'null','',cNomeRe  )))

cDtAber        := oJsonRet:getJsonText('abertura'                 )
cDtAber        := fwNoAccent(upper(iif(cDtAber     == 'null','',cDtAber  )))

cBairro        := oJsonRet:getJsonText('bairro'                   )
cBairro        := fwNoAccent(upper(iif(cBairro     == 'null','',cBairro  )))

cCep           := oJsonRet:getJsonText('cep'                      )
cCep           := fwNoAccent(upper(iif(cCep        == 'null','',cCep     )))

cEnd           := oJsonRet:getJsonText('logradouro'               )
cEnd           := fwNoAccent(upper(iif(cEnd        == 'null','',cEnd     )))

cNrEnd         := oJsonRet:getJsonText('numero'                   )
cNrEnd         := fwNoAccent(upper(iif(cNrEnd      == 'null','',cNrEnd   )))

cCidade        := oJsonRet:getJsonText('municipio'                )
cCidade        := fwNoAccent(upper(iif(cCidade     == 'null','',cCidade  )))

cEstado        := oJsonRet:getJsonText('uf'                       )
cEstado        := fwNoAccent(upper(iif(cEstado     == 'null','',cEstado  )))

cCompl         := oJsonRet:getJsonText('complemento'              )
cCompl         := fwNoAccent(upper(iif(cCompl     == 'null','',cCompl    )))

cTel           := oJsonRet:getJsonText('telefone'                 )
cTel           := fwNoAccent(upper(iif(cTel     == 'null','',cTel        )))

cEmail         := oJsonRet:getJsonText('email'                    )
cEmail         := fwNoAccent(upper(iif(cEmail     == 'null','',cEmail    )))

cSitua         := oJsonRet:getJsonText('situacao'                 )
cSitua         := fwNoAccent(upper(iif(cSitua     == 'null','',cSitua    )))

cDtSitu        := oJsonRet:getJsonText('data_situacao'            )
cDtSitu        := fwNoAccent(upper(iif(cDtSitu     == 'null','',cDtSitu  )))

IF .not. empty(cNrEnd)
    cEnd := alltrim(cEnd) + ', ' + cNrEnd
EndIF 

cCodMun        := '''

IF .not. empty(cCidade) .and. .not. empty(cEstado)
    cCodMun    := posicione('CC2',4,xFilial('CC2')+cEstado+cCidade,'CC2_CODMUN')
    cCodMun    := iif(valtype(cCodMun) == 'C', cCodMun, '')
EndIF 

cCnae          := oJsonRet:getJsonObject('atividade_principal')

IF valtype(cCnae) == 'A'
     cCnae := cCnae[1]:getJsonText('code')
     IF valtype(cCnae)  == 'C'
          cCnae := strtran(strtran(cCnae,"_",""),".","")
     Else 
          cCnae := ''
    EndIF
else
    cCnae       := '' 
EndIF

IF valtype(xRet) == 'A'

     aadd(xRet,cNome        )
     aadd(xRet,cNomeRe      )
     aadd(xRet,ctod(cDtAber))
     aadd(xRet,cEstado      )
     aadd(xRet,cCodMun      )
     aadd(xRet,cCidade      )
     aadd(xRet,cBairro      )
     aadd(xRet,cEnd         )
     aadd(xRet,cCompl       )
     aadd(xRet,cCep         )
     aadd(xRet,cTel         )
     aadd(xRet,cEmail       )
     aadd(xRet,cSitua       )
     aadd(xRet,ctod(cDtSitu))
     aadd(xRet,cCnae        )

    IF type('__aRecWS') <> 'A'
       Public __aRecWS      := aclone(xRet)
    Else 
        __aRecWS            := aclone(xRet)
    EndIF

Else 

    IF "A1_CGC" $ cReadVar

        M->A1_NOME              := substr(cNome    ,1,tamSX3('A1_NOME'   )[1])
        M->A1_NREDUZ            := substr(cNomeRe  ,1,tamSX3('A1_NREDUZ' )[1])
        M->A1_END               := substr(cEnd     ,1,tamSX3('A1_END'    )[1])

       return .T.

    ElseIF "A2_CGC" $ cReadVar

        M->A2_NOME              := substr(cNome    ,1,tamSX3('A2_NOME'   )[1])
        M->A2_NREDUZ            := substr(cNomeRe  ,1,tamSX3('A2_NREDUZ' )[1])
        M->A2_END               := substr(cEnd     ,1,tamSX3('A2_END'    )[1])


        return .T.
    
    EndIF

EndIF

Return xRet 


