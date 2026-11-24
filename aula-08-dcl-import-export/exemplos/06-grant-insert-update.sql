-- ============================================================
-- DCL 5/8 | Liberar mais coisas  (rode COMO ROOT)
-- ============================================================

-- Só na tabela jogador (não em todo o banco)
GRANT INSERT, UPDATE ON aetheria_online.jogador TO 'analista_junior'@'localhost';

SHOW GRANTS FOR 'analista_junior'@'localhost';

-- Agora volte na conexão do analista_junior e repita o INSERT.
-- Se não passar, feche e abra a conexão dele.

-- ------------------------------------------------------------
-- Curiosidade: permissão POR COLUNA
-- O estagiário vê só id e nome. O e-mail do jogador fica protegido.
-- ------------------------------------------------------------
CREATE USER IF NOT EXISTS 'estagio'@'localhost' IDENTIFIED BY 'Estagio@2026';
GRANT SELECT (id_jogador, nome) ON aetheria_online.jogador TO 'estagio'@'localhost';

-- Conecte como estagio e teste:
--   SELECT id_jogador, nome FROM aetheria_online.jogador;   -- funciona
--   SELECT email    FROM aetheria_online.jogador;   -- ERRO 1143: SELECT denied for column 'email'
