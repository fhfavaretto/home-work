Create TABLE aluno(
    id SERIAL,
    nome Varchar(255),
    CPF Char(11),
    Observação Text,
    idade Integer,
    dinheiro numeric (10,2),
    altura real,
    ativo BOOLEAN,
    data_nascimento DATE,
    hora_aula TIME,
    Data_de_matricula timestamp );
	
	
select * from aluno;


 INSERT INTO aluno (
    nome,
    cpf,
    observação,
    idade,
    dinheiro,
    altura,
    ativo,
    data_nascimento,
    hora_aula,
    Data_de_matricula)
VALUES (
    'Diogo',
    '12345678901',
    'Nada a declarar',
    '35',
    100.50,
    1.81,
    TRUE,
    '1996-04-04',
    '17:30:00',
    '2021-11-15 10:52:00');