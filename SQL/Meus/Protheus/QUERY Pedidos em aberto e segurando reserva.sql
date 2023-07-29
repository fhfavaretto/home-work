SELECT SC6.C6_FILIAL, SC6.C6_NUM,SC6.C6_ITEM,
SUBSTRING(SC5.C5_EMISSAO,7,2) + '/' + SUBSTRING(SC5.C5_EMISSAO,5,2) + '/' + SUBSTRING(SC5.C5_EMISSAO,1,4) EMISSAO_PED,
SC6.C6_PRODUTO, SUM(SC6.C6_QTDEMP) EMPENHO, SUM(SC6.C6_QTDRESE) RESERVA,
SUM(SC6.C6_QTDRESE)+SUM(SC6.C6_QTDEMP) SOMAC6, SB2.B2_RESERVA, SB2.B2_QEMP, SB2.B2_QATU, ((SUM(SC6.C6_QTDRESE)+SUM(SC6.C6_QTDEMP))-(SB2.B2_RESERVA+SB2.B2_QEMP)) DIF,SB2.B2_LOCAL,

SUBSTRING(C5_USERLGI, 3, 1)+SUBSTRING(C5_USERLGI, 7, 1)+
SUBSTRING(C5_USERLGI, 11,1)+SUBSTRING(C5_USERLGI, 15,1)+
SUBSTRING(C5_USERLGI, 2, 1)+SUBSTRING(C5_USERLGI, 6, 1)+
SUBSTRING(C5_USERLGI, 10,1)+SUBSTRING(C5_USERLGI, 14,1)+
SUBSTRING(C5_USERLGI, 1, 1)+SUBSTRING(C5_USERLGI, 5, 1)+
SUBSTRING(C5_USERLGI, 9, 1)+SUBSTRING(C5_USERLGI, 13,1)+
SUBSTRING(C5_USERLGI, 17,1)+SUBSTRING(C5_USERLGI, 4, 1)+
SUBSTRING(C5_USERLGI, 8, 1) C5_USERLGI


FROM SC6010 SC6 with(nolock)
INNER JOIN SC5010 SC5 with(nolock) 
ON 1=1 AND SC6.C6_FILIAL = SC5.C5_FILIAL AND SC5.C5_NUM = SC6.C6_NUM
INNER JOIN SB2010 SB2 with(nolock) 
ON SB2.B2_FILIAL = SC6.C6_FILIAL AND SB2.B2_COD = SC6.C6_PRODUTO AND SB2.B2_LOCAL = SC6.C6_LOCAL
INNER JOIN SF4010 SF4 with(nolock)
ON SUBSTRING(SC6.C6_FILIAL,1,2) = SF4.F4_FILIAL AND SC6.C6_TES = SF4.F4_CODIGO
WHERE SC5.C5_EMISSAO <= '20221231'
AND SC6.C6_NOTA = ''  
AND SC5.C5_NOTA = ''
AND SC5.D_E_L_E_T_ = ''
AND SC6.D_E_L_E_T_ = ''
AND SB2.D_E_L_E_T_ = ''
AND SF4.D_E_L_E_T_ = ''
--AND SUBSTRING(SC6.C6_FILIAL,1,2) = '13'
AND SF4.F4_ESTOQUE = 'S'
--AND SC6.C6_PRODUTO = '0024300'
AND SC6.C6_LOCAL = '01'  
--AND SC6.C6_RESERVA <> ''
--AND SB2.B2_QATU >0
--AND SB2.B2_RESERVA<0
AND SC6.C6_BLQ IN ('','N') -- PV COM RESIDUO ELIMINADO
GROUP BY SC6.C6_FILIAL, SC6.C6_NUM,SC6.C6_ITEM,SC5.C5_EMISSAO, SC6.C6_PRODUTO, SB2.B2_RESERVA,SB2.B2_QEMP, SB2.B2_QATU, SB2.B2_LOCAL, C5_USERLGI
--HAVING ((SUM(SC6.C6_QTDRESE)+SUM(SC6.C6_QTDEMP))-(SB2.B2_RESERVA+SB2.B2_QEMP))<> 0--(SUM(SC6.C6_QTDRESE)+SUM(SC6.C6_QTDEMP)) <> (SB2.B2_RESERVA+SB2.B2_QEMP) AND (SUM(SC6.C6_QTDRESE)+SUM(SC6.C6_QTDEMP)) > SB2.B2_QATU
ORDER BY SC5.C5_EMISSAO,SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_ITEM, SC6.C6_PRODUTO, SB2.B2_LOCAL