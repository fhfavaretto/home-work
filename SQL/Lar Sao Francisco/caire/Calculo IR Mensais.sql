SELECT RA.RA_FILIAL,RA.RA_MAT,RC.RC_PD,SUM(CASE  WHEN RC_PD IN ('403','405','427','495','500') THEN
                                          RC_VALOR
                                        ELSE
                                          RC_VALOR * (-1)
                                        END) AS TOTAL_IR,
RA.RA_NOMECMP,TO_DATE(RC.RC_DATA,'YYYYMMDD')DATA, SUBSTR(RC.RC_DATA,5,2)||'/'||SUBSTR(RC.RC_DATA,1,4) MES_ANO, RA.RA_CC||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = RA.RA_CC AND CTT010.D_E_L_E_T_=' ') CENTRO_CUSTO,
SUBSTR(RA.RA_CC,1,5)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
SUBSTR(RA.RA_CC,1,8)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC, 'RC' TABELA
FROM SRC010 RC JOIN SRA010 RA ON RA.RA_MAT = RC.RC_MAT AND RA.RA_FILIAL = RC.RC_FILIAL AND RA.D_E_L_E_T_=' ' WHERE RC.D_E_L_E_T_=' ' 
AND RC.RC_PD IN ('403','405','427','495','500','360')
AND RC.RC_DATA BETWEEN :DATA_INICIO AND :DATA_FINAL AND RC.RC_MAT < '900000' AND RA.RA_AFASFGT <> '5'
GROUP BY RA.RA_FILIAL,RA.RA_MAT,RA.RA_NOMECMP,RA.RA_CC,RC.RC_DATA,RC.RC_PD
UNION
SELECT RA.RA_FILIAL,RA.RA_MAT,RD.RD_PD,SUM(CASE  WHEN RD_PD IN ('403','405','427','495','500') THEN
                                          RD_VALOR
                                        ELSE
                                          RD_VALOR * (-1)
                                        END) AS TOTAL_IR,
RA.RA_NOMECMP,TO_DATE(RD.RD_DATPGT,'YYYYMMDD')DATA, SUBSTR(RD.RD_DATPGT,5,2)||'/'||SUBSTR(RD.RD_DATPGT,1,4) MES_ANO, RA.RA_CC||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = RA.RA_CC AND CTT010.D_E_L_E_T_=' ') CENTRO_CUSTO,
SUBSTR(RA.RA_CC,1,5)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
SUBSTR(RA.RA_CC,1,8)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC, 'RD' TABELA
FROM SRD010 RD JOIN SRA010 RA ON RA.RA_MAT = RD.RD_MAT AND RA.RA_FILIAL = RD.RD_FILIAL AND RA.D_E_L_E_T_=' ' 
WHERE RD.D_E_L_E_T_=' ' AND RD.RD_PD IN ('403','405','427','495','500','360')
AND RD.RD_DATPGT BETWEEN :DATA_INICIO AND :DATA_FINAL AND RD.RD_MAT < '900000' 

GROUP BY RA.RA_FILIAL,RA.RA_MAT,RA.RA_NOMECMP,RA.RA_CC,RD.RD_DATPGT,RD.RD_PD
UNION
SELECT RA.RA_FILIAL,RA.RA_MAT,RR.RR_PD,SUM(CASE  WHEN RR_PD IN ('403','405','427','495','500') THEN
                                          RR_VALOR
                                        ELSE
                                          RR_VALOR * (-1)
                                        END) AS TOTAL_IR,
