sudo cassandra -R

cqlsh

keyspace
 - espaço onde as tabelas residem.

comando help

opera em esquema de cluster

cluster = mecanismo de arquitetura onde varios computadores (nó) atuam juntos nas mesmas operações.
cassandra banco de dados distribuídos
replication_factor = quantas réplicas irão existir?

cassandra não tem conceito de chave estrangeira, apenas chave primária.

quantidade de colunas variaveis por linha.

create table alunos (cpf text, curso text, idade int, primary key (cpf, curso));
drop table alunos;
alter table alunos add nota decimal;

como orientar o cassandra a utilizar as partições de forma correta?

primary key é formada por duas partes
partition key = chave de partição que define que registro com mesmo valor estarão na mesma partição.
clustering column = chave de ordenação

insert into alunos (cpf, curso, idade, nota) values ('12345678900', 'história', 35, 8);
insert into alunos (cpf, curso, idade, nota) values ('11223344568', 'moda', 30, 6) using TTL 5;
insert into alunos (cpf, curso, nota) values ('11223344568', 'filosofia', 6);

select * from alunos;

alter table alunos add disciplinas map <text,decimal>;

insert into alunos (cpf, curso, disciplinas) values ('11223344568', 'GNI', {'empreendedorismo':10, 'marketing':5});

alter table alunos add observacoes list <text>;

insert into alunos (cpf, curso, observacoes) values ('11223344568', 'GNI2', ['aplicado', 'pontual', 'parceiro']);
insert into alunos (cpf, curso, observacoes) values ('11223344568', 'GNI2', null);

alter table alunos add curso_extra set <text>;

insert into alunos (cpf, curso, curso_extra) values ('11223344568', 'GNI2', {'comunicacao', 'matematica', 'comunicacao'});
insert into alunos (cpf, curso, curso_extra) values ('11223344568', 'GNI2', {'comunicacao'});

update aluno set nota = 10;

update alunos set nota = 10 where cpf = '11223344568' and curso = 'GNI';
update alunos set nota = 10 where cpf = '11223344568' and curso = 'GNI' and nota < 20; INVALIDO

delete from alunos where cpf = '11223344568' and curso = 'GNI';

select * from alunos where nota > 7 ALLOW FILTERING ;
select sum(nota) from alunos where cpf = '11223344568' ;
select cpf, count(nota) from alunos  group by cpf;

select * from alunos where cpf = '11223344568' OR curso = 'GNI'; INVALIDO

create index on alunos(idade);

cassandra trabalha com o conceito de replicação para manter a disponibilidade

nível de consistência

consistência x desempenho

consistency all | one | quorum