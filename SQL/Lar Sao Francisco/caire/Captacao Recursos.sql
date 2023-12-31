SELECT 

E5_FILIAL FILIAL,
TO_DATE(E5_DATA,'YYYYMMDD') PAGTO,
E5_TIPO TIPO,
E5_VALOR VALOR, 
E5_NATUREZ COD_NAT, 
ED_DESCRIC NATUREZA,
E5_BANCO BANCO, 
E5_AGENCIA AGENCIA, 
E5_CONTA CONTA, 
E5_BENEF BENEFIC,
E5_PREFIXO PREFIXO, 
E5_NUMERO NUMERO, 
E5_PARCELA PARCELA, 
E5_CLIFOR COD_CLI, 
E5_LOJA LOJA_CLI

FROM SE5010 
JOIN SED010 ON E5_NATUREZ = ED_CODIGO AND SUBSTR(E5_FILIAL,1,2) = SUBSTR(ED_FILIAL,1,2) AND SED010.D_E_L_E_T_=' '
WHERE E5_FILIAL = '11001' 
AND E5_DATA BETWEEN '20170101'AND'20171231' 
AND E5_RECPAG = 'R' 
AND E5_SITUACA = ' ' 
AND SE5010.D_E_L_E_T_=' ' 
AND E5_TIPODOC IN ('VL','BA')
AND ED_X_CPREC = 'S'
AND (E5_RECONC = 'x' OR E5_LOTE <> ' '); 

SELECT 

E5_FILIAL FILIAL,
/*TO_DATE(E5_DATA,'YYYYMMDD') PAGTO,*/
/*E5_TIPO TIPO,*/
E5_VALOR VALOR, 
E5_NATUREZ COD_NAT, 
ED_DESCRIC NATUREZA,
E5_BANCO BANCO, 
E5_AGENCIA AGENCIA, 
E5_CONTA CONTA,
SUM(CASE WHEN LAST_DAY(TO_DATE(E5_DATA,'YYYYMMDD')) = LAST_DAY(TO_DATE(/*'"+ DtoS(MV_PAR03) +"'*/'20170101','YYYYMMDD')) THEN E5_VALOR ELSE 0 END ) MES_1,
SUM(CASE WHEN LAST_DAY(TO_DATE(E5_DATA,'YYYYMMDD')) = ADD_MONTHS(LAST_DAY(TO_DATE(/*'"+ DtoS(MV_PAR03) +"'*/'20170101','YYYYMMDD')),1) THEN E5_VALOR ELSE 0 END ) MES_2
/*E5_BENEF BENEFIC,
E5_PREFIXO PREFIXO, 
E5_NUMERO NUMERO, 
E5_PARCELA PARCELA, 
E5_CLIFOR COD_CLI, 
E5_LOJA LOJA_CLI*/

FROM SE5010 
JOIN SED010 ON E5_NATUREZ = ED_CODIGO AND SUBSTR(E5_FILIAL,1,2) = SUBSTR(ED_FILIAL,1,2) AND SED010.D_E_L_E_T_=' '
WHERE E5_FILIAL = '11001' 
AND E5_DATA BETWEEN '20170101'AND'20171231' 
AND E5_RECPAG = 'R' 
AND E5_SITUACA = ' ' 
AND SE5010.D_E_L_E_T_=' ' 
AND E5_TIPODOC IN ('VL','BA')
AND ED_X_CPREC = 'S'
AND (E5_RECONC = 'x' OR E5_LOTE <> ' ')
GROUP BY
E5_FILIAL,
E5_VALOR, 
E5_NATUREZ, 
ED_DESCRIC,
E5_BANCO, 
E5_AGENCIA, 
E5_CONTA
; 

select * from af8010 where AF8_FILIAL = '11053';