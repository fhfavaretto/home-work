SELECT 

RC.RC_FILIAL FILIAL,
RC.RC_MAT MATRICULA,
RA.RA_NOMECMP NOME,
/*RA.RA_APELIDO APELIDO,*/
'1� PARCELA' PARCELA_13,
RA.RA_SEXO SEXO,
RA.RA_CIC CPF,
RA.RA_RG RG,
RA.RA_PIS PIS,
CASE WHEN RA.RA_TPCONTR = '1' THEN 'INDETERMINADO' WHEN RA.RA_TPCONTR = '2' THEN 'DETERMINADO' ELSE '' END TIPO_CONTRIBUCAO,
CASE WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '001' THEN '001-BANCO DO BRASIL' 
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '033' THEN '033-SANTANDER'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '104' THEN '104-CAIXA ECONOMICA FEDERAL'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '237' THEN '237-BRADESCO'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '399' THEN '399-HSBC'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '341' THEN '341-ITAU'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '777' THEN 'ORDEM DE PAGAMENTO' 
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '888' THEN 'FUNCIONARIO SEM CONTA'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '999' THEN 'CHEQUE'
ELSE SUBSTR(RA.RA_BCDEPSA,1,3) END BANCO,
CASE WHEN SUBSTR(RA.RA_BCDEPSA,4,1)= '/' THEN SUBSTR(RA_BCDEPSA,5,8) ELSE SUBSTR(RA_BCDEPSA,4,8) END AGENCIA,

(SELECT QB_DESCRIC FROM SQB010 WHERE QB_DEPTO = RA.RA_DEPTO AND SQB010.D_E_L_E_T_=' ' AND ROWNUM = 1) DEPARTAMENTO,

/*RC.RC_SEMANA SEMANA,*/
RA.RA_X_BLOMV BLQ_CALC_MV,
RA.RA_CTDEPSA CONTA,
RA.RA_CC COD_CC,
RA.RA_SALARIO SALARIO_BASE,
RA.RA_ANTEAUM SALARIO_DISSIDIO,
(SELECT SUBSTR(R3_DATA,7,2)||'/'||SUBSTR(R3_DATA,5,2)||'/'||SUBSTR(R3_DATA,1,4) FROM SR3010 WHERE R3_MAT = RA_MAT AND R3_FILIAL = R3_FILIAL AND SR3010.D_E_L_E_T_=' ' AND R3_PD = '000' AND R3_VALOR = RA_SALARIO AND R3_ANTEAUM = RA_ANTEAUM AND ROWNUM = 1 ) DATA_ULT_AUMENTO,
(SUBSTR(RA_NASC,7,2)||'/'||SUBSTR(RA_NASC,5,2)||'/'||SUBSTR(RA_NASC,1,4)) NASCIMENTO,
(SUBSTR(RA_ADMISSA,7,2)||'/'||SUBSTR(RA_ADMISSA,5,2)||'/'||SUBSTR(RA_ADMISSA,1,4)) ADMISSAO,
(SUBSTR(RA_DEMISSA,7,2)||'/'||SUBSTR(RA_DEMISSA,5,2)||'/'||SUBSTR(RA_DEMISSA,1,4)) DEMISSAO,

/*(SELECT RG_TIPORES FROM SRG010 WHERE RG_MAT = RC_MAT AND RG_FILIAL = RC_FILIAL AND SRG010.D_E_L_E_T_=' ' AND RG_DATADEM = RA.RA_DEMISSA AND ROWNUM = 1) COD_DEMISSAO,*/
(SELECT (SELECT SUBSTR(RX_TXT,0,30) FROM SRX010 WHERE RX_COD = RG_TIPORES AND RX_TIP ='32' AND SRX010.D_E_L_E_T_=' ' AND ROWNUM = 1) FROM SRG010 WHERE RG_MAT = RC_MAT AND RG_FILIAL = RC_FILIAL AND SRG010.D_E_L_E_T_=' ' AND RG_DATADEM = RA.RA_DEMISSA AND ROWNUM = 1) DESC_DEMISSAO,

RA.RA_SINDICA COD_SINDICATO,
(SELECT RCE_DESCRI FROM RCE010 WHERE RCE_CODIGO = RA.RA_SINDICA AND RCE010.D_E_L_E_T_=' ') SINDICATO,
/*(SELECT RCE_ENTSIN FROM RCE010 WHERE RCE_CODIGO = RA.RA_SINDICA AND RCE010.D_E_L_E_T_=' ') ENTIDADE_SINDICATO,*/
1 CONTADOR,
RA.RA_CC||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = RA.RA_CC AND CTT010.D_E_L_E_T_=' ') CENTRO_CUSTO,
SUBSTR(RA.RA_CC,1,5)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
SUBSTR(RA.RA_CC,1,8)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC,
RA.RA_CATFUNC CAT_FUNCAO, 
(SELECT RJ_DESC FROM SRJ010 WHERE RJ_FUNCAO = RA_CODFUNC AND D_E_L_E_T_=' ') FUNCAO,
RA_CODFUNC COD_FUNCAO,
(SELECT SQ3010.Q3_DESCSUM FROM SQ3010 WHERE Q3_CARGO = RA_CARGO AND D_E_L_E_T_=' ') CARGO,

