
   SELECT * FROM SE5010 WHERE E5_FILIAL = '11015' AND E5_DATA BETWEEN '20161006'AND'20161006' AND D_E_L_E_T_=' ';
   UPDATE SE5010 SET E5_LA = ' ' WHERE E5_FILIAL = '11015' AND E5_DATA BETWEEN '20161006'AND'20161006' AND D_E_L_E_T_=' ';
   UPDATE SE5010 SET E5_LA = 'S' WHERE E5_FILIAL = '11015' AND E5_DATA BETWEEN '20161006'AND'20161006' AND D_E_L_E_T_=' ' AND E5_RECPAG = 'P' AND E5_HISTOR LIKE '%RESGATE%';
   UPDATE SE5010 SET E5_LA = 'S' WHERE E5_FILIAL = '11015' AND E5_DATA BETWEEN '20161006'AND'20161006' AND D_E_L_E_T_=' ' AND E5_RECPAG = 'R' AND E5_HISTOR LIKE '%APLICAC%';