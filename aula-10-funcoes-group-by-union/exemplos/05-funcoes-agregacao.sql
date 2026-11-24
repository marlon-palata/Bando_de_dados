-- 05 | Funções de agregação: resumem MUITAS linhas em UMA
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT COUNT(*)        AS total_personagens,
       MAX(level)      AS maior_level,
       MIN(level)      AS menor_level,
       AVG(level)      AS media_level,
       SUM(experiencia) AS xp_do_servidor
FROM personagem;

SELECT ROUND(AVG(level), 1) AS media_arredondada FROM personagem;  -- função dentro de função

-- COUNT(coluna) NÃO conta NULL. Compare:
SELECT COUNT(*) AS todos, COUNT(id_guilda) AS com_guilda FROM personagem;   -- 12 × 9

-- Agregação + WHERE: o WHERE filtra ANTES de contar
SELECT SUM(recompensa_recebida) AS ouro_pago FROM progresso WHERE data_conclusao IS NOT NULL;
