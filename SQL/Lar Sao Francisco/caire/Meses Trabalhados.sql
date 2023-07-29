SELECT RA_FILIAL,
RA_MAT,
RA_CC,
RA_NOMECMP, 
SUBSTR(RA_ADMISSA,7,2)||'/'||SUBSTR(RA_ADMISSA,5,2)||'/'||SUBSTR(RA_ADMISSA,1,4) ADMISSAO,
SUBSTR(RA_DEMISSA,7,2)||'/'||SUBSTR(RA_DEMISSA,5,2)||'/'||SUBSTR(RA_DEMISSA,1,4) DEMISSAO,
ROUND(MONTHS_BETWEEN(SYSDATE,TO_DATE(RA_ADMISSA,'YYYYMMDD')),0) MESES_TRABALHADOS,
RA_RESCRAI,
RA_AFASFGT

FROM SRA010

WHERE D_E_L_E_T_=' ' AND RA_FILIAL = '11051'
AND (RA_DEMISSA BETWEEN '20160101'AND'20161231' OR RA_DEMISSA = ' ')
AND RA_RESCRAI <> '31' AND RA_AFASFGT <> '5';