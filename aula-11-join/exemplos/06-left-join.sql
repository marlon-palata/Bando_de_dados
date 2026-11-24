-- 06 | LEFT JOIN: todos da ESQUERDA, com ou sem par
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT p.nome AS personagem, g.nome AS guilda
FROM personagem p                       -- esquerda: TODOS os personagens
LEFT JOIN guilda g ON p.id_guilda = g.id_guilda;   -- 12 linhas, sem guilda = NULL

-- Quem NÃO tem par: LEFT JOIN + IS NULL
SELECT j.nome AS jogador_sem_personagem
FROM jogador j
LEFT JOIN personagem p ON j.id_jogador = p.id_jogador
WHERE p.id_personagem IS NULL;          -- Gabriela Alves

SELECT i.nome AS item_nunca_usado
FROM item i
LEFT JOIN equipamento e ON i.id_item = e.id_item
WHERE e.id_item IS NULL;                -- Anel do dragão
