-- ============================================================
-- Import/Export | CSV com LOAD DATA INFILE  (COMO ROOT)
-- ============================================================

-- A tabela de destino JÁ precisa existir, com as mesmas colunas e na mesma ordem.
-- Aqui criamos uma tabela vazia igual à jogador para receber o CSV.
CREATE TABLE IF NOT EXISTS aetheria_online.jogador_importado LIKE aetheria_online.jogador;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/jogadores.csv'
INTO TABLE aetheria_online.jogador_importado
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Mais fácil no Workbench: botão direito na tabela -> Table Data Import Wizard
