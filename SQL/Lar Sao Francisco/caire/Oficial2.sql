SELECT * FROM SPB010 JOIN SRA010 ON RA_MAT = PB_MAT AND RA_FILIAL = PB_FILIAL AND SRA010.D_E_L_E_T_=' ' WHERE PB_MAT = '010534' AND PB_FILIAL = '11028' AND PB_PD IN ('419','479','508') AND SPB010.D_E_L_E_T_=' ' AND RA_SITFOLH = 'F' ORDER BY PB_FILIAL, PB_MAT, PB_DATA, PB_PD ;

SELECT * FROM SC7010 WHERE C7_NUM = '625554';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '625554';
SELECT * FROM SD1010 WHERE D1_PEDIDO = '625554';
SELECT * FROM AFN010 WHERE AFN_DOC = '001884747' AND AFN_FORNEC = '000654';
SELECT * FROM AFR010 WHERE AFR_NUM = '001884747' AND AFR_FORNEC = '000654';
SELECT * FROM SE5010 WHERE E5_NUMERO = '001884747' AND E5_FORNECE = '000654';
SELECT * FROM SE2010 WHERE E2_NUM = '001884747' AND E2_FORNECE = '000654';

SELECT * FROM SB1010 WHERE B1_COD IN ('000000000037321','000000000037320','000000000039534','000000000000883','000000000000155','000000000037319') AND D_E_L_E_T_=' ';

SELECT * FROM SED010 WHERE ED_CODIGO = '5104003002';
SELECT * FROM SZ9010 WHERE Z9_FILIAL = '11001' AND Z9_PROJETO = '000033' AND Z9_NATUREZ = '5104003001';

SELECT * FROM AF9010 WHERE AF9_TAREFA = '01.01' AND AF9_FILIAL ='11001' AND AF9_PROJET = '000033';

SELECT * FROM CPF010 WHERE D_E_L_E_T_=' ' AND CPF_CODPRC = 'PC';
SELECT * FROM CPS010 WHERE D_E_L_E_T_=' ' AND CPS_CODPRC = 'PC';
SELECT * FROM CPU010 WHERE D_E_L_E_T_=' ' AND CPU_CODPRC = 'PC';

SELECT * FROM SE5010 
JOIN SE2010 ON E2_X_CPMS = ' ' AND SE2010.D_E_L_E_T_=' ' 
AND E2_FILIAL = E5_FILIAL AND E2_PREFIXO = E5_PREFIXO AND E2_NUM = E5_NUMERO AND E2_FORNECE = E5_FORNECE AND E2_LOJA = E5_LOJA AND E2_TIPO = E5_TIPO AND E2_PARCELA = E5_PARCELA
JOIN AFR010 ON AFR_FILIAL = E5_FILIAL AND AFR_PREFIX = E5_PREFIXO AND AFR_NUM = E5_NUMERO AND AFR_FORNEC = E5_FORNECE AND AFR_LOJA = E5_LOJA AND AFR_TIPO = E5_TIPO AND AFR_PARCEL = E5_PARCELA 
AND AFR010.D_E_L_E_T_='*'
JOIN AF8010 ON AF8_FILIAL = E5_FILIAL AND AF8_PROJET = E5_X_CPMS AND AF8010.D_E_L_E_T_=' '
WHERE E5_X_CPMS <> ' ' 
/*AND E5_FILIAL||E5_PREFIXO||E5_NUMERO||E5_FORNECE||E5_LOJA||E5_TIPO||E5_PARCELA 
IN (SELECT E2_FILIAL||E2_PREFIXO||E2_NUM||E2_FORNECE||E2_LOJA||E2_TIPO||E2_PARCELA FROM SE2010 WHERE E2_X_CPMS = ' ' AND SE2010.D_E_L_E_T_=' ' 
AND E2_FILIAL = E5_FILIAL AND E2_PREFIXO = E5_PREFIXO AND E2_NUM = E5_NUMERO AND E2_FORNECE = E5_FORNECE AND E2_LOJA = E5_LOJA AND SE2010.D_E_L_E_T_=' ')*/
AND E5_RECPAG = 'P' AND E5_TIPO = 'NF' AND E5_PREFIXO NOT IN ('FT','IMP','FAT') AND E5_DATA >= '20200101' AND SE5010.D_E_L_E_T_=' ';

SELECT * FROM SF1010 WHERE F1_DOC = '000007773' ;

SELECT * FROM AF8010 WHERE AF8_X_CONT IN ('00000490','00000490','00000490','00000490',
'00005698','00005474','00086268','00001714','00086267','00001714','00086267','00086267',
'00001714','00005474','00001714','00001714','00001714','00001714','00001714','00001714',
'00005671','00005671','00000493') AND D_E_L_E_T_=' ';

SELECT * FROM SE2010 WHERE E2_NUM = '000072817' AND E2_FILIAL = '11008' AND D_E_L_E_T_=' ';
SELECT * FROM SE2010 WHERE E2_NUM = '18122020' AND E2_FILIAL = '11008';
SELECT * FROM SE2010 WHERE E2_FATURA = '18122020' AND E2_FILIAL = '11008';
SELECT * FROM AFR010 WHERE AFR_NUM = '000072817' AND AFR_FILIAL = '11008' AND D_E_L_E_T_=' ';
SELECT * FROM SE5010 WHERE E5_NUMERO = '000072817' AND E5_FILIAL = '11008' AND D_E_L_E_T_=' ';
SELECT * FROM SE5010 WHERE E5_NUMERO = '18122020' AND E5_FILIAL = '11008';
SELECT * FROM AF8010 WHERE AF8_FILIAL = '11008' AND AF8_PROJET = '000003';
UPDATE SE5010 SET E5_X_CPMS = '000003' WHERE E5_NUMERO = '18122020' AND E5_FILIAL = '11008';


