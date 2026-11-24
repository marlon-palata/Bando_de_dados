-- GABARITO | Exercício 1
USE aetheria_online;
-- 1  (12 linhas)
SELECT p.nome AS personagem, j.nome AS jogador
FROM personagem p INNER JOIN jogador j ON p.id_jogador = j.id_jogador;
-- 2  (9 linhas)
SELECT p.nome AS personagem, g.nome AS guilda, g.cidade
FROM personagem p INNER JOIN guilda g ON p.id_guilda = g.id_guilda
ORDER BY g.nome;
-- 3  (9 linhas, mesmo resultado)
SELECT p.nome AS personagem, g.nome AS guilda, g.cidade
FROM personagem p, guilda g
WHERE p.id_guilda = g.id_guilda
ORDER BY g.nome;
-- 4  (14 linhas)
SELECT p.nome AS personagem, i.nome AS item, e.durabilidade_atual
FROM equipamento e
INNER JOIN personagem p ON e.id_personagem = p.id_personagem
INNER JOIN item i       ON e.id_item = i.id_item;
-- 5  (14 linhas)
SELECT p.nome AS personagem, m.nome AS missao,
       DATE_FORMAT(pr.data_conclusao, '%d/%m/%Y') AS concluida_em
FROM progresso pr
INNER JOIN personagem p ON pr.id_personagem = p.id_personagem
INNER JOIN missao m     ON pr.id_missao = m.id_missao
WHERE pr.data_conclusao IS NOT NULL;
-- 6  (4 linhas)
SELECT p.nome, mg.pontos_de_mana, mg.grimorio
FROM personagem p INNER JOIN mago mg ON p.id_personagem = mg.id_personagem;
-- 7  96 linhas: cada um dos 12 personagens combinado com cada um dos 8 itens (12 × 8)
SELECT COUNT(*) FROM personagem CROSS JOIN item;
