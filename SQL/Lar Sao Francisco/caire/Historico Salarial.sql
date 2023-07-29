SELECT R7_FILIAL FILIAL,
R7_MAT MATRICULA,
(SELECT RA_NOMECMP FROM SRA010 WHERE RA_MAT = R7_MAT AND RA_FILIAL = R7_FILIAL AND SRA010.D_E_L_E_T_=' ')FUNCIONARIO,
(SELECT RA_SINDICA FROM SRA010 WHERE RA_MAT = R7_MAT AND RA_FILIAL = R7_FILIAL AND SRA010.D_E_L_E_T_=' ')SINDICATO,

SUBSTR(R7_DATA,7,2)||'/'||SUBSTR(R7_DATA,5,2)||'/'||SUBSTR(R7_DATA,1,4) DATA,
SUBSTR(R7_DATA,7,2) DIA_AUMENTO,
SUBSTR(R7_DATA,7,2) MES_AUMENTO,
SUBSTR(R7_DATA,7,2) ANO_AUMENTO,

R7_TIPO COD_AUMENTO,
(SELECT X5_DESCRI FROM SX5010 WHERE X5_TABELA = '41' AND X5_CHAVE = R7_TIPO AND SX5010.D_E_L_E_T_=' ') DESCRICAO_AUMENTO,
R7_DESCFUN FUNCAO,
R7_DESCCAR CARGO,
R7_CATFUNC CATEGORIA,
R3_PD COD_VERBA,
R3_DESCPD VERBA,
R3_VALOR VALOR_ATUAL,
R3_ANTEAUM VALOR_ANTERIOR

FROM SR3010 JOIN SR7010 ON (R3_FILIAL||R3_MAT||R3_DATA||R3_SEQ||R3_TIPO) =
(R7_FILIAL||R7_MAT||R7_DATA||R7_SEQ||R7_TIPO) AND SR7010.D_E_L_E_T_=' ' WHERE SR3010.D_E_L_E_T_=' ';