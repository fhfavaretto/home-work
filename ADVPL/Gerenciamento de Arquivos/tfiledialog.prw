#INCLUDE "TOTVS.CH"
  
User Function FileDlg()
local tmp := getTempPath()
local targetDir:= tFileDialog( "All files (*.*) | All Text files (*.txt) ",;
        'Selecao de Arquivos',, tmp, .F., GETF_MULTISELECT )
 
    msgAlert(targetDir)
return