SELECT * FROM SD1010
JOIN AFN010 ON AFN_FILIAL = D1_FILIAL AND AFN_SERIE = D1_SERIE AND AFN_DOC = D1_DOC AND AFN_FORNEC = D1_FORNECE AND AFN_LOJA = D1_LOJA AND D1_ITEM = AFN_ITEM AND AFN010.D_E_L_E_T_=' '
JOIN SZ9010 ON Z9_FILIAL = AFN_FILIAL AND Z9_PROJETO = AFN_PROJET AND Z9_NATUREZ = D1__NATURE AND SZ9010.D_E_L_E_T_=' '
WHERE D1_X_DTPMS <> ' ' AND SD1010.D_E_L_E_T_=' ' AND AFN_TAREFA <> Z9_TAREFA AND D1_EMISSAO >= '20200101'
ORDER BY D1_FILIAL, D1_SERIE, D1_DOC, D1_ITEM, D1_FORNECE, D1_LOJA;

UPDATE AFN010 A SET A.AFN_TAREFA = (SELECT Z9_TAREFA FROM SD1010
JOIN AFN010 ON AFN_FILIAL = D1_FILIAL AND AFN_SERIE = D1_SERIE AND AFN_DOC = D1_DOC AND AFN_FORNEC = D1_FORNECE AND AFN_LOJA = D1_LOJA AND D1_ITEM = AFN_ITEM AND AFN010.D_E_L_E_T_=' '
JOIN SZ9010 ON Z9_FILIAL = AFN_FILIAL AND Z9_PROJETO = AFN_PROJET AND Z9_NATUREZ = D1__NATURE AND SZ9010.D_E_L_E_T_=' '
WHERE D1_X_DTPMS <> ' ' AND SD1010.D_E_L_E_T_=' ' AND AFN_TAREFA <> Z9_TAREFA AND D1_EMISSAO >= '20200101' AND AFN010.R_E_C_N_O_ = A.R_E_C_N_O_)
WHERE A.D_E_L_E_T_=' ' AND A.R_E_C_N_O_ IN (
SELECT AFN010.R_E_C_N_O_ FROM SD1010
JOIN AFN010 ON AFN_FILIAL = D1_FILIAL AND AFN_SERIE = D1_SERIE AND AFN_DOC = D1_DOC AND AFN_FORNEC = D1_FORNECE AND AFN_LOJA = D1_LOJA AND D1_ITEM = AFN_ITEM AND AFN010.D_E_L_E_T_=' '
JOIN SZ9010 ON Z9_FILIAL = AFN_FILIAL AND Z9_PROJETO = AFN_PROJET AND Z9_NATUREZ = D1__NATURE AND SZ9010.D_E_L_E_T_=' '
WHERE D1_X_DTPMS <> ' ' AND SD1010.D_E_L_E_T_=' ' AND AFN_TAREFA <> Z9_TAREFA AND D1_EMISSAO >= '20200101');

SELECT * FROM SE5010 WHERE E5_FILIAL = '12001' AND E5_NUMCHEQ IN ('108','953020');
UPDATE SE5010 SET D_E_L_E_T_ = ' ', R_E_C_D_E_L_ = 0 WHERE E5_FILIAL = '12001' AND E5_NUMCHEQ IN ('108','953020');
SELECT * FROM SE5010 WHERE E5_VALOR >= 88000 AND E5_FILIAL = '12001' AND E5_NATUREZ LIKE '4%';
UPDATE SE5010 SET D_E_L_E_T_='*',R_E_C_D_E_L_ = R_E_C_N_O_ WHERE R_E_C_N_O_ = 2061185;


SELECT * FROM AFN010 WHERE AFN_DOC = '000010989' AND AFN_FILIAL = '11034';
UPDATE AFN010 SET D_E_L_E_T_=' ' WHERE AFN_DOC = '000010989' AND AFN_FILIAL = '11034';
SELECT * FROM SE2010 WHERE E2_NUM = '000010989' AND E2_FILIAL = '11034';
UPDATE SE2010 SET E2_X_CPMS = '000023',E2_X_DPMS='T.A 01/2020 - PORT. 1393 (1� PARC.) - HR ILHA SOLTEIRA', E2_CLVL='010340014' WHERE E2_NUM = '000010989' AND E2_FILIAL = '11034';
SELECT * FROM SE5010 WHERE E5_NUMERO = '000010989' AND E5_FILIAL = '11034';
SELECT * FROM AFR010 WHERE AFR_NUM = '000010989' AND AFR_FILIAL = '11034';
SELECT * FROM AF8010 WHERE AF8_FILIAL = '11034' AND AF8_PROJET = '000023';

SELECT * FROM AF8010 WHERE AF8_X_CONT = '00040239';
SELECT * FROM SE5010 WHERE E5_NUMERO = '015615412';
SELECT * FROM SE2010 WHERE E2_NUM = '015615412';
SELECT * FROM AFN010 WHERE AFN_DOC = '015615412';
SELECT * FROM AFR010 WHERE AFR_NUM = '015615412';
SELECT * FROM SD1010 WHERE D1_DOC = '015615412';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '946679';


