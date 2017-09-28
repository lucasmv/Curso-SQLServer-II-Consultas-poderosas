-- Busque todos os alunos que não tenham nenhuma matrícula nos cursos.

select a.nome from aluno a
where not exists (select * from matricula m where m.aluno_id = a.id)


-- Busque todos os alunos que não tiveram nenhuma matrícula nos últimos 45 dias, usando a instrução EXISTS.
select a.nome from aluno a
where not exists
	(
		select * 
		from matricula m 
		where 
			m.aluno_id = a.id and
			m.data > DATEADD(day, -45, GETDATE())				
	)


-- Exiba a média das notas por curso.
select c.nome, avg(n.nota) as nota
from curso c
inner join secao s on c.id = s.curso_id
inner join exercicio e on s.id = e.secao_id
inner join resposta r on e.id = r.exercicio_id
inner join nota n on r.id = n.resposta_id
group by c.nome


-- Devolva o curso e as médias de notas, levando em conta somente alunos que tenham "Silva" ou "Santos" no sobrenome.

select c.nome as curso, avg(n.nota) as nota
from curso c
inner join secao s on c.id = s.curso_id
inner join exercicio e on s.id = e.secao_id
inner join resposta r on e.id = r.exercicio_id
inner join nota n on r.id = n.resposta_id
inner join aluno a on r.aluno_id = a.id
where a.nome like '%Silva%' or c.nome like '%Santos%'
group by c.nome


-- Conte a quantidade de respostas por exercício. Exiba a pergunta e o número de respostas.

select e.pergunta, count(r.id) as respostas
from exercicio e
inner join resposta r on r.exercicio_id = e.id
group by e.pergunta

-- Pegue a resposta do exercício anterior, e ordene por número de respostas, em ordem decrescente.

select e.pergunta, count(r.id) as respostas
from exercicio e
inner join resposta r on r.exercicio_id = e.id
group by e.pergunta
order by respostas desc


-- Podemos agrupar por mais de um campo de uma só vez. Por exemplo, se quisermos a média de notas por aluno por curso, 
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

-- Devolva todos os alunos, cursos e a média de suas notas. Lembre-se de agrupar por aluno e por curso. Filtre também pela nota: só mostre alunos com nota média menor do que 5.

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

-- Exiba todos os cursos e a sua quantidade de matrículas. Mas, exiba somente cursos que tenham mais de 2 matrícula.

select c.nome, count(m.id) matriculas
from curso c
join matricula m on m.curso_id = c.id
group by c.nome
having count(m.id) > 2

-- Exiba o nome do curso e a quantidade de seções que existe nele. Mostre só cursos com mais de 3 seções.

select c.nome, count(s.id) sessoes
from curso c
inner join secao s on s.curso_id = c.id
group by c.nome
having count(s.id) > 3

-- Exiba todos os tipos de matrícula que existem na tabela. Use DISTINCT para que não haja repetição.

select distinct m.tipo
from matricula m

-- Exiba todos os cursos e a sua quantidade de matrículas. Mas filtre por matrículas dos tipos PF ou PJ.

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


-- Exiba a média das notas por aluno, além de uma coluna com a diferença entre a média do aluno e a média geral. Use sub-queries para isso.



-- Exiba a quantidade de matrículas por curso. Além disso, exiba a divisão entre matrículas naquele curso e matrículas totais.
