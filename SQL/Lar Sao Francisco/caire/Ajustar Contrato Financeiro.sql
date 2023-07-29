SELECT * FROM SE2010 WHERE D_E_L_E_T_=' ' AND E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA IN (SELECT D1_FILIAL||D1_SERIE||D1_DOC||D1_FORNECE||D1_LOJA FROM SD1010 JOIN SC7010 ON C7_FILIAL = D1_FILIAL AND C7_NUM = D1_PEDIDO AND SC7010.D_E_L_E_T_=' ' AND C7_CONTRA <> ' ' WHERE SD1010.D_E_L_E_T_=' ') AND E2_MDCONTR =' ';

UPDATE SE2010 SET E2_MDCONTR = 'S' WHERE D_E_L_E_T_=' ' AND E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA IN (SELECT D1_FILIAL||D1_SERIE||D1_DOC||D1_FORNECE||D1_LOJA FROM SD1010 JOIN SC7010 ON C7_FILIAL = D1_FILIAL AND C7_NUM = D1_PEDIDO AND SC7010.D_E_L_E_T_=' ' AND C7_CONTRA <> ' ' WHERE SD1010.D_E_L_E_T_=' ') AND E2_TIPO <> 'PR' AND E2_MDCONTR <> 'S';

SELECT * FROM SE1010 WHERE D_E_L_E_T_=' ' AND E1_FILIAL||E1_PREFIXO||E1_NUM||E1_CLIENTE||E1_LOJA IN (SELECT D2_FILIAL||D2_SERIE||D2_DOC||D2_CLIENTE||D2_LOJA FROM SD2010 JOIN SC5010 ON C5_FILIAL = D2_FILIAL AND C5_NUM = D2_PEDIDO AND SC5010.D_E_L_E_T_=' ' AND C5_MDCONTR <> ' ' WHERE SD2010.D_E_L_E_T_=' ') AND E1_MDCONTR = ' ';

UPDATE SE1010 SET E1_MDCONTR = 'S' WHERE D_E_L_E_T_=' ' AND E1_FILIAL||E1_PREFIXO||E1_NUM||E1_CLIENTE||E1_LOJA IN (SELECT D2_FILIAL||D2_SERIE||D2_DOC||D2_CLIENTE||D2_LOJA FROM SD2010 JOIN SC5010 ON C5_FILIAL = D2_FILIAL AND C5_NUM = D2_PEDIDO AND SC5010.D_E_L_E_T_=' ' AND C5_MDCONTR <> ' ' WHERE SD2010.D_E_L_E_T_=' ') AND E1_TIPO <> 'PR'  AND E1_MDCONTR <> 'S';


SELECT * FROM SE2010 WHERE E2_MDCONTR <> ' ';

SELECT * FROM SE5010 WHERE E5_OK <> ' ';

UPDATE SE5010 SET E5_X_CONTR = 'S' WHERE E5_FILIAL||E5_PREFIXO||E5_NUMERO||E5_CLIFOR||E5_LOJA||E5_TIPO IN (SELECT E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA||E2_TIPO FROM SE2010 WHERE E2_MDCONTR = 'S') AND E5_RECPAG = 'P' AND SE5010.D_E_L_E_T_=' ' AND E5_X_CONTR = ' ';
UPDATE SE5010 SET E5_X_CONTR = 'S' WHERE E5_FILIAL||E5_PREFIXO||E5_NUMERO||E5_CLIFOR||E5_LOJA||E5_TIPO IN (SELECT E1_FILIAL||E1_PREFIXO||E1_NUM||E1_CLIENTE||E1_LOJA||E1_TIPO FROM SE1010 WHERE E1_MDCONTR = 'S') AND E5_RECPAG = 'R' AND SE5010.D_E_L_E_T_=' ' AND E5_X_CONTR = ' ';

SELECT * FROM SE5010 WHERE E5_OK = 'S';
UPDATE SE5010 SET E5_X_CONTR = 'S' WHERE E5_OK = 'S';

SELECT * FROM SC7010 WHERE C7_CONTRA <> ' ' AND D_E_L_E_T_=' ' AND C7_QUJE = 0;
SELECT * FROM SD2010;
SELECT * FROM SC5010 WHERE C5_MDCONTR <> ' ';

SELECT B1_FILIAL, D1_COD, B1_DESC, B1_TIPO, B1_CODISS FROM SD1010 JOIN SB1010 ON SUBSTR(B1_FILIAL,1,2) = SUBSTR(D1_FILIAL,1,2) AND B1_COD = D1_COD AND SB1010.D_E_L_E_T_=' '
WHERE SD1010.D_E_L_E_T_=' ' AND B1_TIPO = 'SV' AND D1_EMISSAO >= '20171001' GROUP BY B1_FILIAL, D1_COD, B1_DESC, B1_TIPO, B1_CODISS;

SELECT B1_FILIAL, D2_COD, B1_DESC, B1_TIPO, B1_CODISS FROM SD2010 JOIN SB1010 ON SUBSTR(B1_FILIAL,1,2) = SUBSTR(D2_FILIAL,1,2) AND B1_COD = D2_COD AND SB1010.D_E_L_E_T_=' '
WHERE SD2010.D_E_L_E_T_=' ' AND B1_TIPO = 'SV' AND D2_EMISSAO >= '20171001' GROUP BY B1_FILIAL, D2_COD, B1_DESC, B1_TIPO, B1_CODISS;

