create or alter view dimProduto as
  select    '01'+B1_FILIAL    AS idEmpresa  
  ,'01'+B1_FILIAL+B1_COD  AS idProduto   
  ,'01'+B1_FILIAL+B1_LOCPAD AS idArmazem  
  ,LTRIM(RTRIM(B1_COD))      AS CodigoProduto  
  ,LTRIM(RTRIM(B1_DESC))      AS Produto 
  ,LTRIM(RTRIM(B1_GRUPO))      AS CodigoGrupo  
  ,LTRIM(RTRIM(BM_DESC))      AS GrupoProduto  
  ,LTRIM(RTRIM(B1_POSIPI))     AS NCM  
  ,LTRIM(RTRIM(B1_TIPO))      AS CodigoTipoProduto  
  ,LTRIM(RTRIM(TPR.X5_DESCRI))    AS TipoProduto  
  ,LTRIM(RTRIM(B1_LOCPAD))     AS ArmazemPadrao  
  ,LTRIM(RTRIM(B1_UM))      AS CodigoUnidadeMedida  
  ,LTRIM(RTRIM(UM1.X5_DESCRI))    AS UnidadeMedida  
  ,LTRIM(RTRIM(B1_SEGUM))      AS CodigoSegundaUnidadeMedida
  ,LTRIM(RTRIM(UM2.X5_DESCRI))    AS SegundaUnidadeMedida  
  ,case B1_TIPCONV   when 'D' then 'Divisor'   when 'M' then 'Multiplicador'   else null end        AS TipoConversao  
  ,B1_CONV         AS FatorConversao  
  ,LTRIM(RTRIM(B1_SITPROD))     AS CodigoSituacaoProduto  
  ,LTRIM(RTRIM(SIT.X5_DESCRI))    AS SituacaoProduto  
  ,case B1_RASTRO   when 'S' then 'Sub-Lote'   when 'L' then 'Lote'   else 'Não controla' end     AS ControlaRastreabilidade  
  ,LTRIM(RTRIM(B1_FABRIC))     AS Fabricante  
  ,LTRIM(RTRIM(B1_CODBAR))     AS CodigoBarra  
  ,LTRIM(RTRIM(B1_ORIGEM))     AS CodigoOrigem  
  ,LTRIM(RTRIM(ORI.X5_DESCRI))    AS Origem  
  ,case B1_MRP   when 'N' then 0   else 1 end         AS ControlaMRP  
  ,case B1_LOCALIZ   when 'S' then 1   else 0 end         AS ControlaEnderecamento  
  ,CASE WHEN    (SELECT TOP 1 G1_COD FROM SG1010 AS SG1 WHERE G1_FILIAL = space(2) AND G1_COD = B1_COD AND SG1.D_E_L_E_T_ = '') IS NOT NULL   THEN 'Sim'    ELSE 'Não' END       AS ItemFabricado  
  ,CASE WHEN    (SELECT TOP 1 C7_PRODUTO FROM SC7010 AS SC7 WHERE C7_FILIAL = substring(B1_FILIAL,1,2) AND C7_PRODUTO = B1_COD AND SC7.D_E_L_E_T_ = '') IS NOT NULL   THEN 'Sim'    ELSE 'Não' END       AS ItemComprado  
  ,B1_QE          AS QuantidadeEmbalagem  
  ,B1_EMIN         AS PontoPedido  
  ,B1_ESTSEG         AS EstoqueSeguranca  
  ,B1_LE          AS LoteEconomico  
  ,B1_LM          AS LoteMinimo  
  ,B1_QB          AS BaseEstrutura  
  ,B1_EMAX         AS EstoqueMaximo  
  ,B1_CUSTD         AS CustoStandard  
  ,B1_PESO         AS PesoLiquido  
  ,B1_PESBRU         AS PesoBruto  
  ,case B1_CLASSVE   when '1' then 'Normal'   when '2' then 'Promoção'   when '3' then 'Descarte'   when '4' then 'Eliminado'   else null end        AS ClassificacaoVenda  
  ,case B1_MSBLQL   when 1 then 0   else 1 end         AS Ativo  
  ,B1_CODFAM AS CodigoFamilia  ,RTRIM(FAM.X5_DESCRI) AS FamiliaProduto    
  from   SB1010 AS SB1   
  left outer join   SBM010 AS SBM  
  on     BM_FILIAL = space(2) AND BM_GRUPO = B1_GRUPO AND SBM.D_E_L_E_T_ = ''  
  left outer join SX5010 AS TPR  
  on     TPR.X5_FILIAL = space(2) AND TPR.X5_TABELA = '02' AND TPR.X5_CHAVE = B1_TIPO AND TPR.D_E_L_E_T_ = ''   
  left outer join SX5010 AS UM1  
  on     UM1.X5_FILIAL = space(2) AND UM1.X5_TABELA = '62' AND UM1.X5_CHAVE = B1_UM AND UM1.D_E_L_E_T_ = ''   
  left outer join SX5010 AS UM2  
  on     UM2.X5_FILIAL = space(2) AND UM2.X5_TABELA = '62' AND UM2.X5_CHAVE = B1_SEGUM AND UM2.D_E_L_E_T_ = ''  
  left outer join SX5010 AS SIT  
  on     SIT.X5_FILIAL = space(2) AND SIT.X5_TABELA = 'T2' AND SIT.X5_CHAVE = B1_SITPROD AND SIT.D_E_L_E_T_ = ''  
  left outer join SX5010 AS ORI  
  on     ORI.X5_FILIAL = space(2) AND ORI.X5_TABELA = 'S0' AND ORI.X5_CHAVE = B1_ORIGEM AND ORI.D_E_L_E_T_ = ''  
  left outer join SX5010 AS FAM  
  on     FAM.X5_FILIAL = space(2) AND FAM.X5_TABELA = 'Z2' AND FAM.X5_CHAVE = B1_CODFAM AND FAM.D_E_L_E_T_ = ''  
  where SB1.D_E_L_E_T_ = ''     