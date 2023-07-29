SELECT E2_FILIAL FILIAL,
/*E2_NUM NOTA,*/
A2_NOME FORNECEDOR, 
/*TO_DATE(E2_EMISSAO,'YYYYMMDD') EMISSAO,
TO_DATE(E2_VENCTO,'YYYYMMDD') VENCIMENTO,*/ 
ROUND(SUM(D1_TOTAL),2) VALOR,  
C7_CONTRA CONTRATO
FROM SE2010 
JOIN SA2010 ON SUBSTR(A2_FILIAL,1,2) = SUBSTR(E2_FILIAL,1,2) AND A2_COD = E2_FORNECE AND A2_LOJA = E2_LOJA AND SA2010.D_E_L_E_T_=' '
JOIN SD1010 ON D1_DOC = E2_NUM AND D1_SERIE = E2_PREFIXO AND E2_FORNECE = D1_FORNECE AND D1_LOJA = E2_LOJA AND SD1010.D_E_L_E_T_=' ' AND D1_FILIAL = E2_FILIAL
LEFT JOIN SC7010 ON C7_NUM = D1_PEDIDO AND C7_ITEM = D1_ITEMPC AND SC7010.D_E_L_E_T_=' ' AND D1_FILIAL = C7_FILIAL AND C7_CONTRA <> ' '
WHERE E2_EMISSAO BETWEEN '20180101'AND'20181231' AND SE2010.D_E_L_E_T_=' ' AND E2_TIPO = 'NF' AND E2_BAIXA <> ' '
GROUP BY E2_FILIAL, A2_NOME, C7_CONTRA
ORDER BY E2_FILIAL, A2_NOME, C7_CONTRA;


SELECT * FROM SF1010;