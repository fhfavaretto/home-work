CREATE
OR ALTER VIEW as
select
    C6_FILIAL AS idEmpresa,
    C6_FILIAL + C6_NUM AS idPedidoVenda,
    C5_CLIENTE + C5_LOJACLI AS idCliente,
    C6_PRODUTO AS idProduto,
    C5_NOTA AS NFe,
    C5_VEND1 AS idRepresentante1,
    C5_VEND2 AS idRepresentante2,
    C5_VEND3 AS idRepresentante3,
    C5_VEND4 AS idRepresentante4,
    C5_VEND5 AS idRepresentante5,
    C5_TRANSP AS idTransportadora,
    C5_CONDPAG AS idCondicaoPagamento,
    C5_TABELA AS idTabelaPreco,
    C5_REDESP AS idTransportadoraRedespacho,
    C6_CONTA AS idContaContabil,
    C6_CC AS idCentroCusto,
    C6_CLVL AS idClasseValor,
    C6_ITEMCTA AS idItemContabil,
    C6_LOCAL AS idArmazem,
    C5_NUM AS NumeroPedidoVenda,
    C5_MOEDA AS idMoeda,
    C5_TXMOEDA AS TaxaMoeda,
    CFOP.X5_DESCRI AS NaturezaOperacao,
    C6_UM AS CodigoUnidadeMedida,
    UM.X5_DESCRI AS UnidadeMedida,
    C6_SEGUM AS CodigoSegundaUnidadeMedida,
    UM2.X5_DESCRI AS SegundaUnidadeMedida,
    C6_CF AS CFOP,
    C6_LOCAL AS Armazem 
case
        when C5_NOTA <> '' then 1
        else 0
    end AS PedidoEncerrado,
    cast(C5_EMISSAO as date) AS DataPedido,
    cast(C6_ENTREG as date) AS DataEntrega,
    C6_QTDVEN AS QuantidadePedido 
,
    C6_QTDENT AS QuantidadeEntregue,
    C6_QTDENT2 AS QuantidadeEntregueSegundaUnidadeMedida,
CASE
        WHEN C6_BLQ = 'R' THEN 0
        ELSE C6_QTDVEN - C6_QTDENT
    END AS SaldoEntregar,
    C6_PRCVEN AS PrecoUnitario,
    C6_PRUNIT AS PrecoUnitarioTabela,
    C6_QTDVEN * C6_PRCVEN AS ValorVendido,
    C6_QTDENT * C6_PRCVEN AS ValorEntregue,
CASE
        WHEN C6_BLQ = 'R' THEN 0
        ELSE (C6_QTDVEN - C6_QTDENT) * C6_PRCVEN
    END AS ValorEntregar,
    C5_FRETE AS ValorFretePedido,
    C5_SEGURO AS ValorSeguroPedido,
    C5_DESPESA AS ValorDespesaPedido,
CASE
        WHEN SUBSTRING(C6_CF, 2, 2) = '91' THEN 'Bonificação'
        ELSE 'Venda'
    END AS TipoPedido
FROM
    SC6010 AS SC6
    JOIN SC5010 AS SC5 ON C6_FILIAL = C5_FILIAL
    AND C6_NUM = C5_NUM
    AND SC5.D_E_L_E_T_ = '' 
    LEFT OUTER JOIN SX5010 AS CFOP ON CFOP.X5_FILIAL = space(2)
    AND CFOP.X5_TABELA = '13'
    AND CFOP.X5_CHAVE = C6_CF
    AND CFOP.D_E_L_E_T_ = ''
    LEFT OUTER JOIN SX5010 AS UM ON UM.X5_FILIAL = space(2)
    AND UM.X5_TABELA = '62'
    AND UM.X5_CHAVE = C6_UM
    AND UM.D_E_L_E_T_ = ''
    LEFT OUTER JOIN SX5010 AS UM2 ON UM2.X5_FILIAL = space(2)
    AND UM2.X5_TABELA = '62'
    AND UM2.X5_CHAVE = C6_SEGUM
    AND UM2.D_E_L_E_T_ = ''
    LEFT OUTER JOIN SX5010 AS BLQ ON BLQ.X5_FILIAL = space(2)
    AND BLQ.X5_TABELA = 'F1'
    AND BLQ.X5_CHAVE = C6_BLQ
    AND BLQ.D_E_L_E_T_ = ''