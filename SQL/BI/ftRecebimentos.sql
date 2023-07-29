create or alter view ftRecebimentos as
  select     '01'+E5_FILORIG AS idEmpresa  
  ,'01'+E5_FILORIG+E1_PREFIXO+E1_NUM+E1_PARCELA     AS idTitulo  
  ,'01'+space(2)+E1_CLIENTE+E1_LOJA    AS idCliente   
  ,'01'+space(2)+E5_NATUREZ       AS idNatureza  
  ,'01'+space(2)+E5_BANCO+E5_AGENCIA+E5_CONTA     AS idContaBancaria  
  ,E1_MOEDA     AS idMoeda  
  ,E5_BANCO     AS idPortador  
  ,E1_PREFIXO     AS Prefixo  
  ,E1_NUM      AS NumeroTitulo  
  ,E1_PARCELA     AS Parcela  
  ,E5_TIPO     AS CodigoTipoTitulo  
  ,E5_TIPODOC     AS CodigoTipoDocumento  
  ,RTRIM(X5_DESCRI)   AS TipoDocumento  
  ,E5_AGENCIA     AS AgenciaDepositaria  
  ,E5_CONTA     AS NumeroConta  
  ,CASE WHEN E5_RECONC = '' THEN 'Não'    ELSE 'Sim' END           AS Conciliado  
  ,CAST(E5_DATA AS DATE)      AS DataMovimento  
  ,CAST(E1_EMISSAO AS DATE)   AS DataEmissao  
  ,CAST(E1_VENCREA AS DATE)   AS DataVencimento  
  ,CAST(E5_DTDISPO AS DATE)   AS DataDisposicao  
  ,E5_VALOR                   AS ValorMovimento  
  ,DATEDIFF(DAY,CAST(E1_EMISSAO AS DATE),CAST(E1_VENCREA AS DATE)) AS PrazoRecebimento  
  ,case when E1_VENCREA < E5_DATA   then DATEDIFF(DAY,CAST(E1_VENCREA AS DATE),CAST(E5_DATA AS DATE))   else 0 end                  AS RecebimentoAtrasado  
  ,case when E1_VENCREA > E5_DATA   then DATEDIFF(DAY,CAST(E5_DATA AS DATE),CAST(E1_VENCREA AS DATE))   else 0 end                  AS RecebimentoAntecipado  
  FROM SE5010 AS SE5  
  JOIN SX5010 AS SX5  
  ON X5_FILIAL = space(2) AND X5_TABELA = '05' AND X5_CHAVE = E5_TIPODOC AND SX5.D_E_L_E_T_ = ''  
  LEFT OUTER join   SE1010 AS SE1   
  on     E1_FILIAL = space(2) and E1_PREFIXO = E5_PREFIXO AND E1_NUM = E5_NUMERO AND E1_PARCELA = E5_PARCELA AND E1_TIPO = E5_TIPO AND E1_CLIENTE = E5_CLIFOR AND E1_LOJA = E5_LOJA and SE1.D_E_L_E_T_ = ''  
  WHERE SE5.E5_RECPAG = 'R' AND SE5.D_E_L_E_T_ = ''   