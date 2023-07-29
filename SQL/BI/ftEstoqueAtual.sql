create or alter view ftEstoqueAtual as
  SELECT   '01'+B2_FILIAL   AS idEmpresa  
  ,'01'+space(2)+B2_COD   AS idProduto  
  ,'01'+space(2)+B2_LOCAL AS idArmazem  
  ,B2_QATU  AS SaldoAtual  
  ,B2_VATU1 AS CustoAtual  
  ,CASE WHEN B1_TIPCONV = 'M' THEN B2_QATU * B1_CONV        WHEN B1_TIPCONV = 'D' AND B1_CONV <> 0 THEN B2_QATU / B1_CONV      ELSE 0 END AS SaldoAtualSegundaUnidadeMedida  
  FROM   SB2010 AS SB2 (NOLOCK)  
  JOIN   SB1010 AS SB1 (NOLOCK)  
  ON     B1_FILIAL = space(2) AND B1_COD = B2_COD AND SB1.D_E_L_E_T_ = ''  
  WHERE  SB2.D_E_L_E_T_ = ''  