RA.RA_NOMECMP,TO_DATE(RR.RR_DATAPAG,'YYYYMMDD')DATA, SUBSTR(RR.RR_DATAPAG,5,2)||'/'||SUBSTR(RR.RR_DATAPAG,1,4) MES_ANO, RA.RA_CC||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = RA.RA_CC AND CTT010.D_E_L_E_T_=' ') CENTRO_CUSTO,
SUBSTR(RA.RA_CC,1,5)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
SUBSTR(RA.RA_CC,1,8)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC, 'RR' TABELA
FROM SRR010 RR JOIN SRA010 RA ON RA.RA_MAT = RR.RR_MAT AND RA.RA_FILIAL = RR.RR_FILIAL AND RA.D_E_L_E_T_=' ' WHERE RR.D_E_L_E_T_=' ' 
AND RR.RR_PD IN ('403','405','427','495','500','360')
AND RR.RR_DATAPAG BETWEEN :DATA_INICIO AND :DATA_FINAL AND RR.RR_MAT < '900000' AND RA.RA_AFASFGT NOT IN (/*'5',*/' ') AND RR.RR_TIPO3 = 'R'
AND (RR.RR_MAT NOT IN ('006543') AND RR.RR_DATAPAG = '20160125')
AND RR.RR_MAT NOT IN 
		(SELECT RD.RD_MAT FROM SRD010 RD WHERE RA.RA_MAT = RD.RD_MAT AND RA.RA_FILIAL = RD.RD_FILIAL AND RD.D_E_L_E_T_=' ' 
		AND RD.RD_PD IN ('403','405','427','495','500','360')
		AND RD.RD_DATPGT BETWEEN :DATA_INICIO AND :DATA_FINAL AND RD.RD_MAT < '900000')
GROUP BY RA.RA_FILIAL,RA.RA_MAT,RA.RA_NOMECMP,RA.RA_CC, RR.RR_DATAPAG,RR.RR_PD
UNION
SELECT RA.RA_FILIAL,RA.RA_MAT,RR.RR_PD,SUM(CASE  WHEN RR_PD IN ('403','405','427','495','500') THEN
                                          RR_VALOR
                                        ELSE
                                          RR_VALOR * (-1)
                                        END) AS TOTAL_IR,
RA.RA_NOMECMP,TO_DATE(RR.RR_DATA,'YYYYMMDD')DATA, SUBSTR(RR.RR_DATA,5,2)||'/'||SUBSTR(RR.RR_DATA,1,4) MES_ANO, RA.RA_CC||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = RA.RA_CC AND CTT010.D_E_L_E_T_=' ') CENTRO_CUSTO,
SUBSTR(RA.RA_CC,1,5)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,5)||'       ' AND CTT010.D_E_L_E_T_=' ') LOCAL_CC,
SUBSTR(RA.RA_CC,1,8)||'-'||(SELECT CTT_DESC01 FROM CTT010 WHERE CTT_CUSTO = SUBSTR(RA.RA_CC,1,8)||'    ' AND CTT010.D_E_L_E_T_=' ') DEPTO_CC, 'RF' TABELA
FROM SRR010 RR JOIN SRA010 RA ON RA.RA_MAT = RR.RR_MAT AND RA.RA_FILIAL = RR.RR_FILIAL AND RA.D_E_L_E_T_=' ' 
WHERE RR.D_E_L_E_T_=' ' AND RR.RR_PD IN ('403','405','427','495','500','360')
AND RR.RR_DATA BETWEEN :DATA_INICIO AND :DATA_FINAL AND RR.RR_MAT < '900000' AND RA.RA_AFASFGT NOT IN('F') AND RR.RR_TIPO3 = 'F' 
AND RR.RR_MAT NOT IN 
		(SELECT RD.RD_MAT FROM SRD010 RD WHERE RA.RA_MAT = RD.RD_MAT AND RA.RA_FILIAL = RD.RD_FILIAL AND RD.D_E_L_E_T_=' ' 
		AND RD.RD_PD IN ('495')
		AND RD.RD_DATPGT BETWEEN :DATA_INICIO AND :DATA_FINAL AND RD.RD_MAT < '900000')
		
AND RR.RR_MAT NOT IN (SELECT RE_MATD FROM SRE010 WHERE SRE010.D_E_L_E_T_=' ' AND (RE_FILIALP = RR.RR_FILIAL OR RE_FILIALD = RR.RR_FILIAL))
AND RR.RR_MAT NOT IN (SELECT RE_MATP FROM SRE010 WHERE SRE010.D_E_L_E_T_=' ' AND (RE_FILIALP = RR.RR_FILIAL OR RE_FILIALD = RR.RR_FILIAL))

GROUP BY RA.RA_FILIAL,RA.RA_MAT,RA.RA_NOMECMP,RA.RA_CC, RR.RR_DATA,RR.RR_PD
ORDER BY 1, 5, 6, 7
