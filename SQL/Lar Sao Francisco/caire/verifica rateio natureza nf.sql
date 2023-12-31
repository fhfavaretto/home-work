SELECT 

E2_FILIAL, 
E2_PREFIXO,
E2_NUM,
E2_PARCELA,
E2_FORNECE,
E2__RAZAO, 
TO_DATE(E2_EMISSAO,'YYYYMMDD') EMISSAO,
NVL(NULLIF(E2_BASEPIS,0),E2_VALOR) VALOR,
EV_PERC, 
EV_VALOR,
ROUND(NVL(NULLIF(E2_BASEPIS,0),E2_VALOR) * EV_PERC,2) COMPARATIVO,
ROUND(EV_VALOR / NVL(NULLIF(E2_BASEPIS,0),E2_VALOR),7) PERC_REAL,
CASE WHEN ROUND(EV_VALOR / NVL(NULLIF(E2_BASEPIS,0),E2_VALOR),7) <> EV_PERC THEN 'SIM' ELSE 'N�O' END DIFERENTE

FROM SEV010 

JOIN SE2010 ON E2_FILIAL = EV_FILIAL 

AND E2_NUM = EV_NUM 
AND E2_FORNECE = EV_CLIFOR 
AND E2_LOJA = EV_LOJA 
AND E2_PREFIXO = EV_PREFIXO 
AND SEV010.D_E_L_E_T_<>'*'
AND EV_PERC <> 1
AND E2_PARCELA = EV_PARCELA

WHERE SE2010.D_E_L_E_T_<>'*'
AND E2_EMISSAO > '20170101'
/*AND ROUND(EV_VALOR / NVL(NULLIF(E2_BASEPIS,0),E2_VALOR),7) <> EV_PERC*/
AND E2_EMISSAO BETWEEN '20170801'AND'20170831'
AND E2_FILIAL = '11031'

ORDER BY E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_FORNECE, E2_LOJA

;