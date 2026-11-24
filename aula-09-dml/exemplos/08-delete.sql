-- 08 | DELETE — apagando linhas
USE aetheria_online;

-- confira antes
SELECT * FROM jogador WHERE nome = 'Carla Souza';

-- apaga só a linha filtrada
SET @carla = (SELECT id_jogador FROM jogador WHERE nome = 'Carla Souza');
DELETE FROM jogador WHERE id_jogador = @carla;   -- Safe Updates exige a chave no WHERE

-- a FK protege o pai: o Rafael tem personagem
DELETE FROM jogador WHERE id_jogador = 1;
-- ERRO 1451: Cannot delete or update a parent row

-- ordem certa: filha primeiro, depois o pai
-- DELETE FROM guerreiro  WHERE id_personagem = 1;
-- DELETE FROM personagem WHERE id_personagem = 1;
-- DELETE FROM jogador    WHERE id_jogador = 1;

-- DELETE (linhas, com WHERE)  ×  TRUNCATE (todas as linhas)  ×  DROP (a tabela some)
-- TRUNCATE TABLE jogador;
-- DROP TABLE jogador;