SELECT * FROM SC5010 WHERE D_E_L_E_T_= ' ' AND C5_FILIAL = '11053';
SELECT * FROM SC6010 WHERE D_E_L_E_T_= ' ' AND C6_FILIAL = '11053';

SELECT * FROM SE2010 WHERE E2_NUM = '000074333';
SELECT * FROM RC1010 WHERE RC1_NUMTIT = '000074333';

SELECT * FROM SE2010 WHERE D_E_L_E_T_=' ' AND E2_EMISSAO >= '20200101';
SELECT * FROM SE1010 WHERE D_E_L_E_T_=' ' AND E1_EMISSAO >= '20200101';

SELECT * FROM SE2010 WHERE E2_FATURA = '021220202' AND E2_FILIAL = '11032'
UNION
SELECT * FROM SE2010 WHERE E2_NUM  =   '021220202' AND E2_FILIAL = '11032';

SELECT * FROM SE5010 WHERE E5_HISTOR LIKE '%021220202%' AND E5_FILIAL = '11032';

SELECT * FROM AF8010 WHERE D_E_L_E_T_=' ';

SELECT * FROM SCP010;

SELECT RA_FILIAL, RA_MAT, RA_NOMECMP, RA_NASC FROM SRA010 WHERE D_E_L_E_T_=' ' AND RA_DEMISSA = ' ' AND RA_SITFOLH IN (' ','F');

SELECT * FROM SZ4010 WHERE D_E_L_E_T_=' ';

SELECT * FROM AFH010;

SELECT * FROM SD1010 WHERE D1_PEDIDO = '947871' AND D_E_L_E_T_= ' ';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '947871';
SELECT * FROM AFN010 WHERE AFN_DOC = '000000223' AND AFN_FILIAL = '11001' AND AFN_FORNEC = '017265';

SELECT * FROM SF1010 WHERE D_E_L_E_T_=' ' AND F1_EMISSAO >= '20210101';

SELECT * FROM SD1010 WHERE D1_FILIAL = '11001' AND D1_DOC = '002680539';
SELECT * FROM SD1010 WHERE D1_FILIAL = '11001' AND D1_PEDIDO = '888966';
SELECT * FROM SC7010 WHERE C7_NUM = '888966' AND D_E_L_E_T_=' ';

SELECT * FROM SC7010 WHERE C7_NUM = '925982' AND C7_FILIAL = '11002' AND D_E_L_E_T_=' ';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '925982' AND AJ7_FILIAL = '11002' AND D_E_L_E_T_=' ';
/*UPDATE SC7010 SET C7_QUANT = 1008, C7_PRECO = 0.27, C7_TOTAL = 272.16 WHERE R_E_C_N_O_ = 1549490;*/

SELECT * FROM SCP010;

SELECT * FROM CN9010 WHERE CN9_FILIAL = '11015' AND CN9_NUMERO = '000000000000190';
UPDATE CN9010 SET CN9_X_NAT = '5102002002', CN9_NATURE = '5102002002' WHERE CN9_FILIAL = '11015' AND CN9_NUMERO = '000000000000190';

SELECT * FROM SC7010 WHERE C7_NUM = '900087' AND C7_FILIAL = '11029' AND D_E_L_E_T_=' ';

SELECT AF8_FILIAL, AF8_X_CONT FROM AF8010 WHERE AF8_X_CONT <> ' ' AND D_E_L_E_T_=' ' GROUP BY AF8_FILIAL,AF8_X_CONT HAVING COUNT(AF8_X_CONT) > 1 ORDER BY AF8_FILIAL;
SELECT * FROM AF8010 WHERE  AF8_FILIAL = '11012' AND AF8_X_CONT = '00005760' AND D_E_L_E_T_=' ';

SELECT DISTINCT R4_FILIAL FILIAL,/*R4_TIPOREN,*/ R4_MAT MAT, TRIM(RA_NOMECMP) FUNC, SUM(R4_VALOR) VALOR FROM SR4010
JOIN SRA010 ON RA_FILIAL = R4_FILIAL AND RA_MAT = R4_MAT AND SRA010.D_E_L_E_T_=' '
WHERE SR4010.D_E_L_E_T_=' ' AND R4_ANO = '2020' AND R4_FILIAL = '11049' AND R4_MES = '12' AND R4_TIPOREN IN ('D','L') AND R4_MAT <= '899999' GROUP BY R4_FILIAL, R4_MAT/*, R4_TIPOREN*/, RA_NOMECMP ORDER BY R4_MAT; 

SELECT * FROM SRD010 WHERE RD_MAT = '015596' AND RD_DATARQ BETWEEN '202011'AND'202101' AND RD_PD IN ('403','405','427','495','500','360') AND D_E_L_E_T_=' ';
SELECT * FROM SRR010 WHERE RR_MAT = '015340' AND RR_PERIODO BETWEEN '202011'AND'202101';


/*
A  BASE BRUTA
B  INSS
D  IR
J  BASE 13
L  INSS 13
B1 IR 13
R  INF COMPL
T  DED DEP
T1 DED DEP 13
*/

SELECT * FROM SC7010 WHERE C7_NUM IN ('954470','954474') AND D_E_L_E_T_=' ';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC IN ('954470','954474') AND D_E_L_E_T_=' ';

SELECT * FROM SE4010 WHERE D_E_L_E_T_=' ';

