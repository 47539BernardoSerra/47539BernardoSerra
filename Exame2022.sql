/*a*/
lista de candidatos filiados ao partido de esquerda

select * 
	from candidato c 
		inner join partido p on p.acronimo = c.acronimo 
		where p.nome = 'Partido de Esquerda';
		
/*b*/
quantos candidatos do partido de direita obtiveram mais 1 voto

	select *
		from candidato c 
			inner join partido p on p.acronimo = c.acronimo 
			where p.nome = 'Partido de Direita' and c.votos > 1;
			
/*c*/
que partido tem candidatos com uma media de idade superior a 30

	select distinct p.nome, avg(age(e.dtnascimento))
		from candidato c 
			inner join partido p on p.acronimo = c.acronimo 
			inner join eleitor e on e.id = c.id 
			group by p.nome
			having  avg > 30;
	select *
		from(
			select acronimo, avg(date_part('years',age(e.dtnascimento))) as media
				from candidato c 
					inner join eleitor e on e.id = c.id 
					group by acronimo
		) as a
		where a.media > 30;


/*d*/	
qual a idade do eleitor mais velho em cada municipio ordenar pelo eleitor mais velho 

	select municipio.descricao, max(date_part('year', age(eleitor.dtnascimento))) 
		from (eleitor inner join municipio on eleitor.cod=municipio.cod) 
			group by municipio.descricao
				order by municipio.descricao desc; 


	select distinct on (m.cod) m.descricao , date_part('years', age(e.dtnascimento)) 
		from eleitor e 
			inner join municipio m on m.cod = e.cod
			order by m.cod, age(e.dtnascimento) desc;

			
/*e*/
que partidos tem candidatos com uma media de idade superior a 30
	select *
		from(
			select p.nome, avg(date_part('years',age(e.dtnascimento))) as media
				from partido p 
					inner join candidato c on c.acronimo = p.acronimo 
					inner join eleitor e on e.id = c.id 
					group by p.nome
				) as a
			where a.media > 30;
			
/*f*/
que municipio nao tiveram candidatos do partido de centro use in

	select distinct on (a.nome) a.nome, a.descricao
		from(
			select *
				from municipio m 
					inner join candidato c on c.cod = m.cod
					inner join partido p on p.acronimo = c.acronimo 
		) as a
		where a.nome not in ('Partido do Centro')
		
/*g*/
que partidos estiveram representados nas eleicoes no municipo de beja use exists

	select p.nome 
		from partido p 
		where exists (
			select * 
				from municipio m 
					inner join candidato c on c.cod = m.cod
					where p.acronimo = c.acronimo and m.descricao = 'Beja'
		 );

/*h*/	
que municipios tiveram mais candidatos 

	select *
		from (
			select m.descricao, count(c.id)
				from municipio m 
					left outer join candidato c on c.cod = m.cod
					group by m.descricao
		) as a
		order by count desc;

	
	select *
		from (
			select m.descricao, count(c.id)
				from municipio m 
					inner join candidato c on c.cod = m.cod
					group by m.descricao
		) as a
		
/*i*/
quais sao os codigos dos municipios onde o partido com sigla pd teve maioria

	select *
		from candidato c 
		where c.acronimo = 1 and c.votos > (
			select sum(c.votos) /2
				from municipio m
					inner join candidato c on c.cod = m.cod
				);
		  
/*j*/
cria uma vista com o numero de abstencoes de cada municipio

	create or replace view exJ as
		select m.descricao, count(e.voted) 
			from municipio m
				left join eleitor e on e.cod = m.cod
				group by m.descricao;
				
