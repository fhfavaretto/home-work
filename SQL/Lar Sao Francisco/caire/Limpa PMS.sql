SELECT * FROM SD1010 WHERE D1_DOC IN ('000100400','000652784','000014488','000018911') AND D1_FILIAL = '11051';
SELECT * FROM SC7010 WHERE C7_NUM IN ('070919','071389','069444','071622') AND C7_FILIAL = '11051';
SELECT * FROM SC1010 WHERE C1_NUM IN ('039310','038293','037741','039732') AND C1_FILENT = '11051';

UPDATE AFG010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE AFG_FILIAL = '11051' AND AFG_NUMSC IN ('039310','038293','037741','039732') ;
UPDATE AJ7010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE AJ7_FILIAL = '11051' AND AJ7_NUMPC IN ('070919','071389','069444','071622') ;
UPDATE AFN010 SET D_E_L_E_T_='*' WHERE AFN_FILIAL = '11051' AND AFN_DOC IN ('000100400','000652784','000014488','000018911') ;
UPDATE AFR010 SET D_E_L_E_T_='*' WHERE AFR_FILIAL = '11051' AND AFR_NUM IN ('000100400','000652784','000014488','000018911') ;