SELECT * FROM SE1010 WHERE E1_NUM = 'BE-202017' AND D_E_L_E_T_='*';
UPDATE SE1010 SET D_E_L_E_T_=' ' WHERE E1_NUM = 'BE-202017' AND D_E_L_E_T_='*';

SELECT * FROM SE2010 WHERE E2_NUM = '000000179' AND E2_FILIAL = '13001' AND D_E_L_E_T_=' ' AND E2_PARCELA = '05';
SELECT * FROM SE5010 WHERE E5_NUMERO = '000000179' AND E5_FILIAL = '13001' AND D_E_L_E_T_=' ' AND E5_PARCELA = '05';
UPDATE SE5010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE R_E_C_N_O_ = 486155;

SELECT * FROM SE2010 WHERE D_E_L_E_T_=' ' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_DIRF = '2' AND E2_NATUREZ IN ('5102006001','5102006005','5102006006','811020015','5102006002','811020014');
UPDATE SE2010 SET E2_DIRF = '1' WHERE D_E_L_E_T_=' ' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_DIRF = '2' AND E2_NATUREZ IN ('5102006001','5102006005','5102006006','811020015','5102006002','811020014');

SELECT * FROM SE2010 WHERE D_E_L_E_T_=' ' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_DIRF = '1' AND E2_NATUREZ NOT IN ('5102006001','5102006005','5102006006','811020015','5102006002','811020014') AND E2_TIPO = 'NF';
UPDATE SE2010 SET E2_DIRF = '2' WHERE D_E_L_E_T_=' ' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_DIRF = '1' AND E2_NATUREZ NOT IN ('5102006001','5102006005','5102006006','811020015','5102006002','811020014') AND E2_TIPO = 'NF';

SELECT SUBSTR(F1_DTDIGIT,1,6) ANO_MES, COUNT(F1_VALBRUT) FROM SF1010 WHERE D_E_L_E_T_=' ' AND F1_FILIAL = '11059' GROUP BY SUBSTR(F1_DTDIGIT,1,6) ORDER BY SUBSTR(F1_DTDIGIT,1,6) DESC;
SELECT SUBSTR(E1_EMISSAO,1,6) ANO_MES, COUNT(E1_VALOR) FROM SE1010 WHERE E1_FILIAL = '11059' AND D_E_L_E_T_=' ' AND E1_EMISSAO >= '20200101' AND E1_TIPO = 'NF' 
AND E1_NATUREZ IN ('4103001001','4103002001')
GROUP BY SUBSTR(E1_EMISSAO,1,6) ORDER BY SUBSTR(E1_EMISSAO,1,6) DESC;
SELECT * FROM SE1010 WHERE E1_FILIAL = '11059' AND D_E_L_E_T_=' ' AND E1_EMISSAO >= '20200101' AND E1_TIPO = 'NF';

SELECT * FROM SCR010;
SELECT * FROM SA2010 WHERE A2_COD = '001932';

SELECT * FROM CN9010 WHERE CN9_FILIAL = '11002' AND CN9_NUMERO = '000000000000209';
UPDATE CN9010 SET CN9_SITUAC ='05' WHERE CN9_FILIAL = '11002' AND CN9_NUMERO = '000000000000209';

SELECT * FROM SC7010;

SELECT * FROM SC7010 WHERE C7_NUM = '965233' AND D_E_L_E_T_= ' ';
UPDATE SC7010 SET C7_CONAPRO = 'L', C7_X_BKPST='L' WHERE C7_NUM = '965233' AND D_E_L_E_T_= ' ';
UPDATE SC7010 SET C7_X_DTCON = '20210131' WHERE C7_NUM = '965233' AND D_E_L_E_T_= ' '; 
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '965233' AND D_E_L_E_T_= ' ';
SELECT * FROM SC1010 WHERE C1_NUM = 'A56661';
SELECT * FROM AFG010 WHERE AFG_FILIAL = '11001' AND AFG_NUMSC IN ('A56580','A56569','A56577') AND D_E_L_E_T_='*' ORDER BY R_E_C_N_O_;

select * from v$version;

SELECT * FROM SRF010;


SELECT * FROM SRA010 WHERE RA_ENDEREC LIKE '%LAZARO PEDROSO DE SOUZA%';

SELECT * FROM SC7010 WHERE C7_NUM IN ('953651','953648','953660') AND D_E_L_E_T_=' ' AND C7_FILIAL = '11002';
UPDATE SC7010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE C7_NUM IN ('953651','953648','953660') AND D_E_L_E_T_=' ' AND C7_FILIAL = '11002';

SELECT * FROM AJ7010 WHERE AJ7_NUMPC IN ('953651','953648','953660') AND D_E_L_E_T_=' ' AND AJ7_FILIAL = '11002';
UPDATE AJ7010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_, AJ7_X_OBSA = 'APAGADO A PEDIDO DA FERNANDA PORQUE O LAN�AMENTO ESTAVA ERRADO E FIZERAM REVIS�O NO CONTRATO - 15/02/2021 CAIRE' WHERE AJ7_NUMPC IN ('953651','953648','953660') AND D_E_L_E_T_=' ' AND AJ7_FILIAL = '11002';

SELECT * FROM CND010 WHERE CND_PEDIDO IN ('953651','953648','953660') AND D_E_L_E_T_=' ' AND CND_FILIAL = '11002';

SELECT RA_FILIAL, RA_MAT, RA_NOMECMP, RA_PIS, RA_CRACHA FROM SRA010 WHERE RA_CRACHA <> ' ';
UPDATE SRA010 SET RA_CRACHA = RA_PIS WHERE RA_PIS <> ' ' AND D_E_L_E_T_=' ';

