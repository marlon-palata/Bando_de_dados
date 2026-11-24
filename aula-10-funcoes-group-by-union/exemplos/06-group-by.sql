-- 06 | GROUP BY: um resumo POR grupo
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- "Quantos personagens tem cada guilda?"
SELECT id_guilda, COUNT(*) AS membros
FROM personagem
GROUP BY id_guilda;                 -- NULL vira um grupo: os sem guilda

-- Quantos itens de cada tipo?
SELECT tipo, COUNT(*) AS quantidade FROM item GROUP BY tipo;

-- Quanto ouro cada missão já pagou? (do maior para o menor)
SELECT id_missao, SUM(recompensa_recebida) AS ouro_pago
FROM progresso
GROUP BY id_missao
ORDER BY ouro_pago DESC;

-- REGRA: no SELECT com GROUP BY, só entra a coluna do grupo + funções de agregação.
-- SELECT id_guilda, nome, COUNT(*) FROM personagem GROUP BY id_guilda;
-- ERRO ESPERADO 1055 (ONLY_FULL_GROUP_BY): "nome" de qual personagem do grupo?