SELECT * FROM SB1010;

SELECT * FROM SC7010 WHERE C7_NUM = '378197';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '378197';
SELECT * FROM SC1010 WHERE C1_NUM = '967331';
SELECT * FROM AFG010 WHERE AFG_NUMSC = '967331';

SELECT * FROM SA6010 WHERE A6_FILIAL = '11001' AND A6_NUMCON = '00004921';
UPDATE SA6010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE A6_FILIAL = '11001' AND A6_NUMCON = '00004921' AND A6_AGENCIA = '1916';

SELECT * FROM SE5010 WHERE E5_BENEF LIKE '% AUTOMATICO %' AND E5_DATA > '20180901' ;

SELECT RV_COD, RV_TIPOCOD FROM SRV010 WHERE D_E_L_E_T_=' ';

SELECT * FROM SC1010;

SELECT * FROM SE5010 WHERE E5_X_REPAS <> ' ';

SELECT * FROM AFG010 WHERE AFG_X_NTG1 <> ' ' OR AFG_X_NTG2 <> ' ';

UPDATE AFG010 SET AFG_X_NTG1 = NVL((SELECT AF9_X_NATG FROM AF9010 WHERE AF9_FILIAL = AFG_FILIAL AND AF9_PROJET = AFG_PROJET AND AF9_TAREFA = AFG_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' '), 
AFG_X_NTG2 = NVL((SELECT AF9_X_NTP2 FROM AF9010 WHERE AF9_FILIAL = AFG_FILIAL AND AF9_PROJET = AFG_PROJET AND AF9_TAREFA = AFG_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' ')
WHERE AFG_X_NTG1 = ' ' OR AFG_X_NTG2 =' ';

UPDATE AJ7010 SET AJ7_X_NTG1 = NVL((SELECT AF9_X_NATG FROM AF9010 WHERE AF9_FILIAL = AJ7_FILIAL AND AF9_PROJET = AJ7_PROJET AND AF9_TAREFA = AJ7_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' '), 
AJ7_X_NTG2 = NVL((SELECT AF9_X_NTP2 FROM AF9010 WHERE AF9_FILIAL = AJ7_FILIAL AND AF9_PROJET = AJ7_PROJET AND AF9_TAREFA = AJ7_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' ')
WHERE AJ7_X_NTG1 = ' ' OR AJ7_X_NTG1 =' ';

UPDATE AFN010 SET AFN_X_NTG1 = NVL((SELECT AF9_X_NATG FROM AF9010 WHERE AF9_FILIAL = AFN_FILIAL AND AF9_PROJET = AFN_PROJET AND AF9_TAREFA = AFN_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' '), 
AFN_X_NTG2 = NVL((SELECT AF9_X_NTP2 FROM AF9010 WHERE AF9_FILIAL = AFN_FILIAL AND AF9_PROJET = AFN_PROJET AND AF9_TAREFA = AFN_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' ')
WHERE AFN_X_NTG1 = ' ' OR AFN_X_NTG1 =' ';

UPDATE AFR010 SET AFR_X_NTG1 = NVL((SELECT AF9_X_NATG FROM AF9010 WHERE AF9_FILIAL = AFR_FILIAL AND AF9_PROJET = AFR_PROJET AND AF9_TAREFA = AFR_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' '), 
AFR_X_NTG2 = NVL((SELECT AF9_X_NTP2 FROM AF9010 WHERE AF9_FILIAL = AFR_FILIAL AND AF9_PROJET = AFR_PROJET AND AF9_TAREFA = AFR_TAREFA AND AF9010.D_E_L_E_T_=' ' AND AF9_REVISA = (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AF9_FILIAL AND AF8_PROJET = AF9_PROJET AND AF8010.D_E_L_E_T_=' ')),' ')
WHERE AFR_X_NTG1 = ' ' OR AFR_X_NTG1 =' ';

UPDATE SE5010 SET E5_X_REPAS = NVL((SELECT E2_X_REPAS FROM SE2010 WHERE E2_FILIAL = E5_FILIAL AND E2_PREFIXO = E5_PREFIXO AND E2_NUM = E5_NUMERO AND E2_FORNECE = E5_FORNECE AND E2_LOJA = E5_LOJA AND SE2010.D_E_L_E_T_=' ' AND E2_TIPO = E5_TIPO AND E2_PARCELA = E5_PARCELA),' '),
E5_X_CPMS = NVL((SELECT TRIM(E2_X_CPMS) FROM SE2010 WHERE E2_FILIAL = E5_FILIAL AND E2_PREFIXO = E5_PREFIXO AND E2_NUM = E5_NUMERO AND E2_FORNECE = E5_FORNECE AND E2_LOJA = E5_LOJA AND SE2010.D_E_L_E_T_=' ' AND E2_TIPO = E5_TIPO AND E2_PARCELA = E5_PARCELA),' ') 
WHERE (E5_X_REPAS = ' ' OR E5_X_CPMS = ' ') AND D_E_L_E_T_=' ' ;
 
SELECT * FROM SRV010 WHERE D_E_L_E_T_=' ' AND RV_ADICTS NOT IN ('S','1',' ');

SELECT * FROM SF1010 WHERE F1_DTDIGIT <> F1_EMISSAO AND D_E_L_E_T_=' ' AND F1_EMISSAO > '20181001';


 