SELECT 16 * (SUBSTR('21',1,LENGTH('21')-1)) + INSTR('0123456789ABCDEF',SUBSTR('21',1)) FROM DUAL;

SELECT * FROM SE2010 WHERE E2_NATUREZ IN ('811020015','5102006001') AND SUBSTR(E2_FILIAL,1,2) = '12' AND D_E_L_E_T_=' ' AND E2_EMISSAO BETWEEN '20200101'AND'20201231';

SELECT * FROM AF8010 WHERE AF8_FILIAL = '11062';

SELECT * FROM SD1010 WHERE D1_FILIAL = '12001' AND D1_DOC = '000065060';
SELECT * FROM SC7010 WHERE C7_NUM = '972024';
SELECT * FROM SC1010 WHERE C1_NUM = 'A58956';
SELECT * FROM SB1010 WHERE B1_COD IN ('000000000004850') AND D_E_L_E_T_=' ';

SELECT * FROM SRA010 WHERE RA_MAT = '006668';

SELECT * FROM SC1010
JOIN SB1010 ON C1_PRODUTO = B1_COD AND SB1010.D_E_L_E_T_=' '
JOIN SBM010 ON BM_GRUPO = B1_GRUPO AND SBM010.D_E_L_E_T_=' '

WHERE C1_NUM = 'A59509' AND SC1010.D_E_L_E_T_=' ';

SELECT * FROM SBM010 WHERE D_E_L_E_T_=' ';

SELECT * FROM SE5010 WHERE E5_FILIAL = '12001' AND (E5_RECONC = 'x' OR E5_TIPO = 'BA')
AND E5_DATA BETWEEN '20200101'AND'20201231' AND ;

SELECT * FROM SA6010 WHERE A6_FILIAL = '12001' AND A6_X_CLVL <> ' ' AND D_E_L_E_T_=' ';


SELECT * FROM SC7010 WHERE C7_FILIAL = '11049' AND D_E_L_E_T_=' ' ORDER BY R_E_C_N_O_ DESC;

SELECT * FROM RC1010 WHERE RC1_NUMTIT = '000075305';
SELECT * FROM SE2010 WHERE E2_NUM = '000075305';
SELECT A2_MSBLQL FROM SA2010 WHERE A2_COD = '039111';

/*DIRF*/
SELECT * FROM SR4010 WHERE D_E_L_E_T_=' ' AND R4_CPFCGC = '00573195000169' AND R4_ANO = '2020' ORDER BY R4_FILIAL, R4_CPFCGC, R4_ANO, R4_MES, R4_CODRET, R4_TIPOREN; /* 26787563000165, 32150633000415 */
SELECT E2_FILIAL, E2__RAZAO, E2__CNPJ, SUBSTR(E2_EMISSAO,1,6) MES_ANO, SUM(E2_VALOR) VALOR, SUM(E2_VRETIRF) IRF, SUM(E2_VRETPIS+E2_VRETCOF+E2_VRETCSL) PCC, SUM(E2_BASEPIS) BASE_PIS, SUM(E2_BASEIRF) BASE_IRF FROM SE2010 WHERE D_E_L_E_T_=' '   AND SUBSTR(E2_EMISSAO,1,4) = '2020' AND E2_TIPO = 'NF' /* AND E2__CNPJ = '00573195000169' */
AND E2_BASEIRF > 0 AND E2_VRETIRF = 0
/*AND E2_BASEPIS > 0 AND E2_PIS = 0*/
GROUP BY E2_FILIAL, E2__RAZAO, E2__CNPJ,SUBSTR(E2_EMISSAO,1,6) ORDER BY E2_FILIAL, E2__CNPJ, SUBSTR(E2_EMISSAO,1,6); /* 26787563000165 */

UPDATE SE2010 SET E2_BASEIRF = 0 WHERE D_E_L_E_T_=' ' AND E2__CNPJ = '00573195000169'  AND SUBSTR(E2_EMISSAO,1,4) = '2020' AND E2_TIPO = 'NF' AND E2_IRRF = 0 AND E2_BASEIRF > 0;
UPDATE SE2010 SET E2_BASEPIS = 0 WHERE D_E_L_E_T_=' ' AND E2__CNPJ = '00573195000169'  AND SUBSTR(E2_EMISSAO,1,4) = '2020' AND E2_TIPO = 'NF' AND E2_BASEPIS > 0 AND E2_VRETPIS = 0;


SELECT E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_NATUREZ, E2_VALOR, E2_FORNECE, E2_LOJA, TRIM(E2__RAZAO), E2__CNPJ, E2_EMISSAO,
E2_IRRF, E2_VRETPIS, E2_VRETCOF, E2_VRETCSL, E2_BASEIRF, E2_BASEPIS, E2_VRETIRF
FROM SE2010 WHERE E2__CNPJ = '26787563000165' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND D_E_L_E_T_=' ' ORDER BY E2_EMISSAO;

SELECT * FROM SR4010 A WHERE A.R4_TIPOREN = 'A' AND A.R4_CODRET = '5952' AND A.R4_ORIGEM = '2' AND A.R4_ANO = '2020' AND A.D_E_L_E_T_=' '
AND A.R4_VALOR <> (SELECT B.R4_VALOR FROM SR4010 B WHERE B.R4_FILIAL = A.R4_FILIAL AND A.R4_CPFCGC = B.R4_CPFCGC AND A.R4_ANO = B.R4_ANO AND A.R4_MES = B.R4_MES AND B.R4_TIPOREN = 'A' AND B.R4_CODRET = '1708' AND B.R4_ORIGEM = '2' AND B.D_E_L_E_T_=' ');


