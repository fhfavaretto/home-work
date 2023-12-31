SELECT * FROM SE2010 WHERE E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_DIRF  = ' '  AND E2_TIPO = 'TX' AND E2_NATUREZ = '5102006001' AND D_E_L_E_T_=' ';
/*UPDATE SE2010 SET  WHERE E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_DIRF  = ' '  AND E2_TIPO = 'TX' AND E2_NATUREZ = '5102006002' AND D_E_L_E_T_=' ';*/

SELECT 
SE2.E2_FILIAL FILIAL_PAI, SE2.E2_PREFIXO PREFIXO_PAI, SE2.E2_NUM NUM_PAI, SE2.E2_PARCELA PARCELA_PAI, SE2.E2_FORNECE FORN_PAI, SE2.E2_LOJA LOJA_PAI, SE2.E2_VALOR VALOR_PAI, SE2.E2_BASEPIS BASE_PAI, SE2.E2_PIS+SE2.E2_COFINS+SE2.E2_CSLL PCC_PAI, SE2.E2_CODRET, IMP.E2_CODRET,
IMP.E2_FILIAL FILIAL_IMP, IMP.E2_PREFIXO PREFIXO_IMP, IMP.E2_NUM NUM_IMP, IMP.E2_PARCELA PARCELA_IMP, IMP.E2_FORNECE FORN_IMP, IMP.E2_LOJA LOJA_IMP, IMP.E2_VALOR VALOR_IMP, IMP.E2_BASEPIS BASE_IMP, IMP.E2_PIS+IMP.E2_COFINS+IMP.E2_CSLL PCC_IMP, IMP.R_E_C_N_O_ 
FROM SE2010 IMP
LEFT JOIN SE2010 SE2 ON IMP.D_E_L_E_T_ = ' ' AND IMP.E2_FILIAL = SE2.E2_FILIAL AND IMP.E2_NATUREZ = '5102006002' AND IMP.E2_PREFIXO = SE2.E2_PREFIXO AND IMP.E2_NUM = SE2.E2_NUM AND IMP.E2_TITPAI = SE2.E2_PREFIXO||SE2.E2_NUM||SE2.E2_PARCELA||SE2.E2_TIPO||SE2.E2_FORNECE||SE2.E2_LOJA
WHERE IMP.E2_EMISSAO BETWEEN '20200101'AND'20201231'  AND IMP.E2_TIPO = 'TX' AND IMP.E2_NATUREZ = '5102006002' AND SE2.D_E_L_E_T_=' ' AND IMP.E2_DIRF = ' ' ;

SELECT * FROM SE2010 WHERE E2_NATUREZ = '5102006002' AND E2_DIRF = ' ' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND d_e_l_e_t_=' ' AND E2_TIPO = 'TX';
UPDATE SE2010 SET E2_DIRF = '1' WHERE E2_NATUREZ = '5102006002' AND E2_DIRF = ' ' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND d_e_l_e_t_=' ' AND E2_TIPO = 'TX';

SELECT * FROM SE2010 WHERE SE2010.D_E_L_E_T_=' ' AND E2_PIS+E2_COFINS+E2_CSLL = 0 AND (E2_BASEPIS*.0465) > 10 AND E2_BASEPIS > 0 AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_TIPO = 'NF' ORDER BY E2_FILIAL;
SELECT * FROM SE2010 WHERE SE2010.D_E_L_E_T_=' ' AND E2_VRETIRF > 0 /*AND (E2_BASEIRF *.015) > 10*/ AND E2_IRRF = 0 AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_TIPO = 'NF' ORDER BY E2_FILIAL;

UPDATE SE2010
SET 
/*
E2_VRETPIS = E2_PIS,
E2_VRETCOF = E2_COFINS,
E2_VRETCSL = E2_CSLL
*/
E2_BASEPIS = NVL((SELECT F1_VALMERC FROM SF1010 WHERE F1_FILIAL = E2_FILIAL AND F1_SERIE = E2_PREFIXO AND F1_DOC = E2_NUM AND F1_FORNECE = E2_FORNECE AND F1_LOJA = E2_LOJA AND SF1010.D_E_L_E_T_=' '),E2_BASEPIS)
WHERE SE2010.D_E_L_E_T_=' ' /*AND E2_VRETPIS+E2_VRETCOF+E2_VRETCSL > 0*/ AND E2_BASEPIS = 0 AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_TIPO = 'NF' AND E2__CNPJ = '00573195000169';

