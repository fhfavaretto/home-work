-- QUERY SALDOS A PAGAR NO DIA -- FINANCEIRO
SELECT * 
FROM SE2010 
WHERE E2_SALDO > 0 
AND E2_VENCREA = '20230326' -- COLOCAR DDATABASE PARA CONSIDERAR O QUE VENCERÁ NO DIA
AND SE2010.D_E_L_E_T_ =''
