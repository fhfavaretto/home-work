SELECT 

RD.RD_FILIAL FILIAL,
RD.RD_MAT MATRICULA,
RA.RA_NOMECMP NOME,
RA.RA_HRSMES HORAS_MES,
RA.RA_SINDICA COD_SINDICATO,
(SELECT RCE_DESCRI FROM RCE010 WHERE RCE_CODIGO = RA.RA_SINDICA AND RCE010.D_E_L_E_T_=' ') SINDICATO,
(SELECT RCE_ENTSIN FROM RCE010 WHERE RCE_CODIGO = RA.RA_SINDICA AND RCE010.D_E_L_E_T_=' ') ENTIDADE_SINDICATO,

RA.RA_ESTADO ESTADO,
RA.RA_MUNICIP CIDADE,
RA.RA_SALARIO SALARIO_BASE,
(SELECT CCH_PAIS FROM CCH010 PAIS WHERE PAIS.CCH_CODIGO = RA.RA_CPAISOR AND PAIS.D_E_L_E_T_=' ' AND ROWNUM = 1) PAIS_ORIGEM,
RA.RA_TELEFON TELEFONE,

(SELECT RJ_DESC FROM SRJ010 WHERE RJ_FUNCAO = RA.RA_CODFUNC AND D_E_L_E_T_=' ') FUNCAO,
(SELECT SQ3010.Q3_DESCSUM FROM SQ3010 WHERE Q3_CARGO = RA.RA_CARGO AND D_E_L_E_T_=' ') CARGO,

(SUBSTR(RA_NASC,7,2)||'/'||SUBSTR(RA_NASC,5,2)||'/'||SUBSTR(RA_NASC,1,4)) NASCIMENTO,
(SUBSTR(RA_ADMISSA,7,2)||'/'||SUBSTR(RA_ADMISSA,5,2)||'/'||SUBSTR(RA_ADMISSA,1,4)) ADMISSAO,
(SUBSTR(RA_DEMISSA,7,2)||'/'||SUBSTR(RA_DEMISSA,5,2)||'/'||SUBSTR(RA_DEMISSA,1,4)) DEMISSAO,

(SELECT RG_TIPORES FROM SRG010 WHERE RG_MAT = RD_MAT AND RG_FILIAL = RD_FILIAL AND SRG010.D_E_L_E_T_=' ' AND RG_DATADEM = RA.RA_DEMISSA) COD_DEMISSAO,
(SELECT (SELECT SUBSTR(RX_TXT,0,30) FROM SRX010 WHERE RX_COD = RG_TIPORES AND RX_TIP ='32' AND SRX010.D_E_L_E_T_=' ') FROM SRG010 WHERE RG_MAT = RD_MAT AND RG_FILIAL = RD_FILIAL AND SRG010.D_E_L_E_T_=' '  AND RG_DATADEM = RA.RA_DEMISSA) DESC_DEMISSAO,

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
SUBSTR(RD.RD_DATPGT,1,4) ANO_PGTO,

CASE WHEN RA.RA_TPCONTR = 1 THEN 'INDETERMINADO' WHEN RA.RA_TPCONTR = 2 THEN 'DETERMINADO' ELSE '' END TIPO_CONTRIBUCAO

FROM SRD010 RD INNER JOIN SRA010 RA ON RA.RA_MAT = RD.RD_MAT AND RA.RA_FILIAL = RD.RD_FILIAL

WHERE RA.D_E_L_E_T_=' ' AND RD.D_E_L_E_T_=' ' AND (SELECT RG_TIPORES FROM SRG010 WHERE RG_MAT = RD_MAT AND RG_FILIAL = RD_FILIAL AND SRG010.D_E_L_E_T_=' ')is not null;


SELECT * FROM RC011502 order by RC_DATA;
SELECT * FROM SRA010 WHERE RA_FILIAL = '11032' AND RA_CTDEPSA LIKE '%7777%';

SELECT * FROM SRG010;
SELECT * FROM SRX010;