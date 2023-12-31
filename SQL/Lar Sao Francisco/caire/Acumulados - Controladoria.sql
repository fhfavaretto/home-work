SELECT 

RD.RD_FILIAL FILIAL,
RD.RD_MAT MATRICULA,
RA.RA_NOMECMP NOME,
RA.RA_SINDICA COD_SINDICATO,
(SELECT RCE_DESCRI FROM RCE010 WHERE RCE_CODIGO = RA.RA_SINDICA AND RCE010.D_E_L_E_T_=' ') SINDICATO,

CASE WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RD_PD AND RV.D_E_L_E_T_=' ' )= '2' THEN (RD.RD_VALOR)*-1 ELSE (RD.RD_VALOR) END VALOR,
RD_PD COD_VERBA,
(SELECT RV_DESC FROM SRV010 RV WHERE RV.RV_COD = RD_PD AND RV.D_E_L_E_T_=' ' )VERBA,

CASE WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RD_PD AND RV.D_E_L_E_T_=' ' ) = '1' THEN 'PROVENTO'
WHEN (SELECT RV_TIPOCOD FROM SRV010 RV WHERE RV.RV_COD = RD_PD AND RV.D_E_L_E_T_=' ' )= '2' THEN 'DESCONTO' ELSE 'BASE' END TIPO_VERBA,

RD_CC CC,
(SELECT CTT_DESC01 FROM CTT010 WHERE RD_CC = CTT_CUSTO AND CTT010.D_E_L_E_T_=' ' ) CENTRO_CUSTO,
(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC,

SUBSTR(RD.RD_DATARQ,5,2)||'/'||SUBSTR(RD.RD_DATARQ,1,4) DATA_ARQ,
SUBSTR(RD.RD_DATARQ,5,2) MES,
SUBSTR(RD.RD_DATARQ,1,4) ANO,
RA.RA_CATFUNC CATEGORIA,

SUBSTR(RD.RD_DATPGT,7,2)||'/'||SUBSTR(RD.RD_DATPGT,5,2)||'/'||SUBSTR(RD.RD_DATPGT,1,4) DATA_PGTO,
SUBSTR(RD.RD_DATPGT,7,2) DIA_PGTO,
SUBSTR(RD.RD_DATPGT,5,2) MES_PGTO,
SUBSTR(RD.RD_DATPGT,1,4) ANO_PGTO

FROM SRD010 RD INNER JOIN SRA010 RA ON RA.RA_MAT = RD.RD_MAT AND RA.RA_FILIAL = RD.RD_FILIAL

WHERE RA.D_E_L_E_T_=' ' AND RD.D_E_L_E_T_=' ' AND RD.RD_DATPGT>='20150101';