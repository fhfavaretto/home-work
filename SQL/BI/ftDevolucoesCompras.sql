create or alter view ftDevolucoesCompras as
  select     '01'+D2_FILIAL      AS idEmpresa  
  ,'01'+D2_FILIAL+D2_SERIE+D2_DOC  AS idNotaFiscal  
  ,'01'+space(2)+D2_CLIENTE+D2_LOJA AS idFornecedor   
  ,'01'+space(2)+D2_COD    AS idProduto   
  ,'01'+space(2)+F2_TRANSP    AS idTransportadora  ,'01'+space(2)+F2_COND    AS idCondicaoPagamento  
  ,'01'+space(2)+D2_LOCAL    AS idArmazem  
  ,F2_MOEDA       AS idMoeda  
  ,F2_TXMOEDA       AS TaxaMoeda  
  ,D2_DOC        AS NumeroNotaFiscal  
  ,D2_SERIE       AS Serie  
  ,D2_UM        AS CodigoUnidadeMedida  
  ,RTRIM(UM.X5_DESCRI)    AS UnidadeMedida  
  ,D2_SEGUM       AS CodigoSegundaUnidadeMedida  
  ,RTRIM(UM2.X5_DESCRI)    AS SegundaUnidadeMedida  
  ,D2_CF        AS CFOP  
  ,RTRIM(CFOP.X5_DESCRI)    AS NaturezaOperacao  
  ,D2_LOCAL       AS CodigoArmazem  
  ,case F4_ESTOQUE    when 'S' then 1   else 0 end       AS MovimentaEstoque  
  ,D2_EST        AS UF  
  ,case C5_TPFRETE   when 'C' then 'CIF'   when 'F' then 'FOB'   when 'T' then 'Terceiros'   when 'S' then 'Sem Frete'   else null end      AS TipoFrete  
  ,cast(D2_EMISSAO as date)   AS DataEmissao  
  ,F2_HORA       AS HoraEmissao  
  ,cast(C5_EMISSAO as date)   AS DataPedido  
  ,D2_QUANT       AS Quantidade  
  ,D2_PRCVEN       AS PrecoUnitario  
  ,D2_TOTAL       AS ValorMercadoria  
  ,D2_VALBRUT       AS ValorBruto  
  ,D2_VALIPI       AS ValorIPI  
  ,D2_VALICM       AS ValorICMS   
  ,D2_PESO        AS PesoLiquido  
  ,D2_CUSTO1        AS CustoEstoque  
  ,D2_ICMSRET       AS ValorICMSRetido  
  from   SD2010 AS SD2  
  join   SF4010 AS SF4  
  ON     F4_FILIAL = space(2) AND F4_CODIGO = D2_TES AND F4_DUPLIC = 'S' AND F4_PODER3 = 'N' AND SF4.D_E_L_E_T_ = ''   
  join   SF2010 AS SF2  
  ON     F2_FILIAL = substring(D2_FILIAL,1,2) AND F2_SERIE = D2_SERIE AND F2_DOC = D2_DOC AND F2_CLIENTE = D2_CLIENTE AND F2_LOJA = D2_LOJA AND SF2.D_E_L_E_T_ = ''   
  join   SC5010 AS SC5  
  ON     C5_FILIAL = substring(D2_FILIAL,1,2) AND C5_NUM = D2_PEDIDO AND SC5.D_E_L_E_T_ = ''   
  left outer join SX5010 AS CFOP  
  ON     CFOP.X5_FILIAL = space(2) AND CFOP.X5_TABELA = '13' AND CFOP.X5_CHAVE = D2_CF AND CFOP.D_E_L_E_T_ = ''  
  left outer join SX5010 AS UM  
  ON     UM.X5_FILIAL = space(2) AND UM.X5_TABELA = '62' AND UM.X5_CHAVE = D2_UM AND UM.D_E_L_E_T_ = ''  
  left outer join SX5010 AS UM2  
  ON     UM2.X5_FILIAL = space(2) AND UM2.X5_TABELA = '62' AND UM2.X5_CHAVE = D2_SEGUM AND UM2.D_E_L_E_T_ = ''  
  WHERE  SD2.D_E_L_E_T_ = ''         AND D2_TIPO = 'D'     