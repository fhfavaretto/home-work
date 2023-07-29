select * from dba_tablespace_usage_metrics
where tablespace_name in ('E2_PARCELA', 'E5_PARCELA'  )
order by 1;

select column_name, data_default, hidden_column 
from   user_tab_cols
where  table_name in ('SEV010','SEZ010','SEF010') AND hidden_column = 'YES' ;

exec dbms_stats.drop_extended_stats(user, 'SEF010', '("EF_FILIAL","EF_PREFIXO","EF_TITULO","EF_PARCELA","EF_TIPO")');
exec dbms_stats.drop_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_IDENT","D_E_L_E_T_")');
exec dbms_stats.drop_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_NATUREZ","D_E_L_E_T_")');
exec dbms_stats.drop_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO")');
exec dbms_stats.drop_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_NUM","EV_PARCELA")');
exec dbms_stats.drop_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_RECPAG","D_E_L_E_T_")');
exec dbms_stats.drop_extended_stats(user, 'SEV010', '("EV_PREFIXO","EV_PARCELA","D_E_L_E_T_")');
exec dbms_stats.drop_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","D_E_L_E_T_")');
exec dbms_stats.drop_extended_stats(user, 'SEZ010', '("EZ_FILIAL","EZ_PREFIXO","EZ_NUM","EZ_PARCELA","EZ_CLIFOR","EZ_LOJA","EZ_TIPO","EZ_NATUREZ","EZ_CCUSTO","D_E_L_E_T_")');
exec dbms_stats.drop_extended_stats(user, 'SEZ010', '("EZ_FILIAL","EZ_PREFIXO","EZ_NUM","EZ_PARCELA","EZ_CLIFOR","EZ_LOJA","EZ_TIPO","EZ_NATUREZ","EZ_IDENT","D_E_L_E_T_")');
--SYS_OP_COMBINED_HASH("EF_FILIAL","EF_PREFIXO","EF_TITULO","EF_PARCELA","EF_TIPO");

--SYS_OP_COMBINED_HASH("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_NATUREZ");
--SYS_OP_COMBINED_HASH("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_NATUREZ","D_E_L_E_T_");
--SYS_OP_COMBINED_HASH("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO");
--SYS_OP_COMBINED_HASH("EV_FILIAL","EV_NUM","EV_PARCELA");
--SYS_OP_COMBINED_HASH("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_RECPAG","D_E_L_E_T_");
--SYS_OP_COMBINED_HASH("EV_PREFIXO","EV_PARCELA","D_E_L_E_T_");
--SYS_OP_COMBINED_HASH("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_IDENT","D_E_L_E_T_");
--SYS_OP_COMBINED_HASH("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","D_E_L_E_T_");
--SYS_OP_COMBINED_HASH("EZ_FILIAL","EZ_PREFIXO","EZ_NUM","EZ_PARCELA","EZ_CLIFOR","EZ_LOJA","EZ_TIPO","EZ_NATUREZ","EZ_CCUSTO","D_E_L_E_T_");
--SYS_OP_COMBINED_HASH("EZ_FILIAL","EZ_PREFIXO","EZ_NUM","EZ_PARCELA","EZ_CLIFOR","EZ_LOJA","EZ_TIPO","EZ_NATUREZ","EZ_IDENT","D_E_L_E_T_");

ALTER TABLE SEZ010 MODIFY EZ_PARCELA CHAR(2);
ALTER TABLE SEV010 MODIFY EV_PARCELA CHAR(2);
ALTER TABLE SEF010 MODIFY EF_PARCELA CHAR(2);
ALTER TABLE SEA010 MODIFY EA_PARCELA CHAR(2);
ALTER TABLE SE2010 MODIFY E2_PARCELA CHAR(2);
ALTER TABLE SE5010 MODIFY E5_PARCELA CHAR(2);

UPDATE SE2010 SET E2_PARCELA = SUBSTR(E2_PARCELA,1,2);

SELECT E2_FILIAL, E2_PREFIXO, E2_NUM, TRIM(E2_PARCELA), E2_TIPO, E2_FORNECE, E2_LOJA FROM SE2010 WHERE D_E_L_E_T_=' ' 
GROUP BY  E2_FILIAL, E2_PREFIXO, E2_NUM, TRIM(E2_PARCELA), E2_TIPO, E2_FORNECE, E2_LOJA HAVING COUNT(*) > 1 ;

SELECT * FROM SE2010 WHERE LENGTH(EV_PARCELA) > 2 AND D_E_L_E_T_=' ';

SELECT * FROM SE2010 WHERE D_E_L_E_T_=' ' ORDER BY E2_EMISSAO DESC;

SELECT * FROM SE2010 WHERE E2_FILIAL = '11049' AND E2_NUM = '000002648' AND E2_TIPO = 'RC';
UPDATE SE2010 SET E2_PARCELA =' ' WHERE R_E_C_N_O_ = 435083;

select dbms_stats.create_extended_stats(user, 'SEF010', '("EF_FILIAL","EF_PREFIXO","EF_TITULO","EF_PARCELA","EF_TIPO")') from dual;
select dbms_stats.create_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_IDENT","D_E_L_E_T_")') from dual;
select dbms_stats.create_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_NATUREZ","D_E_L_E_T_")') from dual;
select dbms_stats.create_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO")') from dual;
select dbms_stats.create_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_NUM","EV_PARCELA")') from dual;
select dbms_stats.create_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","EV_RECPAG","D_E_L_E_T_")') from dual;
select dbms_stats.create_extended_stats(user, 'SEV010', '("EV_PREFIXO","EV_PARCELA","D_E_L_E_T_")') from dual;
select dbms_stats.create_extended_stats(user, 'SEV010', '("EV_FILIAL","EV_PREFIXO","EV_NUM","EV_PARCELA","EV_CLIFOR","EV_LOJA","EV_TIPO","D_E_L_E_T_")') from dual;
select dbms_stats.create_extended_stats(user, 'SEZ010', '("EZ_FILIAL","EZ_PREFIXO","EZ_NUM","EZ_PARCELA","EZ_CLIFOR","EZ_LOJA","EZ_TIPO","EZ_NATUREZ","EZ_CCUSTO","D_E_L_E_T_")') from dual;
select dbms_stats.create_extended_stats(user, 'SEZ010', '("EZ_FILIAL","EZ_PREFIXO","EZ_NUM","EZ_PARCELA","EZ_CLIFOR","EZ_LOJA","EZ_TIPO","EZ_NATUREZ","EZ_IDENT","D_E_L_E_T_")') from dual;

select column_id, segment_column_id, internal_column_id, column_name, hidden_column, 
virtual_column from user_tab_cols where table_name ='SEF010';