-- 07 | HAVING: filtrar os GRUPOS
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- Guildas com 4 ou mais membros
SELECT id_guilda, COUNT(*) AS membros
FROM personagem
GROUP BY id_guilda
HAVING COUNT(*) >= 4;

-- WHERE filtra LINHAS (antes de agrupar) · HAVING filtra GRUPOS (depois)
SELECT id_personagem, COUNT(*) AS missoes_concluidas
FROM progresso
WHERE data_conclusao IS NOT NULL      -- 1) só concluídas
GROUP BY id_personagem                -- 2) agrupa por personagem
HAVING COUNT(*) >= 2                  -- 3) só quem concluiu 2 ou mais
ORDER BY missoes_concluidas DESC;     -- 4) ordena

-- Ordem obrigatória: SELECT · FROM · WHERE · GROUP BY · HAVING · ORDER BY · LIMIT