UPDATE SR4010 A SET A.R4_VALOR =  NVL((SELECT B.R4_VALOR FROM SR4010 B WHERE B.R4_FILIAL = A.R4_FILIAL AND A.R4_CPFCGC = B.R4_CPFCGC AND A.R4_ANO = B.R4_ANO AND A.R4_MES = B.R4_MES AND B.R4_TIPOREN = 'A' AND B.R4_CODRET = '1708' AND B.R4_ORIGEM = '2' AND B.D_E_L_E_T_=' '),A.R4_VALOR)
WHERE A.R4_TIPOREN = 'A' AND A.R4_CODRET = '5952' AND A.R4_ORIGEM = '2' AND A.R4_ANO = '2020' AND A.D_E_L_E_T_=' '
AND A.R4_VALOR <> (SELECT B.R4_VALOR FROM SR4010 B WHERE B.R4_FILIAL = A.R4_FILIAL AND A.R4_CPFCGC = B.R4_CPFCGC AND A.R4_ANO = B.R4_ANO AND A.R4_MES = B.R4_MES AND B.R4_TIPOREN = 'A' AND B.R4_CODRET = '1708' AND B.R4_ORIGEM = '2' AND B.D_E_L_E_T_=' ')
/*AND A.R4_CPFCGC = '26787563000165'*/;

SELECT 
R4_FILIAL, R4_MAT, R4_CPFCGC, R4_MES, R4_ANO, R4_TIPOREN, R4_VALOR, R4_CODRET, R4_UFIR, R4_ORIGEM,
(SELECT SUM(B.E2_BASEPIS) FROM SE2010 B WHERE B.E2_FILIAL NOT IN ('12001','13001','14001','15001','16001','17001','18001','11023') /*= A.R4_FILIAL*/ AND A.R4_CPFCGC = B.E2__CNPJ AND A.R4_ANO = SUBSTR(B.E2_EMISSAO,1,4) AND A.R4_MES = SUBSTR(B.E2_EMISSAO,5,2)  AND B.E2_TIPO = 'NF' AND B.D_E_L_E_T_=' ') BASE
FROM SR4010 A WHERE A.R4_TIPOREN = 'A' AND A.R4_CODRET = '5952' AND A.R4_ORIGEM = '2' AND A.R4_ANO = '2020' AND A.D_E_L_E_T_=' '
AND A.R4_VALOR <> (SELECT SUM(B.E2_BASEPIS) FROM SE2010 B WHERE B.E2_FILIAL = A.R4_FILIAL AND A.R4_CPFCGC = B.E2__CNPJ AND A.R4_ANO = SUBSTR(B.E2_EMISSAO,1,4) AND A.R4_MES = SUBSTR(B.E2_EMISSAO,5,2)  AND B.E2_TIPO = 'NF' AND B.D_E_L_E_T_=' ')
AND A.R4_CPFCGC = '00573195000169'
ORDER BY R4_FILIAL, R4_CPFCGC, R4_MES, R4_ANO, R4_MES;

SELECT * FROM SR4010 WHERE R4_ANO = '2020' AND SR4010.D_E_L_E_T_=' ' AND R4_CODRET = '5952' AND R4_TIPOREN IN ('A') AND R4_FILIAL = '11001' AND R4_CPFCGC = '00573195000169' ORDER BY R4_FILIAL, R4_ANO, R4_MES;

SELECT E2__RAZAO, E2__CNPJ, SUM(E2_VALOR) VALOR, SUM(E2_IRRF) IIRF, SUM(E2_COFINS+E2_PIS+E2_CSLL) PCC, SUM(E2_BASEPIS) BASE_PCC, SUM(E2_BASEIRF) BASE_IRF
FROM SE2010 WHERE E2_FORNECE = '000029' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND D_E_L_E_T_=' ' AND E2_FILIAL BETWEEN '11001'AND'11064' GROUP BY E2__RAZAO, E2__CNPJ;

SELECT * FROM SR4010 WHERE R4_CPFCGC = '00573195000169' AND R4_ANO||R4_MES BETWEEN '202001'AND'202012' AND D_E_L_E_T_=' ' AND R4_CODRET = '5952' ORDER BY R4_FILIAL, R4_CPFCGC, R4_MES, R4_ANO, R4_MES;; 

SELECT R4_CPFCGC, R4_TIPOREN, SUM(R4_VALOR) VALOR FROM SR4010 WHERE R4_CPFCGC = '00573195000169' AND R4_ANO||R4_MES BETWEEN '202001'AND'202012' AND D_E_L_E_T_=' ' AND R4_CODRET = '5952' GROUP BY R4_CPFCGC, R4_TIPOREN; 
SELECT * FROM SF1010 WHERE F1_FORNECE = '000029' AND F1_EMISSAO BETWEEN '20200101'AND'20201231' AND D_E_L_E_T_=' ' ;




/*CREATE TABLE SR4010_BKP_2020 AS SELECT * FROM SR4010 WHERE D_E_L_E_T_=' ' AND R4_ANO = '2020';*/

SELECT RA_FILIAL, RA_SITFOLH, COUNT(RA_CIC) QUANTIDADE FROM SRA010 WHERE RA_SITFOLH IN (' ','A','F') AND D_E_L_E_T_=' ' AND RA_DEMISSA = ' ' GROUP BY RA_FILIAL, RA_SITFOLH ORDER BY RA_FILIAL, RA_SITFOLH;

