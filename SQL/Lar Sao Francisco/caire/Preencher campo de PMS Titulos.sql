/* VERIFICA TITULOS QUE FORAM AMARRADOS MAS O CAMPO AINDA N�O ESTA PREENCHIDO */
SELECT * FROM SE2010 WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA IN (SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ')
AND SE2010.D_E_L_E_T_=' ' AND SE2010.E2_X_CPMS = ' ' AND E2_EMISSAO >= '20200701';

SELECT * FROM SE2010 WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA IN (SELECT AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA FROM AFR010 WHERE AFR010.D_E_L_E_T_=' ' AND AFR_PROJET <> ' ')
AND SE2010.D_E_L_E_T_=' ' AND SE2010.E2_X_CPMS = ' ' AND E2_EMISSAO > '20200101' AND E2_TIPO NOT IN ('TX','INS','ISS','IRF');

UPDATE SE2010 A SET A.E2_X_CPMS = NVL((SELECT AFN_PROJET FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ' AND AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA = A.E2_FILIAL||A.E2_PREFIXO||A.E2_NUM||A.E2_FORNECE||A.E2_LOJA AND ROWNUM=1),A.E2_X_CPMS)
WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA IN (SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ' AND AFN_PROJET <> ' ')
AND A.D_E_L_E_T_=' ' AND A.E2_X_CPMS = ' ' AND A.E2_EMISSAO > '20200701' AND A.E2_TIPO NOT IN ('TX','INS','ISS','IRF');

UPDATE SE2010 A SET A.E2_X_CPMS = (SELECT AFR_PROJET FROM AFR010 WHERE AFR010.D_E_L_E_T_=' ' AND AFR_PROJET <> ' ' AND AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA = E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA AND ROWNUM=1)
WHERE A.E2_FILIAL||A.E2_PREFIXO||A.E2_NUM||A.E2_FORNECE||A.E2_LOJA IN (SELECT AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA FROM AFR010 WHERE AFR010.D_E_L_E_T_=' ' AND AFR_PROJET <> ' ')
AND A.D_E_L_E_T_=' ' AND A.E2_X_CPMS = ' ' AND A.E2_EMISSAO > '20200701' AND A.E2_TIPO = 'TX';

/* VERIFICA TITULOS QUE FORAM DESAMARRADOS MAS O CAMPO AINDA ESTA PREENCHIDO */
SELECT * FROM SE2010 WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA NOT IN (SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ')
AND SE2010.D_E_L_E_T_=' ' AND SE2010.E2_X_CPMS <> ' ' AND E2_TIPO NOT IN ('TX','ISS','INS','IRF','FOL','RPA','RES','FER','PR') AND E2_PREFIXO <> 'MAN'
--AND E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA NOT IN (SELECT AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA FROM AFR010 WHERE AFR010.D_E_L_E_T_=' ') 
AND E2_TIPO <> 'FT' AND E2_PREFIXO NOT IN ('FAT','IMP','FT')  AND E2_EMISSAO >= '20200101';

/* PREENCHE O CAMPO DE CODIGO DE PROJETO ONDE O TITULO POSSUI AMARRA��O */
UPDATE SE2010 SET E2_X_CPMS = (SELECT DISTINCT AFN_PROJET FROM AFN010 WHERE E2_FILIAL = AFN_FILIAL
AND E2_PREFIXO = AFN_SERIE 
AND E2_NUM = AFN_DOC
AND E2_FORNECE = AFN_FORNEC
AND E2_LOJA = AFN_LOJA 
AND AFN010.D_E_L_E_T_=' ' 
/*AND (SELECT AF8_REVISA FROM AF8010 WHERE AF8_FILIAL = AFN_FILIAL AND AF8_PROJET = AFN_PROJET AND AF8010.D_E_L_E_T_=' ') = AFN_REVISA*/
AND ROWNUM = 1
GROUP BY AFN_FILIAL, AFN_PROJET, AFN_DOC, AFN_SERIE, AFN_FORNEC, AFN_LOJA) 
WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA IN 
(SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ' GROUP BY AFN_FILIAL, AFN_PROJET, AFN_DOC, AFN_SERIE, AFN_FORNEC, AFN_LOJA)
AND SE2010.D_E_L_E_T_=' ' AND SE2010.E2_X_CPMS = ' ' AND E2_EMISSAO BETWEEN '20200901'AND'20200930' ;

/* PREENCHE A DESCRI��O DO PROJETO NO TITULO */ 
SELECT * FROM SE2010 WHERE E2_X_CPMS <> ' ' AND E2_X_DPMS = ' ' AND E2_EMISSAO > '20180401';--AND E2_TIPO NOT IN ('TX','ISS','INS');
UPDATE SE2010 SET E2_X_DPMS = NVL((SELECT SUBSTR(AF8_DESCRI,1,80) FROM AF8010 WHERE AF8_FILIAL = E2_FILIAL AND AF8_PROJET = E2_X_CPMS AND AF8010.D_E_L_E_T_=' '),' ') WHERE E2_X_CPMS <> ' ' AND E2_X_DPMS = ' '; --AND E2_X_DPMS = ' ';

/* APAGA CAMPO DE TITULOS QUE FORAM DESAMARRADOS */
UPDATE SE2010 SET E2_X_CPMS = ' ', E2_X_DPMS = ' ', E2_CLVL=' ',E2_CLVLCR=' ',E2_CLVLDB=' ' WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA NOT IN (SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ')
AND SE2010.D_E_L_E_T_=' ' AND SE2010.E2_X_CPMS <> ' ' AND E2_TIPO NOT IN ('TX','ISS','INS','IRF')
--AND E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA NOT IN (SELECT AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA FROM AFR010 WHERE AFR010.D_E_L_E_T_=' ') 
AND E2_TIPO <> 'FT' AND E2_PREFIXO NOT IN ('FAT','IMP','FT') AND E2_TIPO = 'NF' AND E2_EMISSAO >= '20200101';

SELECT * FROM AF8010 WHERE AF8_FILIAL = '11034' AND D_E_L_E_T_=' ';
SELECT * FROM AFN010 WHERE AFN_DOC = '000043721' AND AFN_FILIAL = '11002';

--UPDATE SE2010 SET E2_X_CPMS = ' ' WHERE R_E_C_N_O_ IN (299343,299379,312511,312760,315923,327224,333074,335945);

/* VERIFICA TITULOS COM CAMPO PREENCHIDO E QUE N�O EST�O AMARRADOS */
SELECT * FROM SE2010
WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA NOT IN 
(SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ' GROUP BY AFN_FILIAL, AFN_PROJET, AFN_DOC, AFN_SERIE, AFN_FORNEC, AFN_LOJA) AND E2_TIPO = 'NF'
AND E2_X_CPMS <> ' ' AND SE2010.D_E_L_E_T_<>'*'
ORDER BY E2_FILIAL;

SELECT * FROM SE2010
WHERE E2_FILIAL||SUBSTR(E2_TITPAI,1,12)||SUBSTR(E2_TITPAI,18,8) NOT IN 
(SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ' GROUP BY AFN_FILIAL, AFN_PROJET, AFN_DOC, AFN_SERIE, AFN_FORNEC, AFN_LOJA)
AND SE2010.D_E_L_E_T_=' ' AND E2_X_CPMS <> ' ' AND E2_TIPO = 'TX';

UPDATE SE2010 SET E2_X_CPMS = ' ', E2_X_DPMS = ' ' WHERE E2_FILIAL||SUBSTR(E2_TITPAI,1,12)||SUBSTR(E2_TITPAI,18,8) NOT IN 
(SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ' GROUP BY AFN_FILIAL, AFN_PROJET, AFN_DOC, AFN_SERIE, AFN_FORNEC, AFN_LOJA)
AND SE2010.D_E_L_E_T_=' ' AND E2_X_CPMS <> ' ' AND E2_TIPO = 'TX';

UPDATE SE2010 SET E2_X_CPMS = ' ', E2_X_DPMS = ' ' WHERE E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA NOT IN (SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ')
AND SE2010.D_E_L_E_T_=' ' AND SE2010.E2_X_CPMS <> ' ' AND E2_TIPO NOT IN ('TX','ISS','INS','IRF')
AND E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA NOT IN (SELECT AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA FROM AFR010 WHERE AFR010.D_E_L_E_T_=' ') AND E2_TIPO <> 'FT' AND E2_PREFIXO NOT IN ('FAT','IMP','FT');

SELECT * FROM AFR010 WHERE AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA NOT IN (SELECT E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA FROM SE2010 WHERE SE2010.D_E_L_E_T_=' ' AND E2_X_CPMS <> ' ') 
AND AFR010.AFR_PROJET <> ' ' AND AFR010.D_E_L_E_T_<>'*' AND AFR_TIPO = 'NF'; 
UPDATE AFR010 SET D_E_L_E_T_ = '*' WHERE AFR_FILIAL||AFR_PREFIX||AFR_NUM||AFR_FORNEC||AFR_LOJA NOT IN (SELECT E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA FROM SE2010 WHERE SE2010.D_E_L_E_T_=' ' AND E2_X_CPMS <> ' ') 
AND AFR010.AFR_PROJET <> ' ' AND AFR010.D_E_L_E_T_<>'*' AND AFR_TIPO = 'NF';  

SELECT * FROM AFR010 WHERE AFR_PROJET <> ' ' ORDER BY R_E_C_N_O_ DESC;

SELECT * FROM AFR010 WHERE AFR_TIPO = 'TX' AND AFR_PROJET <> ' ' AND D_E_L_E_T_=' ';

SELECT * FROM SD1010 WHERE D1_CLVL <> ' ' AND SD1010.D_E_L_E_T_=' ' AND D1_FILIAL||D1_SERIE||D1_DOC||D1_FORNECE||D1_LOJA NOT IN (SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ');
UPDATE SD1010 SET D1_CLVL = ' ' WHERE D1_CLVL <> ' ' AND SD1010.D_E_L_E_T_=' ' AND D1_FILIAL||D1_SERIE||D1_DOC||D1_FORNECE||D1_LOJA NOT IN (SELECT AFN_FILIAL||AFN_SERIE||AFN_DOC||AFN_FORNEC||AFN_LOJA FROM AFN010 WHERE AFN010.D_E_L_E_T_=' ');
SELECT * FROM SC7010 WHERE C7_CLVL <> ' ';


SELECT * FROM SE2010 WHERE E2_TITPAI <> ' ';

UPDATE SC1010 SET C1_X_PROJ = ' ' WHERE C1_NUM = '085319';

SELECT AF9_FILIAL, AF9_PROJET, AF9_REVISA, AF9_TAREFA, AF9_NIVEL, AF9_DESCRI, AF9_X_PC01, AF9_X_PC02, AF9_X_PC03, AF9_X_PC08, AF9_X_PC09, AF9_X_PC10, AF9_X_PC11 FROM AF9010 WHERE AF9_FILIAL = '11001' AND AF9_PROJET = '000007' AND D_E_L_E_T_=' ' AND AF9_TAREFA = '01.01       ';

SELECT * FROM AF9010;
SELECT * FROM SX5010 ;

SELECT * FROM SE2010 WHERE E2_X_CPMS = ' ' AND E2_X_DPMS <> ' ';
UPDATE SE2010 SET E2_X_DPMS = ' ' WHERE E2_X_CPMS = ' ' AND E2_X_DPMS <> ' ';

SELECT * FROM SEA010 WHERE EA_NUMBOR = '540232';

UPDATE SE2010 SET E2_X_DPMS = NVL((SELECT SUBSTR(AF8_DESCRI,1,60) FROM AF8010 WHERE AF8_FILIAL = E2_FILIAL AND AF8_PROJET = E2_X_CPMS AND AF8010.D_E_L_E_T_=' '),E2_X_DPMS) WHERE E2_X_CPMS <> ' ' AND E2_X_DPMS =' ' AND SE2010.D_E_L_E_T_=' ';

SELECT * FROM AF8010;

UPDATE SE2010 SET E2_CLVL = ' ', E2_CLVLCR = ' ', E2_CLVLDB = ' ' WHERE E2_CLVLCR <> ' ' AND E2_X_CPMS = ' ' AND D_E_L_E_T_=' ' AND E2_LA <> 'S';

SELECT * FROM AFN010 WHERE AFN_FILIAL = '15001' AND AFN_DOC = '000000094' AND D_E_L_E_T_=' ' AND AFN_FORNEC = '021189';
SELECT * FROM SE2010 WHERE E2_FILIAL = '15001' AND E2_NUM = '000000094' AND D_E_L_E_T_=' ' AND E2_FORNECE= '021189';