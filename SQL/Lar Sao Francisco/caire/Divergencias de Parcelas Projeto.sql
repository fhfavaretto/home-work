SELECT 

AF9_FILIAL, AF9_PROJET, (SELECT AF8_DESCRI FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ') PROJETO, AF9_TAREFA, AF9_DESCRI,
AF9_X_PC01, AF9_X_PO01, AF9_X_PC02, AF9_X_PO02, AF9_X_PC03, AF9_X_PO03, AF9_X_PC04, AF9_X_PO04, AF9_X_PC05, AF9_X_PO05, AF9_X_PC06, AF9_X_PO06, AF9_X_PC07, AF9_X_PO07, AF9_X_PC08, AF9_X_PO08, AF9_X_PC09, AF9_X_PO09, AF9_X_PC10, AF9_X_PO10, AF9_X_PC11, AF9_X_PO11, AF9_X_PC12, AF9_X_PO12,
CASE WHEN AF9_X_PO01 <> AF9_X_PO02 AND AF9_X_PO02 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO03 AND AF9_X_PO03 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO04 AND AF9_X_PO04 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO05 AND AF9_X_PO05 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO06 AND AF9_X_PO06 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO07 AND AF9_X_PO07 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO08 AND AF9_X_PO08 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO09 AND AF9_X_PO09 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO10 AND AF9_X_PO10 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO11 AND AF9_X_PO11 <> 0 THEN 'DIFERENTE' 
WHEN AF9_X_PO01 <> AF9_X_PO12 AND AF9_X_PO12 <> 0 THEN 'DIFERENTE' 
ELSE 'OK' END DIFERENTE,
AF9010.R_E_C_N_O_

FROM AF9010 WHERE D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ') 
ORDER BY AF9_FILIAL, AF9_PROJET, AF9_TAREFA;



SELECT 

AF9_FILIAL, AF9_PROJET, (SELECT AF8_DESCRI FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ') PROJETO, AF9_TAREFA, AF9_DESCRI,
--AF9_X_PC01, AF9_X_PO01, AF9_X_PC02, AF9_X_PO02, AF9_X_PC03, AF9_X_PO03, AF9_X_PC04, AF9_X_PO04, AF9_X_PC05, AF9_X_PO05, AF9_X_PC06, AF9_X_PO06, AF9_X_PC07, AF9_X_PO07, AF9_X_PC08, AF9_X_PO08, AF9_X_PC09, AF9_X_PO09, AF9_X_PC10, AF9_X_PO10, AF9_X_PC11, AF9_X_PO11, AF9_X_PC12, AF9_X_PO12,
AF9_X_PO01+AF9_X_PO02+AF9_X_PO03+AF9_X_PO04+AF9_X_PO05+AF9_X_PO06+AF9_X_PO07+AF9_X_PO08+AF9_X_PO09+AF9_X_PO10+AF9_X_PO11+AF9_X_PO12 OR�ADO,
AF9_X_PC01+AF9_X_PC02+AF9_X_PC03+AF9_X_PC04+AF9_X_PC05+AF9_X_PC06+AF9_X_PC07+AF9_X_PC08+AF9_X_PC09+AF9_X_PC10+AF9_X_PC11+AF9_X_PC12 REALIZADO,
(AF9_X_PO01+AF9_X_PO02+AF9_X_PO03+AF9_X_PO04+AF9_X_PO05+AF9_X_PO06+AF9_X_PO07+AF9_X_PO08+AF9_X_PO09+AF9_X_PO10+AF9_X_PO11+AF9_X_PO12) - (AF9_X_PC01+AF9_X_PC02+AF9_X_PC03+AF9_X_PC04+AF9_X_PC05+AF9_X_PC06+AF9_X_PC07+AF9_X_PC08+AF9_X_PC09+AF9_X_PC10+AF9_X_PC11+AF9_X_PC12) DIFEREN�A,
AF9010.R_E_C_N_O_



FROM AF9010 WHERE D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ') 
AND (AF9_X_PO01+AF9_X_PO02+AF9_X_PO03+AF9_X_PO04+AF9_X_PO05+AF9_X_PO06+AF9_X_PO07+AF9_X_PO08+AF9_X_PO09+AF9_X_PO10+AF9_X_PO11+AF9_X_PO12) - (AF9_X_PC01+AF9_X_PC02+AF9_X_PC03+AF9_X_PC04+AF9_X_PC05+AF9_X_PC06+AF9_X_PC07+AF9_X_PC08+AF9_X_PC09+AF9_X_PC10+AF9_X_PC11+AF9_X_PC12) <> 0
;

SELECT * FROM SD1010 WHERE D1_X_DTPMS <> ' ' 
AND D1_FILIAL||D1_SERIE||D1_DOC||D1_FORNECE||D1_LOJA NOT IN 
(SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ') AND SD1010.D_E_L_E_T_=' ';

UPDATE SD1010 SET D1_X_DTPMS = ' ' WHERE D1_X_DTPMS <> ' ' 
AND D1_FILIAL||D1_SERIE||D1_DOC||D1_FORNECE||D1_LOJA NOT IN 
(SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ') AND SD1010.D_E_L_E_T_=' ';

CREATE TABLE SD1010_BKP_220517 AS SELECT * FROM SD1010;


UPDATE AF9010 SET AF9_X_PC01 = AF9_X_PO01,AF9_X_PC02 = AF9_X_PO02,AF9_X_PC03 = AF9_X_PO03,AF9_X_PC04 = AF9_X_PO04,AF9_X_PC05 = AF9_X_PO05 WHERE R_E_C_N_O_ IN (0);






