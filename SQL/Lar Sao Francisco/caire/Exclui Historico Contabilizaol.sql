SELECT COUNT(*) FROM CT2010 A WHERE A.D_E_L_E_T_<>'*' /*AND A.CT2_FILIAL = '11056' AND CT2_DATA BETWEEN '20160101'AND'20160131'*/ AND A.CT2_DC = '4' AND CT2_FILIAL||CT2_DATA||CT2_LOTE||CT2_SBLOTE||CT2_DOC||CT2_SEQUEN 
IN (SELECT CT2_FILIAL||CT2_DATA||CT2_LOTE||CT2_SBLOTE||CT2_DOC||CT2_SEQUEN FROM CT2010 B WHERE B.D_E_L_E_T_='*' AND B.CT2_FILIAL = A.CT2_FILIAL AND A.CT2_DATA = B.CT2_DATA AND B.CT2_DC = '3');