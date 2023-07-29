SELECT * FROM CTT010 WHERE CTT_FILIAL = '11' AND CTT_DESC01 LIKE '%MILHO%' AND D_E_L_E_T_=' ' ORDER BY CTT_CUSTO;


SELECT 

D1_FILIAL FILIAL, 
(SELECT A2_NOME FROM SA2010 WHERE A2_COD = D1_FORNECE AND A2_LOJA = D1_LOJA AND SUBSTR(A2_FILIAL,1,2) = SUBSTR(D1_FILIAL,1,2) AND SA2010.D_E_L_E_T_=' ' ) FORNECEDOR,
D1_DOC NOTA, 
(SELECT TRIM(B1_DESC) FROM SB1010 WHERE B1_COD = D1_COD AND SUBSTR(B1_FILIAL,1,2) = SUBSTR(D1_FILIAL,1,2) AND SB1010.D_E_L_E_T_=' ') PRODUTO,
ROUND(SUM(D1_QUANT) ,2) QTDE,
ROUND(SUM(D1_VUNIT) ,2) UNITARIO,
ROUND(SUM(D1_TOTAL) * NVL(DE_PERC/100,1),2)  TOTAL,
NVL(DE_CC,D1_CC)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = NVL(DE_CC,D1_CC) AND CTT010.D_E_L_E_T_=' ' AND SUBSTR(CTT_FILIAL,1,2) = SUBSTR(D1_FILIAL,1,2)) CENTRO_CUSTO,
TO_DATE(D1_EMISSAO,'YYYYMMDD') EMISSAO,
(SELECT ED_DESCRIC FROM SED010 WHERE ED_CODIGO = D1__NATURE AND SUBSTR(ED_FILIAL,1,2) = SUBSTR(D1_FILIAL,1,2) AND SED010.D_E_L_E_T_=' ') NATUREZA

FROM SD1010

LEFT JOIN SDE010 ON D1_FILIAL = DE_FILIAL 
AND D1_DOC = DE_DOC AND D1_SERIE = DE_SERIE 
AND D1_FORNECE = DE_FORNECE
AND D1_LOJA = DE_LOJA 
AND SDE010.D_E_L_E_T_=' ' 
AND DE_ITEMNF = D1_ITEM 
AND DE_PERC <> 100

WHERE SD1010.D_E_L_E_T_=' ' 
AND D1_DTDIGIT BETWEEN '20190521' AND '20190531'
AND D1_EMISSAO BETWEEN '20190401' AND '20190531'
AND D1_X_USR BETWEEN ' ' AND 'ZZZZZZ'
AND D1__NATURE BETWEEN ' ' AND 'ZZZZZZZZZZ'
AND D1_FILIAL BETWEEN '11001' AND '11001'
AND D1_FORNECE BETWEEN ' ' AND 'ZZZZZZ'
AND D1_LOJA BETWEEN ' ' AND 'ZZ'
AND NVL(DE_CC,D1_CC) BETWEEN ' ' AND 'ZZZZZZZZZZZZ'
AND D1_COD BETWEEN ' ' AND 'ZZZZZZZZZZZZZZZ'

GROUP BY D1_FILIAL,D1_COD,D1_FORNECE,D1_LOJA,D1_DOC,D1_EMISSAO,D1__NATURE,NVL(DE_CC,D1_CC),DE_PERC
ORDER BY D1_FILIAL,NVL(DE_CC,D1_CC),D1_DOC
;

SELECT * FROM SD1010 WHERE D_E_L_E_T_=' ' AND D1_X_USR <> ' ';