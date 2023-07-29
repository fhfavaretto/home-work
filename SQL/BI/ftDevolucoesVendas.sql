create or alter view ftDevolucoesVendas as
  select    '01'+D1_FILIAL           AS idEmpresa  
  ,'01'+D1_FILIAL+D1_SERIE+D1_DOC+D1_FORNECE+D1_LOJA  AS idNotaFiscal  
  ,'01'+D1_FILIAL+D1_SERIORI+D1_NFORI+D1_FORNECE+D1_LOJA AS idNotaFiscalDevolvida  
  ,'01'+space(2)+D1_FORNECE+D1_LOJA AS idCliente  
  ,'01'+space(2)+D1_COD    AS idProduto   
  ,'01'+space(2)+F1_TRANSP    AS idTransportadora  
  ,'01'+space(2)+F1_COND    AS idCondicaoPagamento  
  ,'01'+space(2)+D1_CONTA    AS idContaContabil  
  ,'01'+space(2)+D1_CC     AS idCentroCusto  
  ,'01'+space(2)+D1_CLVL    AS idClasseValor  
  ,'01'+space(2)+D1_ITEMCTA   AS idItemContabil  
  ,'01'+space(2)+D1_LOCAL    AS idArmazem  
  ,'01'+substring(D1_FILIAL,1,2)+C5_VEND1    AS idVendedor     
  ,F1_MOEDA            AS idMoeda  
  ,F1_TXMOEDA            AS TaxaMoeda  
  ,D1_DOC             AS NumeroNotaFiscal  
  ,D1_SERIE            AS Serie  
  ,D1_UM             AS CodigoUnidadeMedida  
  ,LTRIM(RTRIM(UM.X5_DESCRI))        AS UnidadeMedida  
  ,D1_SEGUM            AS CodigoSegundaUnidadeMedida  
  ,LTRIM(RTRIM(UM2.X5_DESCRI))       AS SegundaUnidadeMedida  
  ,D1_CF             AS CFOP  
  ,LTRIM(RTRIM(CFOP.X5_DESCRI))       AS NaturezaOperacao  
  ,case F4_ESTOQUE when 'S' then 1 else 0 end   AS MovimentaEstoque  
  ,case C7_TPFRETE when 'C' then 'CIF' when 'F' then 'FOB' when 'T' then 'Terceiros' when 'S' then 'Sem Frete' else null end AS TipoFrete  
  ,cast(D1_DTDIGIT as date)        AS DataEntradaDevolucao  
  ,cast(D1_EMISSAO as date)        AS DataDevolucao  
  ,F1_HORA            AS HoraEntradaDevolucao  
  ,cast(C7_EMISSAO as date)        AS DataPedido  
  ,cast(C7_DATPRF  as date)        AS DataEntregaPrevista  
  ,D1_QUANT            AS Quantidade  
  ,D1_QTSEGUM            AS QuantidadeSegundaUnidadeMedida  
  ,D1_VUNIT            AS PrecoUnitario  
  ,D1_TOTAL            AS ValorMercadoria  
  ,D1_TOTAL+D1_VALIPI+D1_ICMSRET       AS ValorBruto  
  ,D1_VALIPI            AS ValorIPI  
  ,D1_VALICM            AS ValorICMS   
  ,D1_VALPIS            AS ValorPIS   
  ,D1_VALCOF            AS ValorCOFINS  
  ,D1_VALINS            AS ValorINSS  
  ,D1_VALDESC            AS ValorDesconto  
  ,B1_PESO * D1_QUANT          AS PesoLiquido  
  ,D1_CUSTO             AS CustoEstoque  
  ,D1_ICMSRET            AS ValorICMSSubstituicao  
  ,D1_DESPESA            AS ValorDespesa  
  ,D1_VALFRE             AS ValorFrete  
  ,D1_SEGURO             AS ValorSeguro    
  from   SD1010 AS SD1  
  join   SF4010 AS SF4  
  ON     F4_FILIAL = space(2) AND F4_CODIGO = D1_TES AND SF4.D_E_L_E_T_ = ''   
  join   SB1010 AS SB1  
  ON     B1_FILIAL = space(2) AND B1_COD = D1_COD AND SB1.D_E_L_E_T_ = ''   
  join   SF1010 AS SF1  
  ON     F1_FILIAL = substring(D1_FILIAL,1,2) AND F1_SERIE = D1_SERIE AND F1_DOC = D1_DOC AND F1_FORNECE = D1_FORNECE AND F1_LOJA = D1_LOJA AND SF1.D_E_L_E_T_ = ''   
  left outer join SD2010 AS SD2   
  ON     D2_FILIAL = substring(D1_FILIAL,1,2) AND D2_DOC = D1_NFORI AND D2_SERIE = D1_SERIORI AND D2_ITEM = D1_ITEMORI AND SD2.D_E_L_E_T_ = ''  
  left outer join SC5010 AS SC5   
  ON     C5_FILIAL = substring(D1_FILIAL,1,2) AND C5_NUM = D2_PEDIDO AND SC5.D_E_L_E_T_ = ''  
  left outer join   SC7010 AS SC7  
  ON     C7_FILIAL = substring(D1_FILIAL,1,2) AND C7_NUM = D1_PEDIDO AND C7_ITEM = D1_ITEMPC AND SC7.D_E_L_E_T_ = ''   
  left outer join SX5010 AS CFOP  
  ON     CFOP.X5_FILIAL = space(2) AND CFOP.X5_TABELA = '13' AND CFOP.X5_CHAVE = D1_CF AND CFOP.D_E_L_E_T_ = ''  
  left outer join SX5010 AS UM  
  ON     UM.X5_FILIAL = space(2) AND UM.X5_TABELA = '62' AND UM.X5_CHAVE = D1_UM AND UM.D_E_L_E_T_ = ''  
  left outer join SX5010 AS UM2  
  ON     UM2.X5_FILIAL = space(2) AND UM2.X5_TABELA = '62' AND UM2.X5_CHAVE = D1_SEGUM AND UM2.D_E_L_E_T_ = ''  
  WHERE  SD1.D_E_L_E_T_ = ''         AND D1_TIPO = 'D'      AND F4_DUPLIC = 'S'       AND F4_PODER3 = 'N'   