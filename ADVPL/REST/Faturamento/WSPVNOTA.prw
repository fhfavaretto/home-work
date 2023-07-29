//Bibliotecas
#Include "Totvs.ch"
#Include "RESTFul.ch"
#Include "TopConn.ch"


WSRESTFUL ZWPVNOTA DESCRIPTION 'retorna a nota a partir do pedido'
    //Atributos
    WSDATA id         AS STRING
 
    //Métodos
    WSMETHOD GET    ID     DESCRIPTION 'Retorna o registro pesquisado' WSSYNTAX '/ZWPVNOTA/get_id?{id}'                       PATH 'get_id'        PRODUCES APPLICATION_JSON
END WSRESTFUL



WSMETHOD GET ID WSRECEIVE id WSSERVICE ZWPVNOTA
    Local lRet       := .T.
    Local jResponse  := JsonObject():New()
    Local cAliasWS   := 'SC5'

    //Se o id estiver vazio
    If Empty(::id)
        Self:setStatus(500) 
        jResponse['errorId']  := 'ID001'
        jResponse['error']    := 'ID vazio'
        jResponse['solution'] := 'Informe o ID'
    Else
        DbSelectArea(cAliasWS)
        (cAliasWS)->(DbSetOrder(1))

        //Se não encontrar o registro
        If ! (cAliasWS)->(MsSeek(FWxFilial(cAliasWS) + ::id))
            Self:setStatus(500) 
            jResponse['errorId']  := 'ID002'
            jResponse['error']    := 'ID não encontrado'
            jResponse['solution'] := 'Código ID não encontrado na tabela ' + cAliasWS
        Else
            //Define o retorno
            jResponse['Numero PV'] := ALLTRIM((cAliasWS)->C5_NUM) 
            jResponse['Numero NOTA'] := (cAliasWS)->C5_NOTA 
        EndIf
    EndIf

    //Define o retorno
    Self:SetContentType('application/json')
    Self:SetResponse(jResponse:toJSON())
Return lRet
