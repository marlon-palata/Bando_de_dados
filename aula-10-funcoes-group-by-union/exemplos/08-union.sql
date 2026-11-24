-- 08 | UNION: empilhar resultados
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- Lista única de nomes: jogadores E moderadores
SELECT nome, 'jogador'   AS papel FROM jogador
UNION
SELECT nome, 'moderador' AS papel FROM moderador;

-- UNION tira repetidos · UNION ALL mantém tudo
SELECT tipo FROM item WHERE tipo = 'arma'
UNION
SELECT tipo FROM item WHERE tipo = 'arma';       -- 1 linha

SELECT tipo FROM item WHERE tipo = 'arma'
UNION ALL
SELECT tipo FROM item WHERE tipo = 'arma';       -- 6 linhas

-- Os dois SELECT precisam ter o MESMO número de colunas:
-- SELECT nome, email FROM jogador UNION SELECT nome FROM moderador;
-- ERRO ESPERADO 1222: The used SELECT statements have a different number of columns
