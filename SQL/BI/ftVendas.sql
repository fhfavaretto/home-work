create or alter view ftVendas as
  select       '01'+C6_FILIAL   AS idEmpresa    
  ,'01'+C6_FILIAL+C6_NUM AS idPedidoVenda  
  ,'01'+space(2)+C5_CLIENTE+C5_LOJACLI AS idCliente     
  ,'01'+space(2)+C6_PRODUTO   AS idProduto     
  ,'01'+space(2)+C5_VEND1    AS idRepresentante1    
  ,'01'+space(2)+C5_VEND2    AS idRepresentante2    
  ,'01'+space(2)+C5_VEND3    AS idRepresentante3    
  ,'01'+space(2)+C5_VEND4    AS idRepresentante4    
  ,'01'+space(2)+C5_VEND5    AS idRepresentante5    
  ,'01'+space(2)+C5_TRANSP    AS idTransportadora    
  ,'01'+space(2)+C5_CONDPAG   AS idCondicaoPagamento    
  ,'01'+space(2)+C5_TABELA    AS idTabelaPreco  
  ,'01'+space(2)+C5_REDESP    AS idTransportadoraRedespacho  
  ,'01'+space(2)+C6_CONTA    AS idContaContabil  
  ,'01'+space(2)+C6_CC     AS idCentroCusto  
  ,'01'+space(2)+C6_CLVL    AS idClasseValor  
  ,'01'+space(2)+C6_ITEMCTA   AS idItemContabil  
  ,'01'+space(2)+C6_LOCAL    AS idArmazem    
  ,C5_NUM        AS NumeroPedidoVenda  
  ,C5_MOEDA       AS idMoeda    
  ,C5_TXMOEDA       AS TaxaMoeda    
  ,LTRIM(RTRIM(CFOP.X5_DESCRI))  AS NaturezaOperacao    
  ,C6_UM        AS CodigoUnidadeMedida    
  ,LTRIM(RTRIM(UM.X5_DESCRI))   AS UnidadeMedida    
  ,C6_SEGUM       AS CodigoSegundaUnidadeMedida    
  ,LTRIM(RTRIM(UM2.X5_DESCRI))  AS SegundaUnidadeMedida    
  ,C6_CF        AS CFOP    
  ,C6_LOCAL       AS Armazem    
  ,case C5_TPFRETE      when 'C' then 'CIF'    when 'F' then 'FOB'   when 'T' then 'Terceiros'      when 'S' then 'Sem Frete'    else null end      AS TipoFrete    
  ,case F4_DUPLIC    when 'S' then 1   else 0 end       AS GeraDuplicata  
  ,case F4_ESTOQUE    when 'S' then 1    else 0 end       AS AtualizaEstoque  
  ,case when C6_BLOQUEI = ' and C6_BLQ = '    then 0    else 1 end       AS PedidoBloqueado  
  ,LTRIM(RTRIM(BLQ.X5_DESCRI))  AS BloqueioPedido    
  ,case when C5_NOTA <> ''    then 1    else 0 end       AS PedidoEncerrado  
  ,cast(C5_EMISSAO as date)   AS DataPedido  
  ,cast(C6_ENTREG as date)   AS DataEntrega  
  ,C6_QTDVEN       AS QuantidadePedido  
  ,CASE WHEN B1_TIPCONV = 'M' THEN C6_QTDVEN * B1_CONV        WHEN B1_TIPCONV = 'D' AND B1_CONV <> 0 THEN C6_QTDVEN / B1_CONV      ELSE 0 END     AS QuantidadePedidoSegundaUnidadeMedida  
  ,C6_QTDENT       AS QuantidadeEntregue  
  ,C6_QTDENT2       AS QuantidadeEntregueSegundaUnidadeMedida  
  ,CASE WHEN C6_BLQ = 'R' THEN 0    ELSE C6_QTDVEN - C6_QTDENT END  AS SaldoEntregar  
  ,C6_PRCVEN       AS PrecoUnitario    
  ,C6_PRUNIT       AS PrecoUnitarioTabela  
  ,C6_QTDVEN*C6_PRCVEN    AS ValorVendido  
  ,C6_QTDENT*C6_PRCVEN    AS ValorEntregue  
  ,CASE WHEN C6_BLQ = 'R' THEN 0    ELSE (C6_QTDVEN - C6_QTDENT) * C6_PRCVEN     END        AS ValorEntregar  
  ,C5_FRETE       AS ValorFretePedido  
  ,C5_SEGURO       AS ValorSeguroPedido  
  ,C5_DESPESA       AS ValorDespesaPedido  
  ,CASE WHEN SUBSTRING(C6_CF,2,2) = '91' THEN 'Bonificação'    ELSE 'Venda' END                 AS TipoPedido    
  FROM SC6010 AS SC6  
  JOIN SC5010 AS SC5  
  ON   C6_FILIAL = C5_FILIAL AND C6_NUM = C5_NUM AND SC5.D_E_L_E_T_ = ''  
  JOIN   SF4010 AS SF4    
  ON     F4_FILIAL = space(2) AND F4_CODIGO = C6_TES AND SF4.D_E_L_E_T_ = ''    
  JOIN   SB1010 AS SB1  
  ON     B1_FILIAL = space(2) AND B1_COD = C6_PRODUTO AND SB1.D_E_L_E_T_ = ''    
  LEFT OUTER JOIN SX5010 AS CFOP   
  ON CFOP.X5_FILIAL = space(2) AND CFOP.X5_TABELA = '13' AND CFOP.X5_CHAVE = C6_CF AND CFOP.D_E_L_E_T_ = ''    
  LEFT OUTER JOIN SX5010 AS UM     
  ON UM.X5_FILIAL = space(2) AND UM.X5_TABELA = '62' AND UM.X5_CHAVE = C6_UM AND UM.D_E_L_E_T_ = ''    
  LEFT OUTER JOIN SX5010 AS UM2    
  ON UM2.X5_FILIAL = space(2) AND UM2.X5_TABELA = '62' AND UM2.X5_CHAVE = C6_SEGUM AND UM2.D_E_L_E_T_ = ''    
  LEFT OUTER JOIN SX5010 AS BLQ    
  ON BLQ.X5_FILIAL = space(2) AND BLQ.X5_TABELA = 'F1' AND BLQ.X5_CHAVE = C6_BLQ AND BLQ.D_E_L_E_T_ = ''      
  WHERE SC6.D_E_L_E_T_ = ''  AND C5_TIPO   = 'N'  AND (F4_DUPLIC = 'S' OR SUBSTRING(C6_CF,2,2) = '91')  AND F4_PODER3 = 'N'   