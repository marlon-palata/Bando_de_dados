-- 07 | RIGHT JOIN: todos da DIREITA
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT p.nome AS personagem, g.nome AS guilda
FROM personagem p
RIGHT JOIN guilda g ON p.id_guilda = g.id_guilda;  -- todas as guildas: Clã dos Ventos com NULL

-- É o LEFT ao contrário. Estas duas dão o mesmo resultado:
--   FROM personagem p RIGHT JOIN guilda g ...
--   FROM guilda g LEFT JOIN personagem p ...
-- Na prática quase todo mundo escreve LEFT e só troca a ordem das tabelas.
