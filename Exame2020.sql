--d
	select p.nome
		from pessoa p
		where p.cidade = 'Lisboa'
		group by p.nident 
		having p.nident in (
			select e.nocliente 
				from encomenda e 
					where e.tipo = 'urgente'
			except 
			select e1.nocliente
				from encomenda e1 
					where e1.tipo = 'nao urgente'
			)
		order by p.nome
		
--f
	select a.nocliente, count(a.nocliente)
		from (
			select e.nocliente, e.dtentrega - e.dtcompra as dt
				from encomenda e
			) as a
		where a.dt > 25
		group by a.nocliente
		
