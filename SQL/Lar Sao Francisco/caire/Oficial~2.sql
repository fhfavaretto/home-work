UPDATE SRD010 SET RD_CC = NVL((SELECT RA_CC FROM SRA010 WHERE RA_MAT = RD_MAT AND RD_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RD_CC) WHERE RD_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT010.D_E_L_E_T_=' ') AND RD_MAT >= '899999' AND RD_DATARQ = '202007' AND RD_PROCES = '00004';

UPDATE SRC010 SET RC_CC = NVL((SELECT RA_CC FROM SRA010 WHERE RA_MAT = RC_MAT AND RC_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RC_CC) WHERE RC_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT010.D_E_L_E_T_=' ') AND RC_MAT <= '899999';
UPDATE RGB010 SET RGB_CC = NVL((SELECT RA_CC FROM SRA010 WHERE RA_MAT = RGB_MAT AND RGB_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RGB_CC) WHERE RGB_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT010.D_E_L_E_T_=' ') AND RGB_MAT <= '899999';
UPDATE RG1010 SET RG1_CC = NVL((SELECT RA_CC FROM SRA010 WHERE RA_MAT = RG1_MAT AND RG1_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RG1_CC) WHERE RG1_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT010.D_E_L_E_T_=' ') AND RG1_MAT <= '899999';
UPDATE SRK010 SET RK_CC = NVL((SELECT RA_CC FROM SRA010 WHERE RA_MAT = RK_MAT AND RK_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RK_CC) WHERE RK_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT010.D_E_L_E_T_=' ') AND RK_MAT <= '899999'; 

UPDATE SRD010 SET RD_CLVL = NVL((SELECT RA_CLVL FROM SRA010 WHERE RA_MAT = RD_MAT AND RD_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RD_CLVL) WHERE RD_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT_X_CLVL <> ' ' AND CTT010.D_E_L_E_T_=' ') AND RD_MAT <= '899999' AND RD_DATARQ = '202007' AND RD_PROCES = '00001' AND RD_FILIAL IN('11008'',''11002');

