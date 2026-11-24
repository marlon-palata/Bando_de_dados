-- 05 | INNER JOIN com 3 tabelas (ou mais)
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- Personagem + dono (jogador) + guilda
SELECT p.nome AS personagem, j.nome AS jogador, g.nome AS guilda
FROM personagem p
INNER JOIN jogador j ON p.id_jogador = j.id_jogador
INNER JOIN guilda  g ON p.id_guilda  = g.id_guilda;

-- O que cada personagem está usando (equipamento liga personagem e item)
SELECT p.nome AS personagem, i.nome AS item, e.durabilidade_atual
FROM equipamento e
INNER JOIN personagem p ON e.id_personagem = p.id_personagem
INNER JOIN item       i ON e.id_item       = i.id_item
ORDER BY p.nome;

-- JOIN + WHERE: o ON liga, o WHERE filtra
SELECT p.nome, i.nome AS item
FROM equipamento e
INNER JOIN personagem p ON e.id_personagem = p.id_personagem
INNER JOIN item       i ON e.id_item       = i.id_item
WHERE i.tipo = 'poção';
