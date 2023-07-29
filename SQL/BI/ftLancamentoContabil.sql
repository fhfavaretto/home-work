create or alter view ftLancamentoContabil as
  select    '01'+CT2_FILIAL        AS idEmpresa  
  ,CT2_EMPORI+CT2_FILORI          AS idEmpresaOriginal  
  ,'01'+CT2_FILIAL+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA      AS idLancamentoContabil  
  ,case CT2_DEBITO when '' then null else '01'+space(2)+CT2_DEBITO  end  AS idContaContabil  
  ,case CT2_CCD    when '' then null else '01'+space(2)+CT2_CCD     end  AS idCentroCusto  
  ,case CT2_ITEMD  when '' then null else '01'+space(2)+CT2_ITEMD   end  AS idItemContabil  
  ,case CT2_CLVLDB when '' then null else '01'+space(2)+CT2_CLVLDB  end  AS idClasseValor  
  ,CT2_LOTE       AS Lote  
  ,CT2_SBLOTE       AS SubLote  
  ,CT2_DOC       AS Documento  
  ,CAST(CT2_DATA AS DATE)    AS DataLancamento  
  ,CT2_MOEDLC                AS CodigoMoedaLancamento  
  ,RTRIM(CTO_DESC)           AS MoedaLancamento  
  ,'Débito'                AS TipoLancamento  
  ,CT2_DEBITO                AS CodigoConta  
  ,CT2_CCD                   AS CodigoCentroCusto  
  ,CT2_ITEMD                 AS CodigoItemContabil  
  ,CT2_CLVLDB                AS CodigoClasseValor  
  ,CT2_ATIVDE                AS CodigoAtividade  
  ,RTRIM(X5_DESCRI)          AS TipoSaldo  
  ,CASE CT2_INTERC   WHEN '1' THEN 'Sim'   ELSE 'Não' END          AS Intercompany  
  ,-CT2_VALOR       AS ValorContabil  
  ,RTRIM(CT2_HIST) AS Historico
  FROM   CT2010 AS CT2  
  JOIN   CTO010 AS CTO   
  ON     CTO_FILIAL = space(2) AND CTO_MOEDA = CT2_MOEDLC AND CTO.D_E_L_E_T_ = ''  
  LEFT OUTER JOIN   SX5010 AS SX5   
  ON     X5_FILIAL = space(2) AND X5_TABELA = 'SL' AND X5_CHAVE = CT2_TPSALD AND SX5.D_E_L_E_T_ = ''  
  WHERE CT2.D_E_L_E_T_ = ''  AND CT2_DC IN ('1','3')  AND CT2_TPSALD = '1'    
  UNION ALL    
  select    '01'+CT2_FILIAL        AS idEmpresa  
  ,CT2_EMPORI+CT2_FILORI          AS idEmpresaOriginal  
  ,'01'+CT2_FILIAL+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA      AS idLancamentoContabil  
  ,case CT2_CREDIT when '' then null else '01'+space(2)+CT2_CREDIT end AS idContaContabil  
  ,case CT2_CCC    when '' then null else '01'+space(2)+CT2_CCC    end AS idCentroCusto  
  ,case CT2_ITEMC  when '' then null else '01'+space(2)+CT2_ITEMC  end AS idItemContabil  
  ,case CT2_CLVLCR when '' then null else '01'+space(2)+CT2_CLVLCR end AS idClasseValor  
  ,CT2_LOTE       AS Lote  
  ,CT2_SBLOTE       AS SubLote  
  ,CT2_DOC       AS Documento  
  ,CAST(CT2_DATA AS DATE)    AS DataLancamento  
  ,CT2_MOEDLC                AS CodigoMoedaLancamento  
  ,RTRIM(CTO_DESC)           AS MoedaLancamento  
  ,'Crédito'               AS TipoLancamento  
  ,CT2_CREDIT                AS CodigoConta  
  ,CT2_CCC                   AS CodigoCentroCusto  
  ,CT2_ITEMC                 AS CodigoItemContabil  
  ,CT2_CLVLCR                AS CodigoClasseValor  
  ,CT2_ATIVDE                AS CodigoAtividade  
  ,RTRIM(X5_DESCRI)          AS TipoSaldo  
  ,CASE CT2_INTERC   WHEN '1' THEN 'Sim'   ELSE 'Não' END          AS Intercompany  
  ,CT2_VALOR       AS ValorContabil    
  ,RTRIM(CT2_HIST) AS Historico
  FROM   CT2010 AS CT2  
  JOIN   CTO010 AS CTO   
  ON     CTO_FILIAL = space(2) AND CTO_MOEDA = CT2_MOEDLC AND CTO.D_E_L_E_T_ = ''  
  LEFT OUTER JOIN   SX5010 AS SX5   
  ON     X5_FILIAL = space(2) AND X5_TABELA = 'SL' AND X5_CHAVE = CT2_TPSALD AND SX5.D_E_L_E_T_ = ''  
  WHERE CT2.D_E_L_E_T_ = ''  AND CT2_DC IN ('2','3')  AND CT2_TPSALD = '1'  