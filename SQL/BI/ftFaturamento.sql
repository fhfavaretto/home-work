create or alter view ftFaturamento as
  select    '01'+D2_FILIAL      AS idEmpresa  
  ,'01'+D2_FILIAL+D2_SERIE+D2_DOC  AS idNotaFiscal  
  ,'01'+space(2)+D2_CLIENTE+D2_LOJA AS idCliente   
  ,'01'+space(2)+D2_COD    AS idProduto   
  ,'01'+space(2)+F2_VEND1     AS idVendedor1  
  ,'01'+space(2)+F2_VEND2     AS idVendedor2  
  ,'01'+space(2)+F2_VEND3     AS idVendedor3  
  ,'01'+space(2)+F2_VEND4     AS idVendedor4  
  ,'01'+space(2)+F2_VEND5     AS idVendedor5  
  ,'01'+space(2)+F2_TRANSP    AS idTransportadora  
  ,'01'+space(2)+F2_COND    AS idCondicaoPagamento  
  ,'01'+substring(D2_FILIAL,1,2)+C5_TABELA    AS idTabelaPreco  
  ,'01'+space(2)+F2_REDESP    AS idTransportadoraRedespacho  
  ,'01'+space(2)+D2_CONTA    AS idContaContabil  
  ,'01'+space(2)+D2_CCUSTO    AS idCentroCusto  
  ,'01'+space(2)+D2_CLVL    AS idClasseValor  
  ,'01'+space(2)+D2_ITEMCC    AS idItemContabil  
  ,'01'+space(2)+D2_LOCAL    AS idArmazem    
  ,F2_MOEDA        AS idMoeda    
  ,F2_TXMOEDA        AS TaxaMoeda    
  ,D2_DOC         AS NumeroNotaFiscal    
  ,D2_SERIE        AS Serie    
  ,D2_PEDIDO        AS NumeroPedidoVenda  
  ,D2_UM         AS CodigoUnidadeMedida    
  ,LTRIM(RTRIM(UM.X5_DESCRI))    AS UnidadeMedida    
  ,D2_SEGUM        AS CodigoSegundaUnidadeMedida    
  ,LTRIM(RTRIM(UM2.X5_DESCRI))   AS SegundaUnidadeMedida    
  ,D2_CF         AS CFOP    
  ,LTRIM(RTRIM(CFOP.X5_DESCRI))   AS NaturezaOperacao    
  ,D2_LOCAL        AS Armazem    
  ,case F4_ESTOQUE       when 'S' then 1      else 0 end        AS MovimentaEstoque    
  ,D2_EST         AS UF    
  ,case F2_TPFRETE      when 'C' then 'CIF'    when 'F' then 'FOB'    when 'T' then 'Terceiros'    when 'S' then 'Sem Frete'    else null end       AS TipoFrete    
  ,case F4_DUPLIC    when 'S' then 1    else 0 end        AS GeraDuplicata  
  ,case F4_ESTOQUE    when 'S' then 1    else 0 end        AS AtualizaEstoque  
  ,cast(D2_EMISSAO as date)    AS DataEmissao    
  ,F2_HORA        AS HoraEmissao    
  ,cast(C5_EMISSAO as date)    AS DataPedido    
  ,case    when F2_EMINFE <> ''    then cast(F2_EMINFE as date)    else cast(F2_EMISSAO as date) end  AS DataSaidaNotaFiscal  
  ,D2_QUANT        AS Quantidade   
  ,D2_QTSEGUM           AS QuantidadeSegundaUnidadeMedida  
  ,D2_PRCVEN        AS PrecoUnitario    
  ,D2_TOTAL        AS ValorMercadoria    
  ,D2_VALBRUT        AS ValorFaturamentoTotal    
  ,D2_VALIPI        AS ValorIPI    
  ,D2_VALICM        AS ValorICMS     
  ,D2_ICMSRET        AS ValorICMSRetido    
  ,D2_VALIMP6        AS ValorPIS  
  ,D2_VALIMP5        AS ValorCOFINS  
  ,D2_VALISS        AS ValorISS  
  ,D2_VALIRRF        AS ValorIRRF  
  ,D2_VALINS        AS ValorINSS  
  ,CASE WHEN DFP_DOCDCS IS NOT NULL AND (SELECT SUM(D2_QTSEGUM) FROM SD2010 AS SD2FRETE WHERE SD2FRETE.D2_FILIAL = SD2.D2_FILIAL AND SD2FRETE.D2_DOC = SD2.D2_DOC AND SD2FRETE.D2_SERIE = SD2.D2_SERIE AND SD2FRETE.D_E_L_E_T_ = '') <> 0 THEN    DFP_VALFRE / (SELECT SUM(D2_QTSEGUM) FROM SD2010 AS SD2FRETE WHERE SD2FRETE.D2_FILIAL = SD2.D2_FILIAL AND SD2FRETE.D2_DOC = SD2.D2_DOC AND SD2FRETE.D2_SERIE = SD2.D2_SERIE AND SD2FRETE.D_E_L_E_T_ = '') * SD2.D2_QTSEGUM   ELSE D2_VALFRE END      AS ValorFrete  
  ,D2_DESPESA        AS ValorDespesa  
  ,D2_DESCON        AS ValorDesconto    
  ,D2_PESO*D2_QUANT      AS PesoLiquido    
  ,D2_CUSTO1        AS ValorCustoFaturamento    
  ,D2_PRUNIT        AS PrecoUnitarioLista    
  ,D2_COMIS1        AS ValorComissaoRepresentante1    
  ,D2_COMIS2        AS ValorComissaoRepresentante2    
  ,D2_COMIS3        AS ValorComissaoRepresentante3    
  ,D2_COMIS4        AS ValorComissaoRepresentante4    
  ,D2_COMIS5        AS ValorComissaoRepresentante5   
  from   SD2010 AS SD2  
  join   SF4010 AS SF4  
  ON     F4_FILIAL = space(2) AND F4_CODIGO = D2_TES AND SF4.D_E_L_E_T_ = ''   
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
  left outer join (     SELECT DFP.DFP_FILIAL,DFP.DFP_DOCDCS,DFP_SERDCS,DFP_VALFRE=SUM(DFP_VALFRE) 
                        FROM   DFP010 AS DFP     
                        WHERE  DFP.D_E_L_E_T_ = ''     
                        GROUP BY DFP.DFP_FILIAL,DFP.DFP_DOCDCS,DFP_SERDCS     ) AS DFP  
  ON     DFP.DFP_FILIAL = substring(D2_FILIAL,1,2) AND DFP.DFP_DOCDCS = D2_DOC AND DFP_SERDCS = D2_SERIE   
  WHERE  SD2.D_E_L_E_T_ = ''         AND D2_TIPO    = 'N'      AND F4_DUPLIC  = 'S'       AND F4_PODER3  = 'N'   