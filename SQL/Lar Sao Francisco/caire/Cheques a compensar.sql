SELECT DISTINCT
EF_FILIAL FILIAL,
EF_BANCO BANCO,
EF_AGENCIA AGENCIA,
EF_CONTA CONTA,
EF_NUM CHEQUE,
EF_VALOR VALOR,
SUBSTR(EF_DATA,7,2)||'/'||SUBSTR(EF_DATA,5,2)||'/'||SUBSTR(EF_DATA,1,4) EMISSAO,
EF_PREFIXO PREFIXO,
EF_TITULO TITULO,
EF_PARCELA PARCELA,
EF_TIPO TIPO_TITULO,
EF_BENEF BENEFICIARIO,
EF_FORNECE||'-'||EF_LOJA COD_FORNECEDOR,
(SELECT A2_NOME FROM SA2010 WHERE A2_COD = EF_FORNECE AND A2_LOJA = EF_LOJA AND SA2010.D_E_L_E_T_=' ' AND SUBSTR(EF_FILIAL,1,2)=SUBSTR(A2_FILIAL,1,2)) FORNECEDOR

FROM SEF010 

WHERE EF_IMPRESS != 'C'
AND EF_VALORBX = 0 
AND EF_TIPO != 'TB'
AND EF_NUM != ' '
AND EF_TITULO != ' ' 
AND EF_DATA BETWEEN :DATA_INICIAL AND :DATA_FINAL
AND SEF010.D_E_L_E_T_=' '
AND (EF_BANCO,EF_AGENCIA,EF_CONTA,EF_NUM) NOT IN (SELECT E5_BANCO,E5_AGENCIA,E5_CONTA,E5_NUMCHEQ FROM SE5010 WHERE SE5010.D_E_L_E_T_=' ' AND E5_RECONC = 'x' )

ORDER BY EF_FILIAL, EF_NUM
;