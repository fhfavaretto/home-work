//Bibliotecas
#Include "Totvs.ch"
#Include "RESTFul.ch"
#Include "TopConn.ch"


WSRESTFUL ZWSCHAVES DESCRIPTION ''
    //Atributos
    WSDATA id         AS STRING
 
    //Métodos
    WSMETHOD GET    ID     DESCRIPTION 'Retorna o registro pesquisado' WSSYNTAX '/ZWSCHAVES/get_id?{id}'                       PATH 'get_id'        PRODUCES APPLICATION_JSON
END WSRESTFUL




WSMETHOD GET ID WSRECEIVE id WSSERVICE ZWSCHAVES
    Local lRet       := .T.
    Local jResponse  := JsonObject():New()
    Local cAliasWS   := 'SF2'

    If Empty(::id)
        Self:setStatus(500) 
        jResponse['errorId']  := 'ID001'
        jResponse['error']    := 'ID vazio'
        jResponse['solution'] := 'Informe o ID'
    Else
        DbSelectArea(cAliasWS)
        (cAliasWS)->(DbSetOrder(1))

        If ! (cAliasWS)->(MsSeek(FWxFilial(cAliasWS) + ::id))
            Self:setStatus(500) 
            jResponse['errorId']  := 'ID002'
            jResponse['error']    := 'ID não encontrado'
            jResponse['solution'] := 'Código ID não encontrado na tabela ' + cAliasWS
        Else
            //Define o retorno
            jResponse['Nota Doc.'] := alltrim((cAliasWS)->F2_DOC)
            jResponse['chave da nota'] := (cAliasWS)->F2_CHVNFE 
        EndIf
    EndIf

    //Define o retorno
    Self:SetContentType('application/json')
    Self:SetResponse(jResponse:toJSON())
Return lRet
