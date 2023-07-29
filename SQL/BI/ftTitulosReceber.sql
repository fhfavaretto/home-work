create or alter view ftTitulosReceber as
  select   '01'+E1_FILORIG                    AS idEmpresa  
  ,'01'+E1_FILORIG+E1_PREFIXO+E1_NUM+E1_PARCELA            AS idTitulo  
  ,'01'+space(2)+E1_CLIENTE+E1_LOJA    AS idCliente   
  ,'01'+space(2)+E1_NATUREZ       AS idNatureza  
  ,'01'+space(2)+E1_PORTADO+E1_AGEDEP+E1_CONTA  AS idContaBancaria  
  ,CASE WHEN E1_VEND1 <> '' THEN '01'+space(2)+E1_VEND1 ELSE '' END AS idVendedor1  
  ,CASE WHEN E1_VEND2 <> '' THEN '01'+space(2)+E1_VEND2 ELSE '' END AS idVendedor2  
  ,CASE WHEN E1_VEND3 <> '' THEN '01'+space(2)+E1_VEND3 ELSE '' END AS idVendedor3  
  ,CASE WHEN E1_VEND4 <> '' THEN '01'+space(2)+E1_VEND4 ELSE '' END AS idVendedor4  
  ,CASE WHEN E1_VEND5 <> '' THEN '01'+space(2)+E1_VEND5 ELSE '' END AS idVendedor5  
  ,E1_PORTADO                 AS idPortador  
  ,E1_MOEDA     AS idMoeda  
  ,CAST(E1_EMISSAO AS DATE) AS DataEmissao  
  ,CAST(E1_VENCREA AS DATE) AS DataVencimento  
  ,CAST(E1_VENCORI AS DATE) AS DataVencimentoOriginal  
  ,E1_PREFIXO     AS Prefixo  
  ,E1_NUM      AS NumeroTitulo  
  ,E1_PARCELA     AS Parcela  
  ,E1_TIPO     AS CodigoTipoTitulo  
  ,RTRIM(TPT.X5_DESCRI)  AS TipoTitulo  
  ,E1_AGEDEP                  AS AgenciaDepositaria  
  ,E1_CONTA                   AS NumeroConta  
  ,E1_NUMBOR                  AS NumeroBordero  
  ,CAST(E1_DATABOR AS DATE)   AS DataBordero  
  ,RTRIM(FRV_DESCRI)          AS SituacaoCobranca  
  ,E1_STATUS                  AS Status  
  ,CASE E1_FLUXO   WHEN 'N' THEN 'Não'   ELSE 'Sim' END   AS FluxoCaixa  
  ,DATEDIFF(DAY,CAST(E1_EMISSAO AS DATE),CAST(E1_VENCREA AS DATE)) AS PrazoRecebimento  
  ,E1_VALOR     AS ValorReceber  
  ,E1_SALDO     AS SaldoReceber  
  ,E1_COMIS1     AS ValorComissao1  
  ,E1_COMIS2     AS ValorComissao2  
  ,E1_COMIS3     AS ValorComissao3  
  ,E1_COMIS4     AS ValorComissao4  
  ,E1_COMIS5     AS ValorComissao5  
  ,E1_ISS      AS ValorISS  
  ,E1_IRRF        AS ValorIRRF  
  ,E1_INSS        AS ValorINSS  
  ,E1_PIS         AS ValorPIS  
  ,E1_COFINS      AS ValorCOFINS  
  ,E1_CSLL        AS ValorCSLL  
  ,E1_DESCONT     AS ValorDesconto  
  ,E1_MULTA       AS ValorMulta  
  ,E1_CORREC      AS ValorCorrecao  
  ,E1_VALJUR      AS ValorJuros      
  from   SE1010 AS SE1   
  join   SX5010 AS TPT   
  on     X5_FILIAL = space(2) AND X5_TABELA = '05' AND X5_CHAVE = E1_TIPO AND TPT.D_E_L_E_T_ = ''  
  left outer join FRV010 AS FRV   
  on     FRV_FILIAL = space(2) AND FRV_CODIGO = E1_SITUACA AND FRV.D_E_L_E_T_ = ''  
  where  SE1.D_E_L_E_T_ = ''     
