########## Passo 1 ##########

Pare o serviço da instancia que terá o Collate alterado. 

########## Passo 2 ##########

Execute o cmd como Administrador. Navegue até o diretório onde está a instalação do SQL Server.

Exemplo: cd C:\Program Files\Microsoft SQL Server\MSSQL10_50.SWAP\MSSQL\Binn

########## Passo 3 ##########

Execute o comando abaixo


sqlservr -m -T4022 -T3659 -q”Latin1_General_BIN”

Aguarde alguns minutos e ao final do procedimento será exibida a mensagem Recovery is Complete.

Tecle Ctrl+C digite y e reinicie a instancia.

Após esses passos todo o collate de todas as bases de dados desta instância estará como Latin1_General_CI_AI.

Utilize o comendo abaixo para verificar o Collate das bases.

exec sp_helpdb