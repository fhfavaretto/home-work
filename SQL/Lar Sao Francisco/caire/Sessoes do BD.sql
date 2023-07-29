  /*===================== VERIFICA SESSÕES DO ORACLE ===========================*/
 SELECT TRIM(s.sid) SID, 
      TRIM(s.serial#) SERIAL, 
      TRIM(s.sid)||','||TRIM(s.serial#) CHAVE,
      p.spid, 
      s.osuser, 
      s.program 
FROM   v$process p, 
      v$session s 
WHERE  p.addr = s.paddr 
order by program,s.sid; 

/*===================== DERRUBA SESSÕES DO ORACLE ===========================*/
ALTER SYSTEM KILL SESSION '787,23331' IMMEDIATE;  

 SELECT  S.SID, S.SERIAL#, 
 S.SID||','||S.SERIAL# SBD, 
P.SPID, S.USERNAME, 
S.STATUS, S.OSUSER, S.MACHINE, 
S.PROGRAM, S.MODULE, 
TO_CHAR(S.LOGON_TIME, 'dd/mm/yyyy hh24:mi:ss') LOGON_TIME, 
S.blocking_session -- id da sessao bloqueadora (qdo for o caso)
FROM    V$SESSION S
JOIN    V$PROCESS P
ON    P.addr = S.paddr
WHERE   S.TYPE = 'USER'
--AND S.blocking_session IS NOT NULL
ORDER BY S.SID
;
