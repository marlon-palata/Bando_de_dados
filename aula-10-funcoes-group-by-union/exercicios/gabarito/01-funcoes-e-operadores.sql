-- GABARITO | Exercício 1
USE aetheria_online;
-- 1
SELECT nome, vida, 100 - vida AS falta_curar FROM personagem;
-- 2
SELECT nome, ROUND(recompensa_base * 1.15, 2) AS recompensa_bonus FROM missao;
-- 3
SELECT CONCAT(nome, ' <', email, '>') AS contato FROM jogador;
-- 4
SELECT nome FROM personagem WHERE CHAR_LENGTH(nome) > 6;        -- Kaeldor, Sylvara, Zephyros, Morgana, Brienne (5)
-- 5
SELECT id_jogador,
       DATE_FORMAT(data_assinatura, '%d/%m/%Y') AS assinatura,
       DATE_ADD(data_assinatura, INTERVAL 6 MONTH) AS vencimento
FROM conta_premium;
-- 6  (5 linhas)
SELECT id_personagem, id_missao, data_conclusao
FROM progresso
WHERE YEAR(data_conclusao) = 2026 AND MONTH(data_conclusao) <= 3;
-- também vale: WHERE data_conclusao BETWEEN '2026-01-01' AND '2026-03-31'
-- 7
SELECT nome, FLOOR(experiencia / level) AS xp_por_level
FROM personagem WHERE level >= 40;                                -- 5 linhas
