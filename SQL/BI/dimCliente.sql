create or alter view dimCliente as
  select    '01'+A1_FILIAL     AS idEmpresa  
  ,'01'+A1_FILIAL+A1_COD+A1_LOJA AS idCliente  
  ,CASE WHEN A1_VEND    = '' THEN null ELSE '01'+space(2)+A1_VEND END  AS idVendedor  
  ,CASE WHEN A1_NATUREZ = '' THEN null ELSE '01'+space(2)+A1_NATUREZ END  AS idNaturezaFinanceira  
  ,CASE WHEN A1_GRPVEN  = '' THEN null ELSE '01'+space(2)+A1_GRPVEN END  AS idGrupoVenda  
  ,LTRIM(RTRIM(A1_COD))        AS CodigoCliente  
  ,LTRIM(RTRIM(A1_LOJA))        AS CodigoLoja  
  ,LTRIM(RTRIM(A1_COD))+'-'+LTRIM(RTRIM(A1_LOJA)) AS CodigoClienteLoja  
  ,LTRIM(RTRIM(A1_NOME))        AS RazaoSocial  
  ,LTRIM(RTRIM(A1_NREDUZ))       AS NomeFantasia  
  ,case A1_PESSOA    when 'J' then 'Pessoa Jurídica'   when 'F' then 'Pessoa Física'   else null end          AS TipoPessoa  
  ,case A1_TIPO     when 'F' then 'Consumidor Final'   when 'L' then 'Produtor Rural'   when 'R' then 'Revendedor'   when 'S' then 'Solidário'   when 'X' then 'Exportação'   else null end          AS TipoCliente  
  ,LTRIM(RTRIM(A1_END))        AS Endereco  
  ,LTRIM(RTRIM(A1_BAIRRO))       AS Bairro  
  ,LTRIM(RTRIM(A1_CEP))        AS CEP  
  ,LTRIM(RTRIM(A1_COD_MUN))       AS CodigoMunicipio  
  ,LTRIM(RTRIM(A1_MUN))        AS Municipio  
  ,LTRIM(RTRIM(A1_EST))        AS CodigoUF 
  ,LTRIM(RTRIM(UF.X5_DESCRI))      AS UF  
  ,LTRIM(RTRIM(A1_CODPAIS))       AS CodigoPais  
  ,LTRIM(RTRIM(A1_REGIAO))       AS CodigoRegiao  
  ,LTRIM(RTRIM(REG.X5_DESCRI))      AS Regiao  
  ,LTRIM(RTRIM(A1_DDD))        AS DDD  
  ,LTRIM(RTRIM(A1_TEL))        AS Telefone  
  ,LTRIM(RTRIM(A1_CGC))        AS CNPJ 
  ,LTRIM(RTRIM(A1_INSCR))       AS InscricaoEstadual  
  ,LTRIM(RTRIM(A1_INSCRM))       AS InscricaoMunicipal  
  ,LTRIM(RTRIM(A1_CNAE))        AS CNAE  
  ,LTRIM(RTRIM(A1_NATUREZ))       AS CodigoNaturezaFinanceira  
  ,LTRIM(RTRIM(ED_DESCRIC))       AS NaturezaFinanceira  
  ,LTRIM(RTRIM(A1_VEND))        AS CodigoVendedor  
  ,LTRIM(RTRIM(A3_NOME))        AS Vendedor  
  ,LTRIM(RTRIM(A1_GRPVEN))       AS CodigoGrupoVenda  
  ,LTRIM(RTRIM(ACY_DESCRI))       AS GrupoVenda  
  ,A1_RISCO           AS RiscoCredito
  ,A1_LC            AS LimiteCredito  
  ,case A1_MOEDALC   when 1 then 'Real'   when 2 then 'Dolar'   when 3 then 'Ufir'   when 4 then 'Euro'   when 5 then 'Iene'   else 'Outras Moedas' end       AS MoedaLimiteCredito  
  ,case A1_VENCLC   when '' then null    else CAST(A1_VENCLC AS DATE)    end             AS VencimentoLimiteCredito  
  ,case A1_DTNASC   when '' then null    else CAST(A1_DTNASC AS DATE)    end            AS DataNascimento  
  ,case A1_DTCAD   when '' then null   else CAST(A1_DTCAD AS DATE)   end            AS DataCadastro  
  ,case A1_MSBLQL   when 1 then 0   else 1 end           AS Ativo  
  ,A1_SEG2 AS Segmento  
  from   SA1010 AS SA1    
  left outer join SA3010 AS SA3  
  on     A3_FILIAL = space(2) AND A3_COD = A1_VEND AND SA3.D_E_L_E_T_ = ''  
  left outer join SED010 AS SED  
  on     ED_FILIAL = space(2) AND ED_CODIGO = A1_NATUREZ AND SED.D_E_L_E_T_ = ''  
  left outer join ACY010 AS ACY  
  on     ACY_FILIAL = space(2) AND ACY_GRPVEN = A1_GRPVEN AND ACY.D_E_L_E_T_ = ''   
  left outer join SX5010 AS UF  
  on     UF.X5_FILIAL = space(2) AND UF.X5_TABELA = '12' AND UF.X5_CHAVE = A1_EST AND UF.D_E_L_E_T_ = ''   
  left outer join SX5010 AS REG  
  on     REG.X5_FILIAL = space(2) AND REG.X5_TABELA = 'A2' AND REG.X5_CHAVE = A1_REGIAO AND REG.D_E_L_E_T_ = ''   
  where  SA1.D_E_L_E_T_ = ''     