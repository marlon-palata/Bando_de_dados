-- ============================================================
-- DCL 2/8 | GRANT  (rode COMO ROOT)
-- ============================================================

-- aetheria_online.*  = todas as tabelas do banco aetheria_online
-- Use sempre o nível MAIS ESTREITO que resolve o problema.
GRANT SELECT ON aetheria_online.* TO 'analista_junior'@'localhost';

-- Outros níveis (só para comparar, não precisa rodar):
--   GRANT SELECT ON aetheria_online.jogador TO ...;            -- só uma tabela
--   GRANT SELECT (nome, level) ON aetheria_online.personagem TO ...;  -- só 2 colunas
--   GRANT SELECT ON *.* TO ...;                          -- TODOS os bancos (cuidado!)
