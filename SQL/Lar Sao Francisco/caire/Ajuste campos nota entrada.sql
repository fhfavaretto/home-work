SELECT * FROM SF1010 WHERE F1_DOC IN('000002881') AND F1_FILIAL = '11032' AND F1_FORNECE = '009386' AND D_E_L_E_T_=' ';
UPDATE SF1010 SET F1_EMISSAO = '20180316' WHERE F1_DOC IN('000002881') AND F1_FILIAL = '11032' AND F1_FORNECE = '009386' AND D_E_L_E_T_=' ';

SELECT * FROM SD1010 WHERE D1_DOC IN('000002881') AND D1_FILIAL = '11032' AND D1_FORNECE = '009386' AND D_E_L_E_T_=' ';
UPDATE SD1010 SET D1_EMISSAO = '20180316' WHERE D1_DOC IN('000002881') AND D1_FILIAL = '11032' AND D1_FORNECE = '009386' AND D_E_L_E_T_=' ';

SELECT * FROM SE2010 WHERE E2_NUM IN('000002881') AND E2_FILIAL = '11032' AND E2_FORNECE = '009386' AND D_E_L_E_T_=' ';
UPDATE SE2010 SET E2_EMISSAO = '20180316',E2_EMIS1='20180316' WHERE E2_NUM IN('000002881') AND E2_FILIAL = '11032' AND E2_FORNECE = '009386' AND D_E_L_E_T_=' ';

SELECT * FROM SEV010 WHERE EV_NUM IN('000002881') AND EV_FILIAL = '11032' AND EV_CLIFOR = '009386' AND D_E_L_E_T_=' ';
UPDATE SEV010 SET EV_NATUREZ='5401001008' WHERE EV_NUM IN('000002881') AND EV_FILIAL = '11032' AND EV_CLIFOR = '009386' AND D_E_L_E_T_=' ';
UPDATE SEV010 SET EV_PERC = 1, EV_VALOR = 5470 WHERE R_E_C_N_O_= 390375;
UPDATE SEV010 SET D_E_L_E_T_='*' WHERE R_E_C_N_O_= 390376;

SELECT * FROM SE5010 WHERE E5_NUMERO IN('000002881') AND E5_FILIAL = '11032' AND E5_CLIFOR = '009386' AND D_E_L_E_T_=' ';
UPDATE SE5010 SET E5_NATUREZ='5401001008' WHERE E5_NUMERO IN('000002881') AND E5_FILIAL = '11032' AND E5_CLIFOR = '000850' AND D_E_L_E_T_=' ';

/*===================================EXCLUS�O============================================================================================================================*/
SELECT * FROM SF1010 WHERE F1_DOC = '000002787' AND F1_FILIAL = '11053' AND F1_FORNECE = '006411';
UPDATE SF1010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE F1_DOC = '000002787' AND F1_FILIAL = '11053' AND F1_FORNECE = '006411';

SELECT * FROM SD1010 WHERE D1_DOC = '000000570' AND D1_FILIAL = '11049' AND D1_FORNECE = '005843';
UPDATE SD1010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE D1_DOC = '000002787' AND D1_FILIAL = '11053' AND D1_FORNECE = '006411';

SELECT * FROM SE2010 WHERE E2_NUM = '000000570' AND E2_FILIAL = '11049' AND E2_FORNECE = '005843';
UPDATE SE2010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE E2_NUM = '000002787' AND E2_FILIAL = '11053' AND E2_FORNECE = '006411';

SELECT * FROM SEV010 WHERE EV_NUM = '000000570' AND EV_FILIAL = '11049' AND EV_CLIFOR = '005843';
UPDATE SEV010 SET D_E_L_E_T_='*' WHERE EV_NUM = '000002787' AND EV_FILIAL = '11053' AND EV_CLIFOR = '006411';

SELECT * FROM SE5010 WHERE E5_NUMERO = '000000570' AND E5_FILIAL = '11049' AND E5_CLIFOR = '005843';
UPDATE SE5010 SET D_E_L_E_T_='*' WHERE E5_NUMERO = '000002787' AND E5_FILIAL = '11053' AND E5_CLIFOR = '006411';


/*============================================NOTAS COM DESCRICAO DE NATUREZA DIFERENTE DO CODIGO===========================================================================================================================*/

SELECT D1_FILIAL, D1_SERIE, D1_DOC, D1__NATURE, D1_X_DNATU,(SELECT ED_DESCRIC FROM SED010 WHERE ED_CODIGO = D1__NATURE AND SED010.D_E_L_E_T_=' ') ED_NAT  FROM SD1010 WHERE /*D1_X_DNATU != (SELECT ED_DESCRIC FROM SED010 WHERE ED_CODIGO = D1__NATURE AND SED010.D_E_L_E_T_=' ') AND*/ SD1010.D_E_L_E_T_=' ';

UPDATE SD1010 SET D1_X_DNATU = (SELECT ED_DESCRIC FROM SED010 WHERE ED_CODIGO = D1__NATURE AND SED010.D_E_L_E_T_=' ') WHERE D1_X_DNATU != (SELECT ED_DESCRIC FROM SED010 WHERE ED_CODIGO = D1__NATURE AND SED010.D_E_L_E_T_=' ') AND SD1010.D_E_L_E_T_=' ';

SELECT * FROM SED010 WHERE ED_CODIGO = '5401001008';
