--d
Apresente uma instrução T-SQL que permita obter a lista dos clientes (nome), que moram na
cidade de Lisboa, que usaram o serviço “urgente” e , que nunca tenham usado o “não urgente”, ordenado

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
Apresente uma instrução T-SQL que indique o número de encomendas por cliente cuja a data de
entrega é superior a 25 dias após a data de compra. Utilize obrigatóriamente a claúsula GROUP BY

	select a.nocliente, count(a.nocliente)
		from (
			select e.nocliente, e.dtentrega - e.dtcompra as dt
				from encomenda e
			) as a
		where a.dt > 25
		group by a.nocliente
		