SELECT * FROM RGB010 WHERE RGB_MAT = '006668' AND RGB_FILIAL = '11002' AND RGB_PD IN ('419','479','508') AND RGB_TIPO2 = 'E' AND RGB010.D_E_L_E_T_=' ' ;


SELECT * FROM SR4010 WHERE R4_ORIGEM = '1' AND R4_ANO = '2020' AND D_E_L_E_T_= ' ';
SELECT * FROM SRL010 WHERE D_E_L_E_T_= ' ';

SELECT * FROM CTD010 WHERE CTD_ITEM = 'C35341901' AND D_E_L_E_T_=' ';
SELECT * FROM SA1010 WHERE A1_COD = '353419' AND D_E_L_E_T_=' ';

SELECT * FROM SC7010 WHERE C7_NUM = '974345';
UPDATE SC7010 SET C7_FILENT = '11001'  WHERE C7_NUM = '974345';

SELECT * FROM SF2010 WHERE D_E_L_E_T_=' ' AND F2_SERIE = 'C';
SELECT * FROM SD2010 WHERE D_E_L_E_T_=' ' AND D2_SERIE = 'C';

SELECT * FROM SC7010 WHERE C7_NUM = '966288';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '966288';
SELECT * FROM SCR010 WHERE CR_NUM = '966288';

SELECT * FROM SC7010 WHERE C7_FILIAL = '11049' AND D_E_L_E_T_=' ' ORDER BY R_E_C_N_O_ DESC;

SELECT * FROM SC7010 WHERE C7_NUM IN ('975039','974364','974411') AND D_E_L_E_T_=' ';
UPDATE SC7010 SET C7_FILENT = '11001' WHERE C7_NUM IN ('975039','974364','974411') AND D_E_L_E_T_=' ';

SELECT * FROM SED010;
SELECT * FROM SX5010 WHERE D_E_L_E_T_=' ' ORDER BY R_E_C_N_O_ DESC;

SELECT * FROM SC7010 WHERE C7_X_PDCBI = '156610322' AND D_E_L_E_T_=' ';

SELECT * FROM CN9010;

SELECT * FROM SZC010 WHERE ZC_FILIAL = '15001' AND ZC_PROJETO = '000053' AND D_E_L_E_T_=' ' AND ZC_TAREFA = '01.01';
UPDATE SZC010 SET D_E_L_E_T_='*' WHERE ZC_FILIAL = '15001' AND ZC_PROJETO = '000053' AND D_E_L_E_T_=' ' AND ZC_TAREFA = '01.01';
SELECT * FROM AF9010 WHERE AF9_FILIAL = '15001' AND AF9_PROJET = '000053' AND D_E_L_E_T_='*';

SELECT * FROM SC5010 WHERE D_E_L_E_T_=' ';

SELECT * FROM AF8010 WHERE AF8_FILIAL = '11020' AND AF8_PROJET = '000007';

SELECT A.* FROM SR4010 A WHERE A.R4_ANO = '2020' AND A.D_E_L_E_T_=' ' AND A.R4_ORIGEM = '1' AND A.R4_CODRET = '0561' AND A.R4_CPFCGC IN (SELECT B.R4_CPFCGC FROM SR4010 B WHERE B.R4_CODRET <> '0561' AND B.R4_CPFCGC = A.R4_CPFCGC AND B.D_E_L_E_T_=' ' AND B.R4_ANO = '2020')
ORDER BY R4_FILIAL, R4_MAT, R4_ANO, R4_MES;  --903172 903178

SELECT * FROM SEV010 WHERE SUBSTR(EV_NATUREZ,1,1) NOT IN ('7','8',' ') AND EV_FILIAL = '12001' AND D_E_L_E_T_=' ' AND EV_TIPO <> 'PR'; 
SELECT * FROM SE2010 WHERE SUBSTR(E2_NATUREZ,1,1) NOT IN ('7','8',' ') AND E2_FILIAL = '12001' AND D_E_L_E_T_=' ' AND E2_EMISSAO >= '20200101' AND E2_TIPO <> 'PR'; 

SELECT * FROM SZ1010;

/*3821, 3438, 27385, 10301, 101560 NOTAS JATAI*/

SELECT * FROM SC7010 WHERE C7_NUM = '972847';
SELECT * FROM SD1010 WHERE D1_PEDIDO = '972847';

SELECT * FROM SD1010 WHERE D1_FILIAL = '11053' AND D1_EMISSAO >= '20210101' AND LTRIM(D1_DOC,'0') IN ('3821','3438','27385','10301','101560') AND D_E_L_E_T_=' ';

SELECT * FROM SC7010 WHERE C7_NUM = '975891';
UPDATE SC7010 SET C7_CONAPRO = 'L', C7_X_BKPST = 'L' WHERE C7_NUM = '972768';

SELECT * FROM CT2010 WHERE D_E_L_E_T_=' ' AND CT2_DATA >= '20150101' AND CT2_TPSALD = '9';
UPDATE CT2010 SET CT2_TPSALD = '1' WHERE D_E_L_E_T_=' ' AND CT2_DATA >= '20150101' AND CT2_TPSALD = '9';

SELECT * FROM CQA010 WHERE D_E_L_E_T_=' ';
UPDATE CQA010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_, CQA_TPSALD = '1' WHERE D_E_L_E_T_=' ';
SELECT * FROM SC8010 WHERE C8_NUMSC ='A60342'; 

