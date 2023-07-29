//Bibiliotecas
#Include "Protheus.ch"
  
/*/{Protheus.doc} zAtuPerg
Fun��o que atualiza o conte�do de uma pergunta no X1_CNT01 / SXK / Profile
@author Atilio
@since 06/10/2016
@version 1.0
@type function
    @param cPergAux, characters, C�digo do grupo de Pergunta
    @param cParAux, characters, C�digo do par�metro
    @param xConteud, variavel, Conte�do do par�metro
    @example u_zAtuPerg("LIBAT2", "MV_PAR01", "000001")
/*/
  
User Function zAtuPerg(cPergAux, cParAux, xConteud)
    Local aArea      := GetArea()
    Local nPosPar    := 14
    Local nLinEncont := 0
    Local aPergAux   := {}
    Default xConteud := ''
      
    //Se n�o tiver pergunta, ou n�o tiver ordem
    If Empty(cPergAux) .Or. Empty(cParAux)
        Return
    EndIf
      
    //Chama a pergunta em mem�ria
    Pergunte(cPergAux, .F., /*cTitle*/, /*lOnlyView*/, /*oDlg*/, /*lUseProf*/, @aPergAux)
      
    //Procura a posi��o do MV_PAR
    nLinEncont := aScan(aPergAux, {|x| Upper(Alltrim(x[nPosPar])) == Upper(cParAux) })
      
    //Se encontrou o par�metro
    If nLinEncont > 0
        //Caracter
        If ValType(xConteud) == 'C'
            &(cParAux+" := '"+xConteud+"'")
          
        //Data
        ElseIf ValType(xConteud) == 'D'
            &(cParAux+" := sToD('"+dToS(xConteud)+"')")
              
        //Num�rico ou L�gico
        ElseIf ValType(xConteud) == 'N' .Or. ValType(xConteud) == 'L'
            &(cParAux+" := "+cValToChar(xConteud)+"")
          
        EndIf
          
        //Chama a rotina para salvar os par�metros
        __SaveParam(cPergAux, aPergAux)
    EndIf
      
    RestArea(aArea)
Return
