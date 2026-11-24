-- 06 | ORDER BY e LIMIT
USE aetheria_online;

-- do menor level para o maior (ASC é o padrão)
SELECT nome, level FROM personagem ORDER BY level;

-- do maior para o menor
SELECT nome, level FROM personagem ORDER BY level DESC;

-- o TOP 3 do ranking: ordena e corta
SELECT nome, level FROM personagem ORDER BY level DESC LIMIT 3;

-- contar linhas
SELECT COUNT(*) AS total_personagens FROM personagem;
