--c 
Escreva uma expressão de álgebra relacional que permita saber os detalhes dos jogos da jornada nº1.
Apresente o nome da equipa da casa, os seus golos, o nome da equipa visitante e os seus golos. 

	select e.nome, j.golosequipacasa, e2.nome, j.golosequipafora 
		from jogo j 
			inner join equipa e on e.refe = j.refequipacasa 
			inner join equipa e2 on e2.refe = j.refequipafora 
			where j.njornada  = 12;

--e
Escreva uma expressão de álgebra relacional que permita obter a lista de jogadores (nome e bi) com o
total de golos para cada jogador.

	select j.nome, count(g.bi)
		from jogador j 
			inner join golo g on g.bi = j.bi 
			group by j.nome
			order by count desc;

--f
Escreva uma instrução T-SQL que permita obter uma lista da(s) equipa(s) que ganhou mais jogos em
todas as jornadas registadas. Tenha em atenção os jogos em casa e fora. 

	select	a.refequipacasa, sum(a.count)
		from(
			select j.refequipacasa, count(j.refequipacasa)
				from jogo j 
					 where j.resultado = '1'
					 group by j.refequipacasa
			union all
			select j.refequipafora, count(j.refequipafora)
				from jogo j 
					 where j.resultado = '2'
					 group by j.refequipafora
		) as a
			group by a.refequipacasa
			
--g
Escreva uma instrução T-SQL que permita obter as equipas que num jogo já marcaram mais de 4 golos
e que num jogo nunca sofreram mais de 3 golos.	
	
	select e.refe, e.nome
		from equipa e 
			where e.refe in (
				(select j.refequipacasa
					from jogo j
						where j.golosequipacasa > 4
				union 
				select j2.refequipafora
					from jogo j2 
						where j2.golosequipafora > 4)
				except 
				(select j3.refequipacasa
					from jogo j3
						where j3.golosequipafora > 2
				union 
				select j4.refequipafora
					from jogo j4 
						where j4.golosequipacasa > 2)
				)
		
	
