-- QUERY SALDOS A RECEBER EM ATRASO -- FINANCEIRO
SELECT * 
FROM SE1010 
WHERE E1_SALDO > 0 
AND E1_VENCREA < '20230326' -- COLOCAR VARIAVEL DDATABASE
AND SE1010.D_E_L_E_T_ =''