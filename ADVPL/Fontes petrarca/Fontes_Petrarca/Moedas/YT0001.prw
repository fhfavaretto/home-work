#include 'totvs.ch'

/*/{Protheus.doc} YT0001
@type User Function
@author Maico Gustavo
@since 17/06/2023
@version 1.0
Grava dados de cotacao diaria na tabela SM2. Essa funcao sera acionada automaticamente a partir do ponto de entrada
/*/
User Function YT0001 ()

Local cURL      := 'https://www4.bcb.gov.br/download/fechamento/' //20230618.csv 
Local cData     := dtos(datavalida(ddatabase -1, .F.))  
Local cArquivo  := ''
Local cDirMoeda := '\_bcb\'
Local cBuffer   := ''
Local aLinha    := array (0)
Local nHdl      := 0
Local nKWDcomp  := 0
Local nUSDcomp  := 0
Local nEURcomp  := 0
Local nBHDcomp  := 0
Local nOMRcomp  := 0
Local nJODcomp  := 0  
Local nGBPcomp  := 0
Local nKYDcomp  := 0
Local nCHFcomp  := 0
Local nCADcomp  := 0




cURL            += cData + '.csv'

cArquivo        := httpget (cURL)

IF .not. existDir(cDirMoeda)
    makeDir(cDirMoeda)
EndIF

memowrite(cDirMoeda + cData + '.csv',cArquivo)

nHdl            := FT_FUSE(cDirMoeda + cData + '.csv')

IF nHdl = -1 
    fwAlertError('ERRO NA ABERTURA DO ARQUIVO DE COTACOES','[ERRO]')
    return
EndIF

            FT_FGOTOP()

while .not. FT_FEOF()
 
            cBuffer := FT_FREADLN()
            aLinha  := strtokarr(cBuffer, ";")

            IF valtype(aLinha) <> 'A'
               FT_FSKIP()
               Loop
            EndIF

            IF len(aLinha) < 6    
               FT_FSKIP()
               Loop
            EndIF   

            IF alltrim(aLinha[4]) == 'KWD'
               nKWDcomp := val(strtran(aLinha[5],",","."))

                 FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'USD'
               nUSDcomp := val(strtran(aLinha[5],",","."))
               
               
               FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'EUR'
               nEURcomp := val(strtran(aLinha[5],",","."))

               FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'BHD'
               nBHDcomp := val(strtran(aLinha[5],",","."))

                  FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'OMR'
               nOMRcomp := val(strtran(aLinha[5],",","."))

               FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'JOD'
               nJODcomp := val(strtran(aLinha[5],",","."))

               FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'GBP'
               nGBPcomp := val(strtran(aLinha[5],",","."))

                 FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'KYD'
               nKYDcomp := val(strtran(aLinha[5],",","."))

                 FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'CHF'
               nCHFcomp := val(strtran(aLinha[5],",","."))

                 FT_FSKIP()
               Loop
            EndIF

            IF alltrim(aLinha[4]) == 'CAD'
               nCADcomp := val(strtran(aLinha[5],",","."))

               FT_FSKIP()
               Loop
            EndIF

               FT_FSKIP()
     
Enddo

FT_FUSE()

IF SM2-> (dbSetOrder(1),dbSeek(ddatabase))

    IF SM2->M2_INFORM == 'S'
       return
Else

SM2->(reclock(alias(),.F.), M2_DATA := ddatabase, M2_INFORM := 'S', M2_MOEDA1 := nCADcomp, M2_MOEDA2 := nUSDcomp, M2_MOEDA3 := nEURcomp, M2_MOEDA4 := nKWDcomp, M2_MOEDA5 := nBHDcomp, M2_MOEDA6 := nOMRcomp, M2_MOEDA7 := nJODcomp, M2_MOEDA8 := nGBPcomp, M2_MOEDA9 := nKYDcomp, M2_MOED10 := nCHFcomp,msunLock())

/*/

dbSelectArea('SM2')
dbSetorder(1)

reclock('SM2',1.F.)
       SM2->M2_INFORM := 'S' msunlock ()
msunlock()
/*/

    EndIF

Else

SM2->(reclock(alias(),.T.), M2_DATA := ddatabase, M2_INFORM := 'S', M2_MOEDA1 := nCADcomp, M2_MOEDA2 := nUSDcomp, M2_MOEDA3 := nEURcomp, M2_MOEDA4 := nKWDcomp, M2_MOEDA5 := nBHDcomp, M2_MOEDA6 := nOMRcomp, M2_MOEDA7 := nJODcomp, M2_MOEDA8 := nGBPcomp, M2_MOEDA9 := nKYDcomp, M2_MOED10 := nCHFcomp,msunLock())

    EndIF

Return 
