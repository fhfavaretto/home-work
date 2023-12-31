SELECT 
RB_FILIAL FILIAL,
RB_MAT MATRICULA,
RA_NOMECMP FUNCIONARIO,
RB_NOME DEPENDENTE,
SUBSTR(RB_DTNASC,7,2)||'/'||SUBSTR(RB_DTNASC,5,2)||'/'||SUBSTR(RB_DTNASC,1,4) NASCIMENTO,
RB_SEXO GENERO,
CASE WHEN RB_GRAUPAR = 'C' THEN 'CONJUGE'
WHEN RB_GRAUPAR = 'F' THEN 'FILHO'
WHEN RB_TPDEP = 'E' THEN 'ENTIADO'
WHEN RB_TPDEP = 'P' THEN 'PAI/MAE'
WHEN RB_TPDEP = 'O' THEN 'OUTROS' ELSE ' ' END TIPO_DEPENDENTE,
CASE WHEN RB_AUXCRE = '2' THEN 'NAO' WHEN RB_AUXCRE = '1' THEN 'SIM' ELSE ' ' END AUX_CRECHE,
(SELECT RCE_CODIGO FROM RCE010 WHERE RCE_CODIGO = RA_SINDICA AND RCE010.D_E_L_E_T_=' ' AND ROWNUM = 1) COD_SINDICATO,
(SELECT RCE_DESCRI FROM RCE010 WHERE RCE_CODIGO = RA_SINDICA AND RCE010.D_E_L_E_T_=' ' AND ROWNUM = 1) SINDICATO


FROM SRB010 JOIN SRA010 ON RA_MAT = RB_MAT AND RA_FILIAL = RB_FILIAL AND SRA010.D_E_L_E_T_=' ' WHERE SRB010.D_E_L_E_T_=' ';

