-- 03 | Funções matemáticas
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT nome, experiencia / level AS xp_por_level,
       ROUND(experiencia / level, 1) AS arredondado,    -- 1 casa decimal
       CEIL(experiencia / level)     AS para_cima,      -- teto
       FLOOR(experiencia / level)    AS para_baixo      -- piso
FROM personagem;

SELECT ABS(25 - 40) AS distancia_de_level;   -- valor absoluto (sem sinal): 15
SELECT MOD(17, 5)   AS resto;                -- o mesmo que 17 % 5 = 2
