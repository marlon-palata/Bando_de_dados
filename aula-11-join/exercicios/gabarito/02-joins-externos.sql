-- GABARITO | Exercício 2
USE aetheria_online;
-- 1  (12 linhas; Zephyros, Lyria e Dravik com NULL)
SELECT p.nome AS personagem, g.nome AS guilda
FROM personagem p LEFT JOIN guilda g ON p.id_guilda = g.id_guilda;
-- 2  Gabriela Alves
SELECT j.nome FROM jogador j
LEFT JOIN personagem p ON j.id_jogador = p.id_jogador
WHERE p.id_personagem IS NULL;
-- 3  Anel do dragão
SELECT i.nome FROM item i
LEFT JOIN equipamento e ON i.id_item = e.id_item
WHERE e.id_item IS NULL;
-- 4  Tesouro perdido aparece com NULL
SELECT m.nome AS missao, pr.id_personagem
FROM progresso pr RIGHT JOIN missao m ON pr.id_missao = m.id_missao;
-- 5  Clã dos Ventos
SELECT g.nome FROM guilda g
LEFT JOIN personagem p ON g.id_guilda = p.id_guilda
WHERE p.id_personagem IS NULL;
-- 6  Legião 4 · Ordem 3 · Sombras 2 · Clã 0
SELECT g.nome AS guilda, COUNT(p.id_personagem) AS membros
FROM guilda g LEFT JOIN personagem p ON g.id_guilda = p.id_guilda
GROUP BY g.nome;
-- 7  (5 linhas)
SELECT t.id_troca, a.nome AS quem_propoe, b.nome AS quem_recebe
FROM troca t
INNER JOIN personagem a ON t.id_personagem_propoe = a.id_personagem
INNER JOIN personagem b ON t.id_personagem_recebe = b.id_personagem;
-- 8
SELECT j.nome AS jogador, SUM(pr.recompensa_recebida) AS ouro
FROM jogador j
INNER JOIN personagem p ON j.id_jogador = p.id_jogador
INNER JOIN progresso pr ON p.id_personagem = pr.id_personagem
GROUP BY j.nome
ORDER BY ouro DESC;
