create or alter view dimVendedor as
  select    '01'+SA3.A3_FILIAL      AS idEmpresa  
  ,'01'+SA3.A3_FILIAL+SA3.A3_COD    AS idVendedor  
  ,CASE WHEN SA3.A3_SUPER = '' THEN null ELSE '01'+SA3.A3_FILIAL+SA3.A3_SUPER END  AS idSupervisor  
  ,CASE WHEN SA3.A3_GEREN = '' THEN null ELSE '01'+SA3.A3_FILIAL+SA3.A3_GEREN END  AS idGerente  
  ,LTRIM(RTRIM(SA3.A3_COD))    AS CodigoVendedor 
  ,LTRIM(RTRIM(SA3.A3_NOME))    AS Vendedor  
  ,LTRIM(RTRIM(SA3.A3_NREDUZ))   AS NomeReduzido  
  ,LTRIM(RTRIM(SA3.A3_CGC))    AS CNPJ  
  ,LTRIM(RTRIM(SA3.A3_MUN))    AS Municipio  
  ,LTRIM(RTRIM(SA3.A3_EST))    AS UF  
  ,case SA3.A3_MSBLQL   when 1 then 0   else 1 end       AS Ativo  
  ,LTRIM(RTRIM(GER.A3_NOME)) AS Gerente  
  ,LTRIM(RTRIM(GER.A3_NREDUZ)) AS NomeReduzidoGerente  
  ,LTRIM(RTRIM(SUP.A3_NOME)) AS Supervisor  
  ,LTRIM(RTRIM(SUP.A3_NREDUZ)) AS NomeReduzidoSupervisor  
  from   SA3010 AS SA3  
  left outer join SA3010 AS GER  
  on GER.A3_FILIAL = SA3.A3_FILIAL AND GER.A3_COD = SA3.A3_GEREN AND GER.D_E_L_E_T_ = ''  
  left outer join SA3010 AS SUP  
  on SUP.A3_FILIAL = SA3.A3_FILIAL AND SUP.A3_COD = SA3.A3_SUPER AND SUP.D_E_L_E_T_ = ''  
  where  SA3.D_E_L_E_T_ = ''      