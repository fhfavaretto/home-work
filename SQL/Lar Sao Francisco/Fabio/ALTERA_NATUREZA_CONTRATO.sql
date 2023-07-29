/* Este script é pra localizar o contrato e ver se ta certo a consulta que vai alterar */
SELECT * FROM CN9010 WHERE CN9_FILIAL = '11001' AND LTRIM(CN9_NUMERO,'0') = '1' AND CN9_SITUAC = '05' AND D_E_L_E_T_<>'*' ; 

/* Este é o script que altera */
UPDATE CN9010 SET CN9_NATURE ='1234567890' WHERE CN9_FILIAL = '11001' AND LTRIM(CN9_NUMERO,'0') = '1' AND CN9_SITUAC = '05' AND D_E_L_E_T_<>'*' ;