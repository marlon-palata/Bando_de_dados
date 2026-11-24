-- 02 | Subconsulta que devolve UM valor (escalar)
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- O SELECT de dentro roda primeiro e entrega o número para o de fora.
SELECT nome, level
FROM personagem
WHERE level > (SELECT AVG(level) FROM personagem);   -- 6 personagens

-- O personagem de maior level
SELECT nome, level
FROM personagem
WHERE level = (SELECT MAX(level) FROM personagem);   -- Sylvara 62

-- Subconsulta escalar também cabe no SELECT (uma coluna calculada)
SELECT nome, level,
       (SELECT ROUND(AVG(level), 1) FROM personagem) AS media_geral
FROM personagem;