UPDATE SE2010
SET 
E2_BASEIRF = NVL((SELECT F1_VALMERC FROM SF1010 WHERE F1_FILIAL = E2_FILIAL AND F1_SERIE = E2_PREFIXO AND F1_DOC = E2_NUM AND F1_FORNECE = E2_FORNECE AND F1_LOJA = E2_LOJA AND SF1010.D_E_L_E_T_=' '),E2_BASEIRF)
WHERE SE2010.D_E_L_E_T_=' ' /*AND E2_IRRF > 0*/ AND E2_BASEIRF = 0 AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_TIPO = 'NF' AND E2__CNPJ = '00573195000169';

SELECT * FROM SE2010 WHERE SE2010.D_E_L_E_T_=' ' AND E2_IRRF = 0 AND E2_BASEIRF > 0 AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_TIPO = 'NF' AND E2__CNPJ = '00573195000169';
SELECT * FROM SE2010 WHERE SE2010.D_E_L_E_T_=' ' AND E2_PIS = 0 AND E2_BASEPIS > 0 AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND E2_TIPO = 'NF' AND E2__CNPJ = '00573195000169';

SELECT * FROM SF1010 WHERE F1_DOC = '002955480';
SELECT * FROM SD1010 WHERE D1_DOC = '002955480';
SELECT * FROM SA2010 WHERE A2_COD = '000398';
SELECT * FROM SED010 WHERE ED_CODIGO = '5102003010' AND D_E_L_E_T_=' ';
SELECT * FROM SB1010 WHERE B1_COD = '000000000000310' AND d_e_l_e_t_=' ';

SELECT * FROM SE2010 WHERE E2_NUM = '002737586' OR E2_TITPAI LIKE '%002737586%';

SELECT * FROM SE2010 WHERE E2_NUM = '000000081' AND E2_FILIAL = '16001' AND D_E_L_E_T_=' ' AND R_E_C_N_O_ <> 667151
UNION 
SELECT * FROM SE2010 WHERE D_E_L_E_T_=' ' AND E2_FILIAL = '16001' AND E2_NUM = '000295010';



SELECT * FROM SR4010 WHERE D_E_L_E_T_=' ' AND R4_CPFCGC = '26787563000165' AND R4_ANO = '2020' ORDER BY R4_FILIAL, R4_CPFCGC, R4_ANO, R4_MES, R4_CODRET, R4_TIPOREN;

SELECT E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_NATUREZ, E2_VALOR, E2_FORNECE, E2_LOJA, TRIM(E2__RAZAO), E2__CNPJ, E2_EMISSAO,
E2_IRRF, E2_VRETPIS, E2_VRETCOF, E2_VRETCSL, E2_BASEIRF, E2_BASEPIS, E2_VRETIRF
FROM SE2010 WHERE E2__CNPJ = '26787563000165' AND E2_EMISSAO BETWEEN '20200101'AND'20201231' AND D_E_L_E_T_=' ' ORDER BY E2_EMISSAO;

SELECT * FROM SR4010 A WHERE A.R4_TIPOREN = 'A' AND A.R4_CODRET = '5952' AND A.R4_ORIGEM = '2' AND A.R4_ANO = '2020' AND A.D_E_L_E_T_=' '
AND A.R4_VALOR <> (SELECT B.R4_VALOR FROM SR4010 B WHERE B.R4_FILIAL = A.R4_FILIAL AND A.R4_CPFCGC = B.R4_CPFCGC AND A.R4_ANO = B.R4_ANO AND A.R4_MES = B.R4_MES AND B.R4_TIPOREN = 'A' AND B.R4_CODRET = '1708' AND B.R4_ORIGEM = '2' AND B.D_E_L_E_T_=' ');


UPDATE SR4010 A SET A.R4_VALOR =  NVL((SELECT B.R4_VALOR FROM SR4010 B WHERE B.R4_FILIAL = A.R4_FILIAL AND A.R4_CPFCGC = B.R4_CPFCGC AND A.R4_ANO = B.R4_ANO AND A.R4_MES = B.R4_MES AND B.R4_TIPOREN = 'A' AND B.R4_CODRET = '1708' AND B.R4_ORIGEM = '2' AND B.D_E_L_E_T_=' '),A.R4_VALOR)
WHERE A.R4_TIPOREN = 'A' AND A.R4_CODRET = '5952' AND A.R4_ORIGEM = '2' AND A.R4_ANO = '2020' AND A.D_E_L_E_T_=' '
AND A.R4_VALOR <> (SELECT B.R4_VALOR FROM SR4010 B WHERE B.R4_FILIAL = A.R4_FILIAL AND A.R4_CPFCGC = B.R4_CPFCGC AND A.R4_ANO = B.R4_ANO AND A.R4_MES = B.R4_MES AND B.R4_TIPOREN = 'A' AND B.R4_CODRET = '1708' AND B.R4_ORIGEM = '2' AND B.D_E_L_E_T_=' ')