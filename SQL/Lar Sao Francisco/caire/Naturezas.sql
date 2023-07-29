/* ======================================= CONSIDERE ESTE C�DIGO ================================================================================================================================================================================================================================================== */
SELECT * FROM SE5010 WHERE E5_NATUREZ != (SELECT E1_NATUREZ FROM SE1010 WHERE E5_FILIAL = E1_FILIAL AND E5_PREFIXO = E1_PREFIXO AND E5_NUMERO = E1_NUM AND E5_CLIFOR = E1_CLIENTE AND E5_LOJA = E1_LOJA AND E1_NATUREZ != ' ' AND E5_PARCELA = E1_PARCELA AND E1_TIPO = E5_TIPO AND SE1010.D_E_L_E_T_=' ')
AND E5_FILIAL = '11051' AND E5_DATA BETWEEN '20150101'AND'20151231' AND D_E_L_E_T_=' ' AND E5_NATUREZ != ' ' AND E5_RECPAG = 'R' AND E5_TIPODOC NOT IN ('ES','EC');


UPDATE SE5010 SET E5_NATUREZ = (SELECT E1_NATUREZ FROM SE1010 WHERE E5_FILIAL = E1_FILIAL AND E5_PREFIXO = E1_PREFIXO AND E5_NUMERO = E1_NUM AND E5_CLIFOR = E1_CLIENTE AND E5_LOJA = E1_LOJA AND E1_NATUREZ != ' ' AND E5_PARCELA = E1_PARCELA AND E1_TIPO = E5_TIPO AND SE1010.D_E_L_E_T_=' ') 
WHERE E5_NATUREZ != (SELECT E1_NATUREZ FROM SE1010 WHERE E5_FILIAL = E1_FILIAL AND E5_PREFIXO = E1_PREFIXO AND E5_NUMERO = E1_NUM AND E5_CLIFOR = E1_CLIENTE AND E5_LOJA = E1_LOJA AND E1_NATUREZ != ' ' AND E5_PARCELA = E1_PARCELA AND E1_TIPO = E5_TIPO AND SE1010.D_E_L_E_T_=' ')
AND E5_FILIAL = '11051' AND E5_DATA BETWEEN '20150101'AND'20151231' AND D_E_L_E_T_=' ' AND E5_NATUREZ != ' ' AND E5_RECPAG = 'R' AND E5_TIPODOC NOT IN ('ES','EC');

/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */
/* ================================================================================================================================================================================================================================================================================================================= */

SELECT NT.ED_DESCRIC FROM SED010 NT WHERE NT.D_E_L_E_T_=' ';

SELECT 

MVB.E5_NATUREZ,
CTP.E2_NATUREZ,
(SELECT EV.EV_NATUREZ FROM SEV010 EV WHERE EV.EV_NUM = MVB.E5_NUMERO AND EV.EV_PREFIXO = MVB.E5_PREFIXO AND MVB.E5_FORNECE = EV.EV_CLIFOR AND MVB.E5_LOJA = EV.EV_LOJA AND ROWNUM = 1 )EV_NATUREZ,
(SELECT ED_DESCRIC FROM SED010 WHERE ED_CODIGO = MVB.E5_NATUREZ AND D_E_L_E_T_=' ') ED_NATUREZA

FROM SE5010 MVB 

  LEFT OUTER JOIN SE2010 CTP ON CTP.E2_FILIAL = MVB.E5_FILIAL
    AND CTP.E2_NUM = MVB.E5_NUMERO AND CTP.E2_PARCELA = MVB.E5_PARCELA AND CTP.E2_PREFIXO = MVB.E5_PREFIXO AND CTP.E2_TIPO = MVB.E5_TIPO AND MVB.E5_RECPAG = 'P'
    AND CTP.E2_FORNECE = MVB.E5_FORNECE AND CTP.E2_LOJA = MVB.E5_LOJA AND CTP.D_E_L_E_T_=' '
    
  LEFT OUTER JOIN SE1010 CTR ON CTR.E1_FILIAL = MVB.E5_FILIAL
    AND CTR.E1_NUM = MVB.E5_NUMERO AND CTR.E1_PARCELA = MVB.E5_PARCELA AND CTR.E1_PREFIXO = MVB.E5_PREFIXO AND CTR.E1_TIPO = MVB.E5_TIPO AND MVB.E5_RECPAG = 'R'
    AND CTR.E1_CLIENTE = MVB.E5_CLIENTE AND CTR.E1_LOJA = MVB.E5_LOJA AND CTP.D_E_L_E_T_=' ' ORDER BY MVB.E5_NATUREZ;
    
