SELECT * FROM SE2010 WHERE E2_PREFIXO = 'GPE' AND E2_NUM = 'NUMEROTIT' AND D_E_L_E_T_=' '; //LOCALIZA

UPDATE SE2010 SET D_E_L_E_T_='*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERER E2_PREFIXO = 'GPE' AND E2_NUM = 'NUMEROTIT' AND E2_FILIAL ='FILIAL' AND E2_FORNECE = 'FORNECEDOR' AND D_E_L_E_T_ = ' ';

UPDATE RC1010 SET D_E_L_E_T_='*', R_E_C_D_E_L_= R_E_C_N_O_ WHERE RC1_NUMTIT = 'NUMEROTIT' AND RC1_FILTIT = 'FILIAL' AND D_E_L_E_T_=' ';


// Na hora do update... 
// vc coloca o fornecedor e filial, 
// porque podem ter lançamentos com mesmo numero q estão corretos... 
// sempre bom confirmar com o financeiro qual o fornecedor e valor antes de excluir