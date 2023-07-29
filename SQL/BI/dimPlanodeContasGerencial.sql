create or alter view dimPlanodeContasGerencial as
  select     '01'+CVE_FILIAL as idEmpresa  
  ,'01'+CVE_FILIAL+CVE_CODIGO as idPlanoGerencial  
  ,'01'+CVE_FILIAL+CVF_CONTAG as idContaGerencial  
  ,case CVF_CTASUP when '' then '' else '01'+CVF_FILIAL+CVF_CTASUP end as idContaGerencialSuperior  
  ,case CT1_CONTA  when '' then '' else '01'+CT1_FILIAL+CT1_CONTA  end as idContaContabil  
  ,case CTS_CTTINI when '' then '' else '01'+space(2)+CTS_CTTINI end as idCentrodeCustoInicial   
  ,case CTS_CTTFIM when '' then '' else '01'+space(2)+CTS_CTTFIM end as idCentrodeCustoFinal  
  ,case CTS_CTDINI when '' then '' else '01'+space(2)+CTS_CTDINI end as idItemContabilInicial  
  ,case CTS_CTDFIM when '' then '' else '01'+space(2)+CTS_CTDFIM end as idItemContabilFinal  
  ,case CTS_CTHINI when '' then '' else '01'+space(2)+CTS_CTHINI end as idClassedeValorInicial  
  ,case CTS_CTHFIM when '' then '' else '01'+space(2)+CTS_CTHFIM end as idClassedeValorFinal    
  ,CVE_CODIGO as CodigoPlanoGerencial  
  ,CVE_DESCRI as PlanoGerencial  
  ,CVF_ORDEM  as Ordem  
  ,CVF_CONTAG as CodigoContaGerencial  
  ,RTRIM(CVF_DESCCG) as ContaGerencial  
  ,case CVF_CLASSE when '1' then 'Sintética' else 'Analítica' end as Classe  
  ,case CVF_NORMAL when '1' then 'Débito'    else 'Crédito'   end as CondicaoNormal  
  ,case CTS_IDENT  when '1' then 'Somar'     when '2' then 'Subtrair' when '3' then 'Subtotal' else null end as Operacao    
  FROM   CVE010 AS VISAOGER   
  LEFT OUTER JOIN   CTS010 AS ENTIDADEGER  
  ON     CTS_FILIAL = substring(CTS_FILIAL,1,2) AND CTS_CODPLA = CVE_CODIGO AND ENTIDADEGER.D_E_L_E_T_ = '' AND CTS_TPSALD in ('1',' ')  
  LEFT OUTER JOIN   CVF010 AS ITEMGER  
  ON     CVF_FILIAL = substring(CTS_FILIAL,1,2) AND CVF_CODIGO = CVE_CODIGO AND CVF_CONTAG = CTS_CONTAG AND ITEMGER.D_E_L_E_T_ = ''  
  LEFT OUTER JOIN   CT1010 AS PLANOCTA  
  ON     CT1_FILIAL = space(2) AND CTS_CT1INI <> '' AND CTS_CT1FIM <> '' AND CT1_CONTA >= CTS_CT1INI AND CT1_CONTA <= CTS_CT1FIM AND PLANOCTA.D_E_L_E_T_ = ''  
  WHERE    VISAOGER.D_E_L_E_T_ = ''   
  order by CVF_FILIAL,CVF_CODIGO,CVF_ORDEM        