(SELECT RJ_CODCBO FROM SRJ010 WHERE RJ_FUNCAO = RA_CODFUNC AND D_E_L_E_T_=' ')  CBO,
RC_HORAS REFERENCIA,
RA_HRSEMAN HORAS_SEMANAL,

RA_HRSMES HORAS_MES,

/*CASE WHEN RC.RC_PD IN ('002','003','004','005','006','008','010','011','012','014','015','016',
'017','018','019','020','021','022','023','024','025','026','027','028','231','HE1','HE2') THEN 'SIM' ELSE 'NAO' END VERBA_FIXA,*/

CASE WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RC_PD AND RV.D_E_L_E_T_=' ' )= '2' THEN (RC.RC_VALOR)*-1 ELSE (RC.RC_VALOR) END VALOR,
RC_PD COD_VERBA,
(SELECT RV_DESC FROM SRV010 RV WHERE RV.RV_COD = RC_PD AND RV.D_E_L_E_T_=' ' )VERBA,

CASE WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RC_PD AND RV.D_E_L_E_T_=' ' ) = '1' THEN 'PROVENTO'
WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RC_PD AND RV.D_E_L_E_T_=' ' )= '2' THEN 'DESCONTO' ELSE 'BASE' END TIPO_VERBA,

SUBSTR(RC.RC_DATA,7,2)||'/'||SUBSTR(RC.RC_DATA,5,2)||'/'||SUBSTR(RC.RC_DATA,1,4) DATA_PGTO,
RA.RA_SITFOLH SITUACAO_FOLHA

FROM SRC010 RC INNER JOIN SRA010 RA ON RA.RA_MAT = RC.RC_MAT AND RA.RA_FILIAL = RC.RC_FILIAL 

WHERE RA.D_E_L_E_T_=' ' AND RC.D_E_L_E_T_=' ' AND RA.RA_CATFUNC <> 'A' AND RA.RA_MAT < '900000' AND RC_TIPO2 = 'P'

UNION

SELECT 

RI.RI_FILIAL FILIAL,
RI.RI_MAT MATRICULA,
RA.RA_NOMECMP NOME,
/*RA.RA_APELIDO APELIDO,*/
'2� PARCELA' PARCELA_13,
RA.RA_SEXO SEXO,
RA.RA_CIC CPF,
RA.RA_RG RG,
RA.RA_PIS PIS,
CASE WHEN RA.RA_TPCONTR = '1' THEN 'INDETERMINADO' WHEN RA.RA_TPCONTR = '2' THEN 'DETERMINADO' ELSE '' END TIPO_CONTRIBUCAO,
CASE WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '001' THEN '001-BANCO DO BRASIL' 
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '033' THEN '033-SANTANDER'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '104' THEN '104-CAIXA ECONOMICA FEDERAL'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '237' THEN '237-BRADESCO'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '399' THEN '399-HSBC'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '341' THEN '341-ITAU'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '777' THEN 'ORDEM DE PAGAMENTO' 
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '888' THEN 'FUNCIONARIO SEM CONTA'
WHEN SUBSTR(RA.RA_BCDEPSA,1,3) = '999' THEN 'CHEQUE'
ELSE SUBSTR(RA.RA_BCDEPSA,1,3) END BANCO,
CASE WHEN SUBSTR(RA.RA_BCDEPSA,4,1)= '/' THEN SUBSTR(RA_BCDEPSA,5,8) ELSE SUBSTR(RA_BCDEPSA,4,8) END AGENCIA,

(SELECT QB_DESCRIC FROM SQB010 WHERE QB_DEPTO = RA.RA_DEPTO AND SQB010.D_E_L_E_T_=' ' AND ROWNUM = 1) DEPARTAMENTO,