/* ======================================================= AJUSTE DE NATUREZAS VAZIAS CONTAS A PAGAR =======================================================================================*/    
  UPDATE SE2010 E2 SET E2.E2_NATUREZ = (SELECT EV.EV_NATUREZ FROM SEV010 EV JOIN SE2010 E2 ON EV.EV_FILIAL = E2.E2_FILIAL AND EV.EV_PREFIXO = E2.E2_PREFIXO AND EV.EV_NUM = E2.E2_NUM 
                                            AND EV.EV_PARCELA = E2.E2_PARCELA AND EV.EV_TIPO = E2.E2_TIPO AND EV.D_E_L_E_T_=' ' AND EV.EV_RECPAG = 'P' AND ROWNUM = 1)
  WHERE (E2_NATUREZ IS NULL OR E2_NATUREZ = '          ') AND E2.E2_NUM IN (SELECT EV.EV_NUM FROM SEV010 EV JOIN SE2010 E2 ON EV.EV_FILIAL = E2.E2_FILIAL AND EV.EV_PREFIXO = E2.E2_PREFIXO
                                                                            AND EV.EV_NUM = E2.E2_NUM AND EV.EV_PARCELA = E2.E2_PARCELA AND EV.EV_TIPO = E2.E2_TIPO AND EV.D_E_L_E_T_=' '
                                                                            AND EV.EV_RECPAG = 'P') AND E2.D_E_L_E_T_=' ';
  
/* ========================================================================================================================================================================================*/

  SELECT * FROM SE2010 WHERE (E2_NATUREZ IS NULL OR E2_NATUREZ = '          ') AND D_E_L_E_T_=' ' ORDER BY E2_FILIAL; --VERIFICA SE EXISTE ALGUMA NATUREZA EM BRANCO
  
/* ======================================================= AJUSTE DE NATUREZAS VAZIAS MOVIMENTOS BANCARIOS ================================================================================*/ 

UPDATE SE5010 E5 SET E5.E5_NATUREZ = (SELECT E2.E2_NATUREZ FROM SE2010 E2 JOIN SE5010 E5 ON E5.E5_FILIAL = E2.E2_FILIAL AND E5.E5_PREFIXO = E2.E2_PREFIXO AND E5.E5_NUMERO = E2.E2_NUM 
                                            AND E2.D_E_L_E_T_=' ' AND E5.E5_RECPAG = 'P' AND ROWNUM = 1) 
WHERE (E5_NATUREZ IS NULL OR E5_NATUREZ = '          ') AND E5.E5_RECPAG = 'P' ;

/* ========================================================================================================================================================================================*/

  SELECT * FROM SE5010 WHERE (E5_NATUREZ IS NULL OR E5_NATUREZ = '          ') AND D_E_L_E_T_=' ' AND E5_RECPAG = 'P'; --VERIFICA SE EXISTE ALGUMA NATUREZA EM BRANCO
  
  
  /* ======================================================= AJUSTE DE NATUREZAS VAZIAS MOVIMENTOS BANCARIOS RECEBER ================================================================================*/ 

UPDATE SE5010 E5 SET E5.E5_NATUREZ = (SELECT E1.E1_NATUREZ FROM SE1010 E1 JOIN SE5010 E5 ON E5.E5_FILIAL = E1.E1_FILIAL AND E5.E5_PREFIXO = E1.E1_PREFIXO AND E5.E5_NUMERO = E1.E1_NUM 
                                            AND E1.D_E_L_E_T_=' ' AND E5.E5_RECPAG = 'R' AND ROWNUM = 1) 
WHERE (E5_NATUREZ IS NULL OR E5_NATUREZ = '          ') AND E5.E5_RECPAG = 'R';

/* ========================================================================================================================================================================================*/

  SELECT * FROM SE5010 WHERE (E5_NATUREZ IS NULL OR E5_NATUREZ = '          ') AND D_E_L_E_T_=' ' AND E5_RECPAG = 'R'; --VERIFICA SE EXISTE ALGUMA NATUREZA EM BRANCO
  
 /* ======================================================= AJUSTE DE NATUREZAS VAZIAS MOVIMENTOS BANCARIOS CHEQUES ================================================================================*/ 
 
 UPDATE SE5010 E5 SET E5.E5_NATUREZ = (SELECT EF.EF_NATUR FROM SEF010 EF JOIN SE5010 E5 ON EF.EF_NUM = E5.E5_NUMCHEQ AND EF.EF_FILIAL = E5.E5_FILIAL AND ROWNUM = 1 AND EF.EF_NUM != 'NTCHEST   ') WHERE E5.E5_NUMCHEQ !='         ' AND E5.E5_NATUREZ='          ' AND E5.E5_NUMCHEQ IN (SELECT EF.EF_NUM FROM SEF010 EF JOIN SE5010 E5 ON EF.EF_NUM = E5.E5_NUMCHEQ AND EF.EF_FILIAL = E5.E5_FILIAL); 
 SELECT * FROM SEF010 WHERE EF_NATUR != '          ';
 
 
 SELECT * FROM SE5010 WHERE D_E_L_E_T_=' ' AND E5_NATUREZ = ' ' ;--AND E5_NUMCHEQ != '         ';
 
 --UPDATE SE5010 SET E5_NATUREZ = ' ' WHERE D_E_L_E_T_=' ' AND E5_NATUREZ = 'NTCHEST   ';
 
SELECT EF.EF_NUM,E5.E5_NUMCHEQ,EF.EF_NUMNOTA,E5.E5_NUMERO, EF.EF_NATUR, E5_NATUREZ FROM SEF010 EF JOIN SE5010 E5 ON EF.EF_NUM = E5.E5_NUMCHEQ AND EF.EF_NUM != '         ' AND EF.D_E_L_E_T_=' ' AND EF.EF_NATUR != '          ' AND E5.D_E_L_E_T_=' ' AND E5.E5_NATUREZ='          ';

