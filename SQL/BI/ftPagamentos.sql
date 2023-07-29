create or alter view ftPagamentos as
  SELECT    '01'+FK5_FILORI AS idEmpresa  
  ,'01'+FK5_FILORI+E2_PREFIXO+E2_NUM+E2_PARCELA  AS idTitulo  
  ,'01'+space(2)+E2_FORNECE+E2_LOJA AS idFornecedor  
  ,'01'+space(2)+FK5_NATURE    AS idNatureza  
  ,'01'+space(2)+FK5_BANCO+FK5_AGENCI+FK5_CONTA   AS idContaBancaria  
  ,E2_MOEDA    AS idMoeda  
  ,FK5_BANCO           AS idPortador  
  ,E2_PREFIXO    AS Prefixo  
  ,E2_NUM     AS NumeroTitulo  
  ,E2_PARCELA    AS Parcela  
  ,E2_TIPO    AS CodigoTipoTitulo  
  ,RTRIM(FKB_DESCR)    AS TipoTitulo  
  ,FK5_AGENCI          AS AgenciaDepositaria  
  ,FK5_CONTA           AS NumeroConta  
  ,CASE WHEN FK5_DTCONC = '' THEN 'Não'   ELSE 'Sim' END            AS Conciliado  
  ,CAST(FK5_DATA AS DATE)     AS DataMovimento  
  ,CAST(E2_EMISSAO AS DATE) AS DataEmissao  
  ,CAST(E2_VENCREA AS DATE) AS DataVencimento  
  ,CAST(FK5_DTDISP AS DATE)   AS DataDisposicao  
  ,CAST(FK5_DTCONC AS DATE)   AS DataConciliacao  
  ,FK5_VALOR                  AS ValorMovimento  
  ,DATEDIFF(DAY,CAST(E2_EMISSAO AS DATE),CAST(E2_VENCREA AS DATE)) AS PrazoPagamento  
  ,case when E2_VENCREA < FK5_DATA   then DATEDIFF(DAY,CAST(E2_VENCREA AS DATE),CAST(FK5_DATA AS DATE))   else 0 end                                       AS PagamentoAtrasado  
  ,case when E2_VENCREA > FK5_DATA   then DATEDIFF(DAY,CAST(FK5_DATA AS DATE),CAST(E2_VENCREA AS DATE))   else 0 end                                       AS PagamentoAntecipado  
  FROM   FK5010 as FK5  
  JOIN   FKA010 AS FKAFK5   
  ON     FKAFK5.FKA_FILIAL = space(2) AND FKAFK5.FKA_TABORI = 'FK5' AND FKAFK5.FKA_IDORIG = FK5_IDMOV AND FKAFK5.D_E_L_E_T_ = ''  
  JOIN   FKA010 AS FKAFK2   
  ON     FKAFK2.FKA_FILIAL = space(2) AND FKAFK2.FKA_TABORI = 'FK2' AND FKAFK2.FKA_IDPROC = FKAFK5.FKA_IDPROC AND FKAFK2.D_E_L_E_T_ = ''  
  JOIN   FK2010 AS FK2  
  ON     FK2_FILIAL = space(2) AND FK2_IDFK2 = FKAFK2.FKA_IDORIG AND FK2.D_E_L_E_T_ = ''  
  JOIN   FK7010 AS FK7  
  ON     FK7_FILIAL = space(2) AND FK7_IDDOC = FK2_IDDOC AND FK7.D_E_L_E_T_ = ''  
  JOIN   SE2010 AS SE2   
  ON     E2_FILIAL = space(2) AND FK7_ALIAS = 'SE2' AND FK7_CHAVE = E2_FILIAL+'|'+E2_PREFIXO+'|'+E2_NUM+'|'+E2_PARCELA+'|'+E2_TIPO+'|'+E2_FORNECE+'|'+E2_LOJA AND SE2.D_E_L_E_T_ = ''  
  LEFT OUTER JOIN FKB010 AS FKB   
  ON     FKB_FILIAL = space(2) AND FKB_TPDOC = FK5_TPDOC AND FKB.D_E_L_E_T_ = ''  
  WHERE  FK5.D_E_L_E_T_ = ''  AND FK5_RECPAG = 'P'  AND FK5_MOEDA = '01'  AND FK5_TPDOC <> 'ES'  AND FK2_MOTBX NOT IN ('CMP','DAC')  AND FK2_TPDOC <> 'ES'  
