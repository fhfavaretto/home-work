create or alter view ftEstoqueMensal as
  select    '01'+B9_FILIAL AS idEmpresa  
  ,'01'+B9_FILIAL+B9_COD+B9_LOCAL+B9_DATA        AS idSaldoEstoque  
  ,'01'+space(2)+B9_COD AS idProduto   
  ,'01'+space(2)+B9_LOCAL AS idArmazem  
  ,B1_UM             AS CodigoUnidadeMedida  
  ,RTRIM(UM.X5_DESCRI)         AS UnidadeMedida  
  ,cast(B9_DATA as date)         AS DataSaldoFinal  
  ,cast(dateadd(DAY,1,cast(B9_DATA as date)) as date)  AS DataSaldoInicial  
  ,B9_QINI            AS SaldoEstoque  
  ,B9_VINI1            AS CustoEstoque    
  from   SB9010 as SB9  
  join   SB1010 AS SB1  
  on     B1_FILIAL = space(2) AND B1_COD = B9_COD AND SB1.D_E_L_E_T_ = ''  
  left outer join SX5010 AS UM  
  on     UM.X5_FILIAL = space(2) AND UM.X5_TABELA = '62' AND UM.X5_CHAVE = B1_UM AND UM.D_E_L_E_T_ = ''  
  where  SB9.D_E_L_E_T_ = ''     