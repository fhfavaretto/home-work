create or alter view ftCarteiraCompras as
  select    '01'+C7_FILIAL                 AS idEmpresa  
  ,'01'+C7_FILIAL+C7_NUM               AS idPedidoCompra  
  ,'01'+space(2)+C7_FORNECE+C7_LOJA AS idFornecedor  
  ,'01'+space(2)+C7_PRODUTO   AS idProduto   
  ,'01'+space(2)+C7_CONTA    AS idContaContabil  
  ,'01'+space(2)+C7_CC     AS idCentroCusto  
  ,'01'+space(2)+C7_ITEMCTA   AS idItemContabil  
  ,'01'+space(2)+C7_CLVL    AS idClasseValor  
  ,'01'+space(2)+C7_LOCAL    AS idArmazem  
  ,'01'+space(2)+C7_COND    AS idCondicaoPagamento  
  ,'01'+space(2)+C7_COMPRA    AS idComprador    
  ,C7_NUM             AS NumeroPedidoCompra  
  ,C7_UM             AS CodigoUnidadeMedida  
  ,RTRIM(UM.X5_DESCRI)         AS UnidadeMedida  
  ,cast(C7_EMISSAO as date)        AS DataEmissao  
  ,cast(C7_DATPRF  as date)        AS DataEntregaPrevista  
  ,C7_EMITIDO            AS PedidoEmitido  
  ,case C7_TPFRETE   when 'C' then 'CIF'   when 'F' then 'FOB'   when 'T' then 'Terceiros'   when 'S' then 'Sem Frete'   else null end           AS TipoFrete  
  ,C7_TES             AS TES  
  ,C7_MOEDA            AS idMoeda  
  ,C7_TXMOEDA            AS TaxaMoeda  
  ,CASE C7_CONAPRO    WHEN 'L' THEN 'Liberado'    WHEN 'B' THEN 'Bloqueado'    ELSE 'Liberado' END         AS ControleAprovacao  
  ,C7_QUANT            AS QuantidadePedido  
  ,C7_QUJE            AS QuantidadeEntregue  
  ,C7_QUANT - C7_QUJE          AS SaldoEntregar  
  ,C7_PRECO            AS PrecoUnitario  
  ,C7_TOTAL/C7_QUANT*(C7_QUANT-C7_QUJE)     AS ValorMercadoria  
  ,C7_VLDESC            AS ValorDesconto  
  ,C7_SEGURO            AS ValorSeguro  
  ,C7_DESPESA            AS ValorDespesa  
  ,C7_VALFRE            AS ValorFrete    
  from   SC7010 AS SC7  
  left outer join SX5010 AS UM  
  ON     UM.X5_FILIAL = space(2) AND UM.X5_TABELA = '62' AND UM.X5_CHAVE = C7_UM AND UM.D_E_L_E_T_ = ''  
  where  SC7.D_E_L_E_T_ = ''         AND C7_RESIDUO <> 'S'         AND C7_ENCER   = ''      AND C7_QUANT > C7_QUJE  