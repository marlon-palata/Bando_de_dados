-- GABARITO | Exercício 2
USE aetheria_online;
-- 1
SELECT COUNT(*) AS jogadores FROM jogador;                         -- 8
-- 2
SELECT MAX(durabilidade_atual) AS maior, MIN(durabilidade_atual) AS menor,
       ROUND(AVG(durabilidade_atual), 1) AS media
FROM equipamento;                                                  -- 100 · 30 · 80.9
-- 3
SELECT COUNT(*) AS em_andamento FROM progresso WHERE data_conclusao IS NULL;   -- 2
-- 4
SELECT id_personagem, COUNT(*) AS itens
FROM equipamento GROUP BY id_personagem ORDER BY itens DESC;
-- 5
SELECT id_guilda, ROUND(AVG(level), 1) AS media_level
FROM personagem GROUP BY id_guilda;
-- 6  (personagens 1, 2, 6, 7 e 10)
SELECT id_personagem, COUNT(*) AS itens
FROM equipamento GROUP BY id_personagem HAVING COUNT(*) >= 2;
-- 7
SELECT nome, 'item' AS origem FROM item WHERE tipo = 'arma'
UNION
SELECT nome, 'missão' FROM missao WHERE recompensa_base > 800;     -- 3 itens + 3 missões
-- 8  (missões 2, 4 e 5)
SELECT id_missao, SUM(recompensa_recebida) AS ouro_pago
FROM progresso GROUP BY id_missao HAVING SUM(recompensa_recebida) > 1000;