UPDATE SRA010 SET RA_CLVL = NVL((SELECT CTT_X_CLVL FROM CTT010 WHERE CTT_X_CLVL <> ' ' AND CTT010.D_E_L_E_T_=' ' AND CTT_CUSTO = RA_CC AND CTT_FILIAL = '11')','' ') WHERE SRA010.D_E_L_E_T_=' ' AND RA_SITFOLH IN (' '',''A'',''F') ;
UPDATE SRC010 SET RC_CLVL = (SELECT RA_CLVL FROM SRA010 WHERE RA_MAT = RC_MAT AND RC_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ') WHERE RC_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT_X_CLVL <> ' ' AND CTT010.D_E_L_E_T_=' ') ;
UPDATE RGB010 SET RGB_CLVL = NVL((SELECT RA_CLVL FROM SRA010 WHERE RA_MAT = RGB_MAT AND RGB_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RGB_CLVL) WHERE RGB_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT_X_CLVL <> ' ' AND CTT010.D_E_L_E_T_=' ') ;
UPDATE RG1010 SET RG1_CLVL = NVL((SELECT RA_CLVL FROM SRA010 WHERE RA_MAT = RG1_MAT AND RG1_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RG1_CLVL) WHERE RG1_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT_X_CLVL <> ' ' AND CTT010.D_E_L_E_T_=' ') ;
UPDATE SRK010 SET RK_CLVL = NVL((SELECT RA_CLVL FROM SRA010 WHERE RA_MAT = RK_MAT AND RK_FILIAL = RA_FILIAL AND SRA010.D_E_L_E_T_=' ')','RK_CLVL) WHERE RK_CC IN (SELECT CTT_CUSTO FROM CTT010 WHERE CTT_X_CLVL <> ' ' AND CTT010.D_E_L_E_T_=' '); 

SELECT * FROM SR0010 WHERE SR0010.D_E_L_E_T_=' ' AND R0_TPVALE = '2' AND R0_MAT NOT IN ('000044'',''258731'',''004478'',''004537'',''007081');
SELECT RA_FILIAL R0_FILIAL',' RA_MAT R0_MAT',' '2' R0_TPVALE',' '023' R0_CODIGO',' '(SELECT MAX(R_E_C_N_O_)+1 FROM SR0010)' R_E_C_N_O_',' ' ' D_E_L_E_T_  FROM SRA010 WHERE SRA010.D_E_L_E_T_=' ' AND RA_MAT NOT IN ('000044'',''258731'',''004478'',''004537'',''007081') AND RA_DEMISSA = ' ' AND RA_CATFUNC <> 'A' AND RA_MAT <= '899999'
AND RA_FILIAL <= '11064' AND RA_FILIAL IN ('11028'',''11032'',''11033'',''11039'',''11040'',''11041') /*('11028'',''11032'',''11033'',''11039'',''11034'',''11040'',''11041'',''11049'',''11051'',''11052'',''11059'',''11061'',''11063'',''11064')*/
ORDER BY 1','2;

SELECT * FROM SE5010 WHERE E5_FILIAL = '11051' AND (E5_CONTA LIKE '%5319%' OR E5_CONTA LIKE '%5474%') AND E5_RECONC = ' ' AND E5_ORIGEM = 'IMPAPLIC' AND D_E_L_E_T_=' ' AND E5_DATA BETWEEN '20201201'AND'20201231';
UPDATE SE5010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE E5_FILIAL = '11051' AND (E5_CONTA LIKE '%5319%' OR E5_CONTA LIKE '%5474%') AND E5_RECONC = ' ' AND E5_ORIGEM = 'IMPAPLIC' AND D_E_L_E_T_=' ' AND E5_DATA BETWEEN '20201201'AND'20201231';

SELECT C7_FILIAL, C7_PRODUTO, C7_QUANT, C7_PRECO, C7_TOTAL, C7_EMISSAO, C7_NUM, CNE_QUANT, CNE_VLUNIT, CNE_VLTOT FROM SC7010
JOIN CNE010 ON CNE_PEDIDO = C7_NUM AND CNE_FILIAL = C7_FILENT AND CNE_PRODUT = C7_PRODUTO AND CNE010.D_E_L_E_T_=' ' AND CNE_REVISA = C7_CONTREV AND C7_CONTRA = CNE_CONTRA AND C7_ITEMED = CNE_ITEM
WHERE (CNE_QUANT <> C7_QUANT OR CNE_VLTOT <> C7_TOTAL OR CNE_VLUNIT <> C7_PRECO OR ROUND(CNE_VLUNIT * CNE_QUANT,2) <> C7_TOTAL) AND SC7010.D_E_L_E_T_=' ' AND C7_EMISSAO >= '20201201' AND C7_ENCER = ' ';


UPDATE SC7010 A SET A.C7_TOTAL = NVL((SELECT CNE_VLTOT FROM SC7010 B
JOIN CNE010 ON CNE_PEDIDO = B.C7_NUM AND CNE_FILIAL = B.C7_FILENT AND CNE_PRODUT = B.C7_PRODUTO AND CNE010.D_E_L_E_T_=' ' AND CNE_REVISA = B.C7_CONTREV AND B.C7_CONTRA = CNE_CONTRA AND B.C7_ITEMED = CNE_ITEM
WHERE (CNE_QUANT <> C7_QUANT OR CNE_VLTOT <> C7_TOTAL OR CNE_VLUNIT <> C7_PRECO OR ROUND(CNE_VLUNIT * CNE_QUANT,2) <> C7_TOTAL) AND B.D_E_L_E_T_=' ' AND B.C7_EMISSAO >= '20201201' AND B.C7_ENCER = ' ' AND B.C7_NUM = A.C7_NUM AND B.C7_ITEM = A.C7_ITEM AND B.C7_FILENT = A.C7_FILENT
AND A.R_E_C_N_O_ = B.R_E_C_N_O_),C7_TOTAL),

C7_PRECO = NVL((SELECT CNE_VLUNIT FROM SC7010 B
JOIN CNE010 ON CNE_PEDIDO = B.C7_NUM AND CNE_FILIAL = B.C7_FILENT AND CNE_PRODUT = B.C7_PRODUTO AND CNE010.D_E_L_E_T_=' ' AND CNE_REVISA = B.C7_CONTREV AND B.C7_CONTRA = CNE_CONTRA AND B.C7_ITEMED = CNE_ITEM
WHERE (CNE_QUANT <> C7_QUANT OR CNE_VLTOT <> C7_TOTAL OR CNE_VLUNIT <> C7_PRECO OR ROUND(CNE_VLUNIT * CNE_QUANT,2) <> C7_TOTAL) AND B.D_E_L_E_T_=' ' AND B.C7_EMISSAO >= '20201201' AND B.C7_ENCER = ' ' AND B.C7_NUM = A.C7_NUM AND B.C7_ITEM = A.C7_ITEM AND B.C7_FILENT = A.C7_FILENT
AND A.R_E_C_N_O_ = B.R_E_C_N_O_),C7_PRECO),

C7_QUANT = NVL((SELECT CNE_QUANT FROM SC7010 B
JOIN CNE010 ON CNE_PEDIDO = B.C7_NUM AND CNE_FILIAL = B.C7_FILENT AND CNE_PRODUT = B.C7_PRODUTO AND CNE010.D_E_L_E_T_=' ' AND CNE_REVISA = B.C7_CONTREV AND B.C7_CONTRA = CNE_CONTRA AND B.C7_ITEMED = CNE_ITEM
WHERE (CNE_QUANT <> C7_QUANT OR CNE_VLTOT <> C7_TOTAL OR CNE_VLUNIT <> C7_PRECO OR ROUND(CNE_VLUNIT * CNE_QUANT,2) <> C7_TOTAL) AND B.D_E_L_E_T_=' ' AND B.C7_EMISSAO >= '20201201' AND B.C7_ENCER = ' ' AND B.C7_NUM = A.C7_NUM AND B.C7_ITEM = A.C7_ITEM AND B.C7_FILENT = A.C7_FILENT
AND A.R_E_C_N_O_ = B.R_E_C_N_O_),C7_QUANT)

WHERE A.R_E_C_N_O_ IN (SELECT B.R_E_C_N_O_ FROM SC7010 B
JOIN CNE010 ON CNE_PEDIDO = C7_NUM AND CNE_FILIAL = C7_FILENT AND CNE_PRODUT = C7_PRODUTO AND CNE010.D_E_L_E_T_=' ' AND CNE_REVISA = C7_CONTREV AND C7_CONTRA = CNE_CONTRA AND C7_ITEMED = CNE_ITEM
WHERE (CNE_QUANT <> C7_QUANT OR CNE_VLTOT <> C7_TOTAL OR CNE_VLUNIT <> C7_PRECO OR ROUND(CNE_VLUNIT * CNE_QUANT,2) <> C7_TOTAL) AND B.D_E_L_E_T_=' ' AND C7_EMISSAO >= '20201201' AND C7_ENCER = ' ');

SELECT * FROM CNE010 WHERE CNE_PEDIDO = '960774'; /*5279,17 639,9 */
SELECT * FROM SC7010 WHERE C7_NUM = '960774';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '945427';

SELECT * FROM SC7010 WHERE C7_CONTRA <> ' ' AND D_E_L_E_T_=' ' AND C7_EMISSAO >= '20201201' AND C7_ENCER = ' ' AND C7_PRODUTO IN (SELECT B1_COD FROM SB1010 WHERE B1_X_REPAS = 'S' AND SB1010.D_E_L_E_T_=' ') AND ROUND(C7_QUANT * C7_PRECO,2) <> C7_TOTAL;
UPDATE SC7010 SET C7_TOTAL = ROUND(C7_QUANT * C7_PRECO,2) WHERE C7_CONTRA <> ' ' AND D_E_L_E_T_=' ' AND C7_EMISSAO >= '20201201' AND C7_ENCER = ' ' AND C7_PRODUTO IN (SELECT B1_COD FROM SB1010 WHERE B1_X_REPAS = 'S' AND SB1010.D_E_L_E_T_=' ') AND ROUND(C7_QUANT * C7_PRECO,2) <> C7_TOTAL;

SELECT * FROM CNE010 WHERE CNE_PEDIDO <> ' ' AND D_E_L_E_T_=' ' AND CNE_DTENT >= '20201201' AND CNE_PRODUT IN (SELECT B1_COD FROM SB1010 WHERE B1_X_REPAS = 'S' AND SB1010.D_E_L_E_T_=' ') AND ROUND(CNE_QUANT * CNE_VLUNIT,2) <> CNE_VLTOT;
UPDATE CNE010 SET CNE_VLTOT = ROUND(CNE_QUANT * CNE_VLUNIT,2) WHERE CNE_PEDIDO <> ' ' AND D_E_L_E_T_=' ' AND CNE_DTENT >= '20201201' AND CNE_PRODUT IN (SELECT B1_COD FROM SB1010 WHERE B1_X_REPAS = 'S' AND SB1010.D_E_L_E_T_=' ') AND ROUND(CNE_QUANT * CNE_VLUNIT,2) <> CNE_VLTOT;

SELECT * FROM SE5010 WHERE E5_X_CPMS <> ' ' AND E5_FILIAL||E5_PREFIXO||E5_NUMERO||E5_CLIFOR||E5_LOJA||E5_TIPO||E5_PARCELA IN 
(SELECT E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA||E2_TIPO||E2_PARCELA FROM SE2010 WHERE E2_X_CPMS = ' ' AND SE2010.D_E_L_E_T_=' ' AND E2_FILIAL = '18001')
AND SE5010.D_E_L_E_T_=' ' AND E5_TIPO IN ('NF') AND E5_CONTA <> '00105991';

UPDATE SE5010 SET E5_X_CPMS =' ' WHERE E5_X_CPMS <> ' ' AND E5_FILIAL||E5_PREFIXO||E5_NUMERO||E5_CLIFOR||E5_LOJA||E5_TIPO||E5_PARCELA IN 
(SELECT E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA||E2_TIPO||E2_PARCELA FROM SE2010 WHERE E2_X_CPMS = ' ' AND SE2010.D_E_L_E_T_=' ' AND E2_FILIAL = '18001')
AND SE5010.D_E_L_E_T_=' ' AND E5_TIPO IN ('NF') AND E5_CONTA <> '00105991';

SELECT * FROM SE2010 WHERE E2_CLVL <> ' ' AND E2_X_CPMS = ' ' AND D_E_L_E_T_=' ' AND E2_EMISSAO >= '20200101';

SELECT * FROM SC7010 WHERE C7_NUM = '947969';

SELECT * FROM SRA010 WHERE RA_MAT = '260656';
SELECT * FROM RGB010 WHERE RGB_MAT = '260656' AND D_E_L_E_T_=' ';
SELECT * FROM RGB010 WHERE D_E_L_E_T_=' ' ORDER BY R_E_C_N_O_ DESC;

SELECT * FROM SE2010 WHERE E2_FILIAL = '11008' AND E2_NUM = '000074112';
SELECT * FROM AFR010 WHERE AFR_FILIAL = '11008' AND AFR_NUM = '000074112';

SELECT * FROM SE2010 WHERE E2_PREFIXO = 'F';
SELECT * FROM SPB010 WHERE PB_MAT = '000220' AND PB_PD IN ('419','479','508') AND D_E_L_E_T_=' ';
SELECT * FROM SRK010 WHERE D_E_L_E_T_=' 'AND RK_HORAS > 0;

SELECT * FROM RGB010 WHERE RGB_PERIOD = '202101' AND RGB_MAT = '000220' AND RGB_PD IN ('419','479','508') AND D_E_L_E_T_=' ' ORDER BY RGB_FILIAL, RGB_MAT, RGB_PERIOD, RGB_PD;

SELECT * FROM SPB010 WHERE /*PB_MAT = '000220' AND*/ PB_PD IN ('419','479','508') AND D_E_L_E_T_=' ' ORDER BY PB_FILIAL, PB_MAT, PB_DATA, PB_PD;
SELECT * FROM SRK010 WHERE RK_PD IN ('419','479','508') AND D_E_L_E_T_=' ' ;

SELECT * FROM SC5010 WHERE D_E_L_E_T_=' ';

SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '919422';
SELECT * FROM SC7010 WHERE C7_NUM = '919422';
SELECT * FROM SCR010 WHERE CR_NUM = '919422';
SELECT * FROM AFG010 WHERE AFG_NUMSC = 'A52082' AND D_E_L_E_T_=' ';

SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '626217';
SELECT * FROM SD1010 WHERE D1_PEDIDO = '626217';
SELECT * FROM AFN010 WHERE AFN_DOC = '007343720';
SELECT * FROM AF8010 WHERE AF8_PROJET = '000033';


SELECT * FROM CN9010 WHERE CN9_FILIAL = '11059' AND CN9_NUMERO = '000000000000107';
SELECT * FROM CNA010 WHERE CNA_FILIAL = '11059' AND CNA_CONTRA = '000000000000107';
SELECT * FROM CNB010 WHERE CNB_FILIAL = '11059' AND CNB_CONTRA = '000000000000107';
SELECT * FROM CNF010 WHERE CNF_FILIAL = '11059' AND CNF_CONTRA = '000000000000107' ORDER BY CNF_NUMERO, CNF_PARCEL;

SELECT * FROM CNF010 WHERE CNF_FILIAL = '11059' AND CNF_CONTRA = '000000000000107' AND CNF_NUMERO = '000096';
UPDATE CNF010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE CNF_FILIAL = '11059' AND CNF_CONTRA = '000000000000107' AND CNF_NUMERO = '000096';


SELECT * FROM SC1010 WHERE D_E_L_E_T_=' ' AND C1_X_PCNTE IS NOT NULL;