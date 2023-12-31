SELECT Z5_FILTIT FILIAL,
Z5_NUMTIT TITULO,
Z5_MAT MATRICULA,
(SELECT RA_NOMECMP FROM SRA010 WHERE RA_MAT = Z5_MAT AND RA_FILIAL = Z5_FILTIT AND SRA010.D_E_L_E_T_=' ') FUNCIONARIO,
Z5_CC COD_CC,
Z5_PD COD_VERBA,
(SELECT RV_DESC FROM SRV010 WHERE RV_COD = Z5_PD AND SRV010.D_E_L_E_T_=' ') VERBA,
Z5_VALOR VALOR,
SUBSTR(RC1_EMISSA,7,2)||'/'||SUBSTR(RC1_EMISSA,5,2)||'/'||SUBSTR(RC1_EMISSA,1,4) EMISSAO,
SUBSTR(RC1_EMISSA,7,2) DIA_EMISSAO,
SUBSTR(RC1_EMISSA,5,2) MES_EMISSAO,
SUBSTR(RC1_EMISSA,1,4) ANO_EMISSAO,

SUBSTR(RC1_VENCTO,7,2)||'/'||SUBSTR(RC1_VENCTO,5,2)||'/'||SUBSTR(RC1_VENCTO,1,4) VENCIMENTO,
SUBSTR(RC1_VENCTO,7,2) DIA_VENCIMENTO,
SUBSTR(RC1_VENCTO,5,2) MES_VENCIMENTO,
SUBSTR(RC1_VENCTO,1,4) ANO_VENCIMENTO,

Z5_CC||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = Z5_CC AND CTT010.D_E_L_E_T_=' ') CENTRO_CUSTO,
SUBSTR(Z5_CC,1,5)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(Z5_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
SUBSTR(Z5_CC,1,8)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(Z5_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC


FROM SZ5010 JOIN RC1010 ON RC1_NUMTIT = Z5_NUMTIT AND RC1_FILTIT = Z5_FILTIT AND RC1010.D_E_L_E_T_=' '

WHERE SZ5010.D_E_L_E_T_=' ' ORDER BY Z5_NUMTIT;