SELECT EF_FILIAL,EF_FILORIG,EF_BANCO,EF_AGENCIA,EF_CONTA,EF_NUM,E5_NUMCHEQ,EF_VALOR, EF_DATA,E5_DATA,E5_DTDISPO,EF_PREFIXO,
EF_TITULO,E5_NUMERO,EF_PARCELA,EF_TIPO,EF_BENEF,EF_HIST,EF_ORIGEM
 FROM SEF010 JOIN SE5010 ON EF_TITULO = E5_NUMERO AND EF_NUM = E5_NUMCHEQ AND EF_FILIAL = E5_FILIAL AND (E5_DTDISPO=' ' OR E5_DTDISPO>:DATA_FINAL) 
 AND E5_DATA BETWEEN :DATA_INICIAL AND :DATA_FINAL;