SELECT * FROM WF3010;

SELECT * FROM SC7010 WHERE C7_NUM = '976630';
SELECT * FROM SC1010 WHERE C1_NUM = 'A60632' ;

SELECT * FROM CTT010 WHERE CTT_CUSTO = '010250010001';

SELECT * FROM CN9010 WHERE D_E_L_E_T_=' ' AND CN9_SITUAC = '05' AND CN9_FILIAL = '11001' AND CN9_X_CLFR LIKE '%IMZ%'; 
UPDATE CN9010 SET CN9_X_NAT = '4103011005', CN9_NATURE = '4103011005' WHERE D_E_L_E_T_=' ' AND CN9_SITUAC = '05' AND CN9_FILIAL = '11051' AND CN9_X_CLFR LIKE '%REPAE%'; 

SELECT * FROM SE2010 WHERE E2_NUM = '000073530' AND D_E_L_E_T_=' ';
UPDATE SE2010 SET D_E_L_E_T_='*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE R_E_C_N_O_ = 1055664;
SELECT * FROM SE5010 WHERE E5_NUMERO = '000073530';
SELECT * FROM RC1010 WHERE RC1_NUMTIT = '000073530';

SELECT * FROM SRA010 WHERE D_E_L_E_T_=' ';

SELECT * FROM SN4010 WHERE N4_FILIAL = '11004' AND D_E_L_E_T_=' ' AND N4_DATA >= '20200801';
UPDATE SN4010 SET D_E_L_E_T_='*' WHERE N4_FILIAL = '11004' AND D_E_L_E_T_=' ' AND N4_DATA >= '20200801';

SELECT * FROM SE5010 WHERE E5_FILIAL = '11030' AND E5_CONTA LIKE '%00461%' AND E5_ORIGEM = 'IMPAPLIC' AND E5_RECONC = ' ' AND E5_DATA BETWEEN '20210101'AND'20210229';
UPDATE SE5010 SET D_E_L_E_T_='*',R_E_C_D_E_L_=R_E_C_N_O_ WHERE E5_FILIAL = '11030' AND E5_CONTA LIKE '%00461%' AND E5_ORIGEM = 'IMPAPLIC' AND E5_RECONC = ' ' AND E5_DATA BETWEEN '20210101'AND'20210229';

SELECT DISTINCT C7_FILENT, C7_NUM FROM SC7010 WHERE C7_FILENT = '11002' AND C7_EMISSAO BETWEEN '20201201'AND'20201231' AND D_E_L_E_T_=' ' AND C7_X_PDCBI = ' ' AND C7_X_REPAS <> 'S';

SELECT DISTINCT A2_MUN, COUNT(F1_DOC) FROM SF1010 JOIN SA2010 ON A2_COD = F1_FORNECE AND A2_LOJA = F1_LOJA AND SA2010.D_E_L_E_T_=' '
WHERE F1_ESPECIE IN ('NFS','NFPS','NFP','RPS') AND SF1010.D_E_L_E_T_=' ' AND F1_EMISSAO BETWEEN '20201201'AND'20201231' GROUP BY A2_MUN;

SELECT RA_FILIAL,RA_MAT,RA_NOMECMP,TO_DATE(RA_NASC,'YYYYMMDD'), ROUND((TRUNC((SYSDATE-TO_DATE(RA_NASC,'YYYYMMDD'))/30.4375)/12)) IDADE/*, COUNT(*) CONTADOR*/  FROM SRA010 WHERE RA_NASC <> ' ' AND D_E_L_E_T_=' ' AND RA_DEMISSA = ' ' AND RA_CATFUNC <> 'A' AND RA_SITFOLH IN (' ','F')
/*GROUP BY RA_FILIAL, ROUND((TRUNC((SYSDATE-TO_DATE(RA_NASC,'YYYYMMDD'))/30.4375)/12))*/ ORDER BY RA_FILIAL, ROUND((TRUNC((SYSDATE-TO_DATE(RA_NASC,'YYYYMMDD'))/30.4375)/12));


SELECT RA_CIC, COUNT(*) FROM SRA010 WHERE D_E_L_E_T_=' ' AND RA_DEMISSA =' ' AND RA_CATFUNC <> 'A' GROUP BY RA_CIC HAVING COUNT(*) > 1;


SELECT UTL_RAW.CAST_TO_VARCHAR2(C1_X_PCNTE) FROM SC1010 WHERE C1_X_PCNTE IS NOT NULL AND D_E_L_E_T_=' ';
SELECT CAST(CAST(C1_X_PCNTE AS RAW(2000)) AS VARCHAR(4000)) FROM SC1010 WHERE D_E_L_E_T_=' ' AND C1_X_PCNTE IS NOT NULL;
SELECT * FROM SYP010 WHERE D_E_L_E_T_=' ' ORDER BY R_E_C_N_O_ DESC;
SELECT * FROM TRX010 WHERE D_E_L_E_T_=' ' ORDER BY R_E_C_N_O_ DESC;

SELECT * FROM SC7010 WHERE C7_NUM = '987170';
SELECT * FROM AJ7010 WHERE AJ7_NUMPC = '987170';
SELECT * FROM SD1010 WHERE D1_PEDIDO = '987170';

SELECT * FROM SC7010 WHERE C7_NUM = '987530';
SELECT * FROM SCR010 WHERE CR_NUM = '987530';


