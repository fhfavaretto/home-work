create or alter view dimFornecedor as
  select     '01'+A2_FILIAL      AS idEmpresa  
  ,'01'+A2_FILIAL+A2_COD+A2_LOJA  AS idFornecedor  
  ,CASE WHEN A2_NATUREZ = '' THEN null ELSE '01'+space(2)+A2_NATUREZ END AS idNaturezaFinanceira  
  ,LTRIM(RTRIM(A2_COD))        AS CodigoFornecedor 
  ,LTRIM(RTRIM(A2_LOJA))        AS CodigoLoja  
  ,LTRIM(RTRIM(A2_COD))+'-'+LTRIM(RTRIM(A2_LOJA)) AS CodigoFornecedorLoja  
  ,LTRIM(RTRIM(A2_NOME))        AS RazaoSocial  
  ,LTRIM(RTRIM(A2_NREDUZ))       AS NomeFantasia  
  ,case  A2_TIPO   when 'J' then 'Pessoa Jurídica'   when 'F' then 'Pessoa Física'   when 'X' then 'Outros'   else null end          AS TipoPessoa 
  ,case  A2_TPESSOA   when 'CI' then 'Comércio/Indústria'   when 'PF' then 'Pessoa Física'   when 'OS' then 'Prestador de Serviço'   else null end          AS TipoFornecedor  
  ,case A2_CIVIL   when '1' then 'Solteiro(a)'   when '2' then 'Casado(a)'   when '3' then 'Divorciado(a)'   when '4' then 'Viuvo(a)'   when '5' then 'Companheiro(a)'   else null end          AS EstadoCivil  
  ,LTRIM(RTRIM(A2_END))        AS Endereco  
  ,LTRIM(RTRIM(A2_NR_END))       AS NumeroEndereco  
  ,LTRIM(RTRIM(A2_BAIRRO))       AS Bairro  
  ,LTRIM(RTRIM(A2_CEP))        AS CEP  
  ,LTRIM(RTRIM(A2_COD_MUN))       AS CodigoMunicipio 
  ,LTRIM(RTRIM(A2_IBGE))        AS CodigoIBGE 
  ,LTRIM(RTRIM(A2_MUN))        AS Municipio  
  ,LTRIM(RTRIM(A2_EST))        AS CodigoUF  
  ,LTRIM(RTRIM(UF.X5_DESCRI))      AS UF  
  ,LTRIM(RTRIM(A2_CODPAIS))       AS CodigoPais  
  ,LTRIM(RTRIM(A2_DDD))        AS DDD  
  ,LTRIM(RTRIM(A2_TEL))        AS Telefone  
  ,LTRIM(RTRIM(A2_CGC))        AS CNPJ  
  ,LTRIM(RTRIM(A2_INSCR))       AS InscricaoEstadual  
  ,LTRIM(RTRIM(A2_INSCRM))       AS InscricaoMunicipal  
  ,LTRIM(RTRIM(A2_CNAE))        AS CNAE  
  ,LTRIM(RTRIM(A2_NATUREZ))       AS CodigoNatureza  
  ,LTRIM(RTRIM(ED_DESCRIC))       AS NaturezaFinanceira  
  ,A2_PRIOR           AS PrioridadePagamento  
  ,A2_RISCO           AS RiscoCredito  
  ,A2_LC            AS LimiteCredito  
  ,A2_ATIVIDA           AS CodigoAtividade  
  ,case A2_VINCULA    when 2 then 'Com vinculação, sem influência de preço'   when 3 then 'Com vinculação, com influência de preço'   else 'Sem vinculação' end      AS CodigoVinculo  
  ,case A2_TPJ   when '1' then 'ME-Micro-Empresa'   when '2' then 'EPP-Empresa Pequeno Porte'   when '3' then 'MEI-Microempreendedor Individual'   when '4' then 'Cooperativa'   when '5' then 'Não Optante'   else null end          AS TipoPessoaJuridica  
  ,LTRIM(RTRIM(ATV.X5_DESCRI))      AS SegmentoAtividade  
  ,case A2_MSBLQL   when 1 then 0   else 1 end           AS Ativo    
  from   SA2010 AS SA2  
  left outer join SED010 AS SED  
  on     ED_FILIAL = space(2) AND ED_CODIGO = A2_NATUREZ AND SED.D_E_L_E_T_ = ''  
  left outer join SX5010 AS ATV  
  on     ATV.X5_FILIAL = space(2) AND ATV.X5_TABELA = 'T3' AND ATV.X5_CHAVE = A2_SATIV1 AND ATV.D_E_L_E_T_ = ''   
  left outer join SX5010 AS UF  
  on     UF.X5_FILIAL = space(2) AND UF.X5_TABELA = '12' AND UF.X5_CHAVE = A2_EST AND UF.D_E_L_E_T_ = ''   
  where  SA2.D_E_L_E_T_ = ''     
