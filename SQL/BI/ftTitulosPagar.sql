create or alter view ftTitulosPagar as
  SELECT    '01'+E2_FILORIG                 AS idEmpresa  
  ,'01'+E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_FORNECE+E2_LOJA+E2_TIPO   AS idTitulo  
  ,'01'+space(2)+E2_FORNECE+E2_LOJA AS idFornecedor   
  ,'01'+space(2)+E2_NATUREZ    AS idNatureza  
  ,E2_PORTADO      AS idPortador  
  ,E2_BCOPAG      AS idBancoPagamento  
  ,E2_MOEDA      AS idMoeda  
  ,CAST(E2_EMISSAO AS DATE)  AS DataEmissao  
  ,CAST(E2_VENCREA AS DATE)  AS DataVencimento  
  ,CAST(E2_VENCORI AS DATE)  AS DataVencimentoOriginal  
  ,E2_PREFIXO      AS Prefixo  
  ,E2_NUM       AS NumeroTitulo  
  ,E2_PARCELA      AS Parcela  
  ,E2_TIPO      AS CodigoTipoTitulo  
  ,RTRIM(TPT.X5_DESCRI)   AS TipoTitulo  
  ,E2_STATUS                      AS Status  
  ,CASE E2_FLUXO   WHEN 'N' THEN 'Não'   ELSE 'Sim' END    AS FluxoCaixa  
  ,DATEDIFF(DAY,CAST(E2_EMISSAO AS DATE),CAST(E2_VENCREA AS DATE)) AS PrazoPagamento  
  ,E2_VALOR                       AS ValorPagar  
  ,E2_SALDO      AS SaldoPagar  
  ,E2_ISS       AS ValorISS  
  ,E2_IRRF         AS ValorIRRF  
  ,E2_INSS         AS ValorINSS  
  ,E2_PIS          AS ValorPIS  
  ,E2_COFINS       AS ValorCOFINS  
  ,E2_CSLL         AS ValorCSLL  
  ,E2_VRETPIS      AS ValorPISRetido  
  ,E2_VRETCOF      AS ValorCOFINSRetido  
  ,E2_VRETCSL      AS ValorCSLLRetido  
  ,E2_DESCONT      AS ValorDesconto  
  ,E2_MULTA        AS ValorMulta  
  ,E2_CORREC       AS ValorCorrecao  
  ,E2_VALJUR       AS ValorJuros  
  FROM   SE2010 AS SE2 (NOLOCK)  
  JOIN   SX5010 AS TPT (NOLOCK)   
  ON     X5_FILIAL = space(2) AND X5_TABELA = '05' AND X5_CHAVE = E2_TIPO AND TPT.D_E_L_E_T_ = ''  
  WHERE  SE2.D_E_L_E_T_ = '' AND E2_STATUS <> 'D'  