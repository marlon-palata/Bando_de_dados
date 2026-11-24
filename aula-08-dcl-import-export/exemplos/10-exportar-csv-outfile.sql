-- ============================================================
-- Import/Export | CSV com SELECT ... INTO OUTFILE  (COMO ROOT)
-- ============================================================

-- 1) O MySQL só grava na pasta indicada aqui. Copie o caminho que aparecer!
SHOW VARIABLES LIKE 'secure_file_priv';

-- 2) Troque o caminho pelo SEU secure_file_priv (barras normais "/", mesmo no Windows).
--    O arquivo NÃO pode existir antes, e o usuário precisa do privilégio FILE (root tem).
SELECT * FROM aetheria_online.jogador
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/jogadores.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';
