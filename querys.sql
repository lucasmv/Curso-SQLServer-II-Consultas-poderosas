-- Busque todos os alunos que n�o tenham nenhuma matr�cula nos cursos.

select a.nome from aluno a
where not exists (select * from matricula m where m.aluno_id = a.id)


-- Busque todos os alunos que n�o tiveram nenhuma matr�cula nos �ltimos 45 dias, usando a instru��o EXISTS.
select a.nome from aluno a
where not exists
	(
		select * 
		from matricula m 
		where 
			m.aluno_id = a.id and
			m.data > DATEADD(day, -45, GETDATE())				
	)


-- Exiba a m�dia das notas por curso.
select c.nome, avg(n.nota) as nota
from curso c
inner join secao s on c.id = s.curso_id
inner join exercicio e on s.id = e.secao_id
inner join resposta r on e.id = r.exercicio_id
inner join nota n on r.id = n.resposta_id
group by c.nome


-- Devolva o curso e as m�dias de notas, levando em conta somente alunos que tenham "Silva" ou "Santos" no sobrenome.

select c.nome as curso, avg(n.nota) as nota
from curso c
inner join secao s on c.id = s.curso_id
inner join exercicio e on s.id = e.secao_id
inner join resposta r on e.id = r.exercicio_id
inner join nota n on r.id = n.resposta_id
inner join aluno a on r.aluno_id = a.id
where a.nome like '%Silva%' or c.nome like '%Santos%'
group by c.nome


-- Conte a quantidade de respostas por exerc�cio. Exiba a pergunta e o n�mero de respostas.

select e.pergunta, count(r.id) as respostas
from exercicio e
inner join resposta r on r.exercicio_id = e.id
group by e.pergunta

-- Pegue a resposta do exerc�cio anterior, e ordene por n�mero de respostas, em ordem decrescente.

select e.pergunta, count(r.id) as respostas
from exercicio e
inner join resposta r on r.exercicio_id = e.id
group by e.pergunta
order by respostas desc


-- Podemos agrupar por mais de um campo de uma s� vez. Por exemplo, se quisermos a m�dia de notas por aluno por curso, 
-- podemos fazer GROUP BY aluno.id,curso.id.

select a.nome as aluno, c.nome as curso, avg(n.nota) as nota
from curso c
inner join secao s on c.id = s.curso_id
inner join exercicio e on s.id = e.secao_id
inner join resposta r on e.id = r.exercicio_id
inner join nota n on r.id = n.resposta_id
inner join aluno a on r.aluno_id = a.id
group by a.nome, c.nome
order by a.nome

-- Devolva todos os alunos, cursos e a m�dia de suas notas. Lembre-se de agrupar por aluno e por curso. Filtre tamb�m pela nota: s� mostre alunos com nota m�dia menor do que 5.

select a.nome as aluno, c.nome as curso, avg(n.nota) as nota
from curso c
inner join secao s on c.id = s.curso_id
inner join exercicio e on s.id = e.secao_id
inner join resposta r on e.id = r.exercicio_id
inner join nota n on r.id = n.resposta_id
inner join aluno a on r.aluno_id = a.id
group by a.nome, c.nome
having avg(n.nota) >= 5
order by a.nome

-- Exiba todos os cursos e a sua quantidade de matr�culas. Mas, exiba somente cursos que tenham mais de 2 matr�cula.

select c.nome, count(m.id) matriculas
from curso c
join matricula m on m.curso_id = c.id
group by c.nome
having count(m.id) > 2

-- Exiba o nome do curso e a quantidade de se��es que existe nele. Mostre s� cursos com mais de 3 se��es.

select c.nome, count(s.id) sessoes
from curso c
inner join secao s on s.curso_id = c.id
group by c.nome
having count(s.id) > 3

-- Exiba todos os tipos de matr�cula que existem na tabela. Use DISTINCT para que n�o haja repeti��o.

select distinct m.tipo
from matricula m

-- Exiba todos os cursos e a sua quantidade de matr�culas. Mas filtre por matr�culas dos tipos PF ou PJ.

select c.nome, count(m.id) matriculas
from curso c
join matricula m on m.curso_id = c.id
where m.tipo in ('PAGA_PF', 'PAGA_PJ')
group by c.nome

-- Traga todas as perguntas e a quantidade de respostas de cada uma. Mas dessa vez, somente dos cursos com ID 1 e 3.

select e.pergunta, count(r.id) respostas
from exercicio e
join resposta r on r.exercicio_id = e.id
join secao s on s.id = e.secao_id
join curso c on c.id = s.curso_id
where c.id in(1, 3)
group by e.pergunta


-- Exiba a m�dia das notas por aluno, al�m de uma coluna com a diferen�a entre a m�dia do aluno e a m�dia geral. Use sub-queries para isso.



-- Exiba a quantidade de matr�culas por curso. Al�m disso, exiba a divis�o entre matr�culas naquele curso e matr�culas totais.
