/*a*/
select * 
	from candidato c 
		inner join partido p on p.acronimo = c.acronimo 
		where p.nome = 'Partido de Esquerda';
		
/*b*/
	select *
		from candidato c 
			inner join partido p on p.acronimo = c.acronimo 
			where p.nome = 'Partido de Direita' and c.votos > 1;
			
/*c <- */
	select distinct p.nome, avg(age(e.dtnascimento))
		from candidato c 
			inner join partido p on p.acronimo = c.acronimo 
			inner join eleitor e on e.id = c.id 
			group by p.nome
			having  avg > 30;

/*d*/		
	select distinct on (m.cod) m.descricao , date_part('years', age(e.dtnascimento)) 
		from eleitor e 
			inner join municipio m on m.cod = e.cod
			order by m.cod, age(e.dtnascimento) desc;

			
/*e*/
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
	select distinct on (a.nome) a.nome, a.descricao
		from(
			select *
				from municipio m 
					inner join candidato c on c.cod = m.cod
					inner join partido p on p.acronimo = c.acronimo 
		) as a
		where a.nome not in ('Partido do Centro')
		
/*g*/
	select p.nome 
		from partido p 
		where exists (
			select * 
				from municipio m 
					inner join candidato c on c.cod = m.cod
					where p.acronimo = c.acronimo and m.descricao = 'Beja'
		 );

/*h <- */	
	select *
		from (
			select m.descricao, count(c.id)
				from municipio m 
					inner join candidato c on c.cod = m.cod
					group by m.descricao
		) as a
		
/*i*/
	select *
		from candidato c 
		where c.acronimo = 1 and c.votos > (
			select sum(c.votos) /2
				from municipio m
					inner join candidato c on c.cod = m.cod
				);
		  
/*j*/	        
	create or replace view exJ as
		select m.descricao, count(e.voted) 
			from municipio m
				left join eleitor e on e.cod = m.cod
				group by m.descricao;
				
