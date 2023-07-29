create or alter view ftCompras as
  select    '01'+D1_FILIAL                 AS idEmpresa  
  ,'01'+D1_FILIAL+D1_SERIE+D1_DOC+D1_FORNECE+D1_LOJA        AS idNotaFiscal  
  ,'01'+space(2)+D1_FORNECE+D1_LOJA AS idFornecedor  
  ,'01'+space(2)+D1_COD    AS idProduto   
  ,case when F1_TRANSP <> '' then '01'+space(2)+F1_TRANSP else '' end   AS idTransportadora  
  ,'01'+space(2)+F1_COND    AS idCondicaoPagamento  
  ,'01'+space(2)+D1_LOCAL    AS idArmazem  
  ,case when D1_CONTA <> '' then '01'+space(2)+D1_CONTA else '' end  AS idContaContabil  
  ,case when D1_CC <> '' then '01'+space(2)+D1_CC else '' end    AS idCentroCusto  
  ,case when D1_CLVL <> '' then '01'+space(2)+D1_CLVL else '' end    AS idClasseValor  
  ,case when D1_ITEMCTA <> '' then '01'+space(2)+D1_ITEMCTA else '' end AS idItemContabil  
  ,case when C7_COMPRA <> '' then '01'+space(2)+C7_COMPRA else '' end   AS idComprador  
  ,F1_ESPECIE            AS EspecieNF  
  ,F1_MOEDA            AS idMoeda  
  ,F1_TXMOEDA            AS TaxaMoeda  
  ,D1_DOC             AS NumeroNotaFiscal  
  ,D1_SERIE            AS Serie  
  ,D1_UM             AS CodigoUnidadeMedida  
  ,RTRIM(UM.X5_DESCRI)         AS UnidadeMedida  
  ,D1_SEGUM            AS CodigoSegundaUnidadeMedida  
  ,RTRIM(UM2.X5_DESCRI)         AS SegundaUnidadeMedida  
  ,D1_CF             AS CFOP  
  ,RTRIM(CFOP.X5_DESCRI)         AS NaturezaOperacao  
  ,D1_LOCAL            AS CodigoArmazem  
  ,case F4_ESTOQUE    when 'S' then 1   else 0 end            AS MovimentaEstoque  
  ,case C7_TPFRETE   when 'C' then 'CIF'   when 'F' then 'FOB'   when 'T' then 'Terceiros'   when 'S' then 'Sem Frete'   else null end           AS TipoFrete  
  ,cast(D1_DTDIGIT as date)        AS DataEntrada  
  ,cast(D1_EMISSAO as date)        AS DataEmissao  
  ,F1_HORA            AS HoraEmissao  
  ,cast(C7_EMISSAO as date)        AS DataPedido  
  ,cast(C7_DATPRF  as date)        AS DataEntregaPrevista  
  ,D1_QUANT            AS Quantidade  
  ,D1_VUNIT            AS PrecoUnitario  
  ,D1_TOTAL            AS ValorMercadoria  
  ,D1_VALIPI            AS ValorIPI  
  ,D1_VALICM            AS ValorICMS   
  ,D1_VALDESC            AS ValorDesconto  
  ,D1_PESO             AS PesoLiquido  
  ,D1_CUSTO             AS CustoEstoque  
  ,D1_ICMSRET            AS ValorICMSRetido  
  ,case when C7_EMISSAO > C7_DATPRF or C7_EMISSAO > D1_DTDIGIT then 0    else datediff(day,cast(C7_EMISSAO as date),cast(D1_DTDIGIT as date)) end AS LeadTimeReal     
  ,case when C7_EMISSAO > C7_DATPRF or C7_EMISSAO > D1_DTDIGIT then 0   else datediff(day,cast(C7_EMISSAO as date),cast(C7_DATPRF  as date)) end AS LeadTimePedido    
  ,case when D1_DTDIGIT > C7_DATPRF then datediff(day,cast(C7_DATPRF as date),cast(D1_DTDIGIT as date))    else 0 end       AS DiasAtraso    
  ,case when D1_DTDIGIT < C7_DATPRF then datediff(day,cast(D1_DTDIGIT as date),cast(C7_DATPRF as date))    else 0 end       AS DiasAntecipacao      
  from   SD1010 AS SD1  
  join   SF4010 AS SF4  
  ON     F4_FILIAL = space(2) AND F4_CODIGO = D1_TES AND F4_DUPLIC = 'S' AND F4_PODER3 = 'N' AND SF4.D_E_L_E_T_ = ''   
  join   SF1010 AS SF1  
  ON     F1_FILIAL = substring(D1_FILIAL,1,2) AND F1_SERIE = D1_SERIE AND F1_DOC = D1_DOC AND F1_FORNECE = D1_FORNECE AND F1_LOJA = D1_LOJA AND SF1.D_E_L_E_T_ = ''   
  left outer join SC7010 AS SC7  
  ON     C7_FILIAL = substring(D1_FILIAL,1,2) AND C7_NUM = D1_PEDIDO AND C7_ITEM = D1_ITEMPC AND SC7.D_E_L_E_T_ = ''   
  left outer join SX5010 AS CFOP  
  ON     CFOP.X5_FILIAL = space(2) AND CFOP.X5_TABELA = '13' AND CFOP.X5_CHAVE = D1_CF AND CFOP.D_E_L_E_T_ = ''  
  left outer join SX5010 AS UM  
  ON     UM.X5_FILIAL = space(2) AND UM.X5_TABELA = '62' AND UM.X5_CHAVE = D1_UM AND UM.D_E_L_E_T_ = ''  
  left outer join SX5010 AS UM2  
  ON     UM2.X5_FILIAL = space(2) AND UM2.X5_TABELA = '62' AND UM2.X5_CHAVE = D1_SEGUM AND UM2.D_E_L_E_T_ = ''  
  WHERE  SD1.D_E_L_E_T_ = '' AND (F1_TIPO = 'N' AND F1_ESPECIE <> 'CTE' OR (F1_ESPECIE = 'CTE' AND F1_TIPO = 'C'))  