/*RI.RI_SEMANA SEMANA,*/
RA.RA_X_BLOMV BLQ_CALC_MV,
RA.RA_CTDEPSA CONTA,
RA.RA_CC COD_CC,
RA.RA_SALARIO SALARIO_BASE,
RA.RA_ANTEAUM SALARIO_DISSIDIO,
(SELECT SUBSTR(R3_DATA,7,2)||'/'||SUBSTR(R3_DATA,5,2)||'/'||SUBSTR(R3_DATA,1,4) FROM SR3010 WHERE R3_MAT = RA_MAT AND R3_FILIAL = R3_FILIAL AND SR3010.D_E_L_E_T_=' ' AND R3_PD = '000' AND R3_VALOR = RA_SALARIO AND R3_ANTEAUM = RA_ANTEAUM AND ROWNUM = 1 ) DATA_ULT_AUMENTO,
(SUBSTR(RA_NASC,7,2)||'/'||SUBSTR(RA_NASC,5,2)||'/'||SUBSTR(RA_NASC,1,4)) NASCIMENTO,
(SUBSTR(RA_ADMISSA,7,2)||'/'||SUBSTR(RA_ADMISSA,5,2)||'/'||SUBSTR(RA_ADMISSA,1,4)) ADMISSAO,
(SUBSTR(RA_DEMISSA,7,2)||'/'||SUBSTR(RA_DEMISSA,5,2)||'/'||SUBSTR(RA_DEMISSA,1,4)) DEMISSAO,

/*(SELECT RG_TIPORES FROM SRG010 WHERE RG_MAT = RC_MAT AND RG_FILIAL = RC_FILIAL AND SRG010.D_E_L_E_T_=' ' AND RG_DATADEM = RA.RA_DEMISSA AND ROWNUM = 1) COD_DEMISSAO,*/
(SELECT (SELECT SUBSTR(RX_TXT,0,30) FROM SRX010 WHERE RX_COD = RG_TIPORES AND RX_TIP ='32' AND SRX010.D_E_L_E_T_=' ' AND ROWNUM = 1) FROM SRG010 WHERE RG_MAT = RI_MAT AND RG_FILIAL = RI_FILIAL AND SRG010.D_E_L_E_T_=' ' AND RG_DATADEM = RA.RA_DEMISSA AND ROWNUM = 1) DESC_DEMISSAO,

RA.RA_SINDICA COD_SINDICATO,
(SELECT RCE_DESCRI FROM RCE010 WHERE RCE_CODIGO = RA.RA_SINDICA AND RCE010.D_E_L_E_T_=' ') SINDICATO,
/*(SELECT RCE_ENTSIN FROM RCE010 WHERE RCE_CODIGO = RA.RA_SINDICA AND RCE010.D_E_L_E_T_=' ') ENTIDADE_SINDICATO,*/
1 CONTADOR,
RA.RA_CC||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = RA.RA_CC AND CTT010.D_E_L_E_T_=' ') CENTRO_CUSTO,
SUBSTR(RA.RA_CC,1,5)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
SUBSTR(RA.RA_CC,1,8)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC,
RA.RA_CATFUNC CAT_FUNCAO, 
(SELECT RJ_DESC FROM SRJ010 WHERE RJ_FUNCAO = RA_CODFUNC AND D_E_L_E_T_=' ') FUNCAO,
RA_CODFUNC COD_FUNCAO,
(SELECT SQ3010.Q3_DESCSUM FROM SQ3010 WHERE Q3_CARGO = RA_CARGO AND D_E_L_E_T_=' ') CARGO,

(SELECT RJ_CODCBO FROM SRJ010 WHERE RJ_FUNCAO = RA_CODFUNC AND D_E_L_E_T_=' ')  CBO,
RI_HORAS REFERENCIA,
RA_HRSEMAN HORAS_SEMANAL,

RA_HRSMES HORAS_MES,

/*CASE WHEN RC.RC_PD IN ('002','003','004','005','006','008','010','011','012','014','015','016',
'017','018','019','020','021','022','023','024','025','026','027','028','231','HE1','HE2') THEN 'SIM' ELSE 'NAO' END VERBA_FIXA,*/

CASE WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RI.RI_PD AND RV.D_E_L_E_T_=' ' )= '2' THEN (RI.RI_VALOR)*-1 ELSE (RI.RI_VALOR) END VALOR,
RI_PD COD_VERBA,
(SELECT RV_DESC FROM SRV010 RV WHERE RV.RV_COD = RI.RI_PD AND RV.D_E_L_E_T_=' ' )VERBA,

CASE WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RI.RI_PD AND RV.D_E_L_E_T_=' ' ) = '1' THEN 'PROVENTO'
WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RI.RI_PD AND RV.D_E_L_E_T_=' ' )= '2' THEN 'DESCONTO' ELSE 'BASE' END TIPO_VERBA,

SUBSTR(RI.RI_DATA,7,2)||'/'||SUBSTR(RI.RI_DATA,5,2)||'/'||SUBSTR(RI.RI_DATA,1,4) DATA_PGTO,
RA.RA_SITFOLH SITUACAO_FOLHA

FROM SRI010 RI INNER JOIN SRA010 RA ON RA.RA_MAT = RI.RI_MAT AND RA.RA_FILIAL = RI.RI_FILIAL 

WHERE RA.D_E_L_E_T_=' ' AND RI.D_E_L_E_T_=' ' AND RA.RA_CATFUNC <> 'A' AND RA.RA_MAT < '900000'