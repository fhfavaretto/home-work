create or alter view dimPlanodeContas as
  select   '01'+CT1_FILIAL    AS idEmpresa  
  ,'01'+CT1_FILIAL+CT1_CONTA AS idContaContabil  
  ,CASE WHEN CT1_CTASUP = '' THEN null ELSE '01'+CT1_FILIAL+CT1_CTASUP END AS idContaContabilSuperior  
  ,CT1_CONTA         AS CodigoContaContabil  
  ,LTRIM(RTRIM(CT1_DESC01))     AS ContaContabil 
  ,LTRIM(RTRIM(CT1_DESC02))     AS ContaContabil2  
  ,LTRIM(RTRIM(CT1_DESC03))     AS ContaContabil3  
  ,LTRIM(RTRIM(CT1_DESC04))     AS ContaContabil4  
  ,LTRIM(RTRIM(CT1_DESC05))     AS ContaContabil5  
  ,CASE CT1_NORMAL    WHEN '1' THEN 'Débito'    ELSE 'Crédito' END      AS CondicaoNormal  
  ,CASE CT1_CLASSE    WHEN '1' THEN 'Sintética'    ELSE 'Analítica' END      AS Classe  
  ,CT1_RES         AS CodigoReduzido  
  ,CASE CT1_BLOQ   WHEN '1' THEN 'Bloqueada'   ELSE 'Não Bloqueada' END     AS Bloqueada  
  from   CT1010 AS CT1  
  where  CT1.D_E_L_E_T_ = ''  
  order by CT1_FILIAL,CT1_CONTA        