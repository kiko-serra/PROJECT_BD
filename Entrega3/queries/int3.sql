.mode columns
.headers on
.nullvalue NULL

--Listar o numero de jogos em que os jogadores tinham titulos de fide. Com "grandMaster" quantos jogos houve?
--tentativa de apresentar um id do jogo e o id de cada um dos players

SELECT id_match, id_player, count(id_match) as um
From Match join PlayerMatch using(id_match)
group by id_player
order by id_match asc;


