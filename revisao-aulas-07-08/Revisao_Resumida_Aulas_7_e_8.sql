-- ============================================================
-- REVISÃO RESUMIDA — AULAS 7 e 8 (2 tabelas, 1 ação por comando)
-- Rode COMO ROOT, linha a linha (selecione + Ctrl+Enter).
-- Banco separado (aetheria_revisao) para não mexer no seu aetheria_online.
-- ============================================================

-- ================= AULA 7: DDL =================

-- 1) criar o banco
CREATE DATABASE aetheria_revisao;

-- 2) entrar no banco
USE aetheria_revisao;

-- 3) tabela pai (PK, NOT NULL, UNIQUE)
CREATE TABLE jogador (
  id_jogador INT PRIMARY KEY AUTO_INCREMENT,
  nome  VARCHAR(80)  NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE
);

-- 4) tabela filha (FK, DEFAULT, CHECK)
CREATE TABLE personagem (
  id_personagem INT PRIMARY KEY AUTO_INCREMENT,
  nome  VARCHAR(80) NOT NULL,
  level INT NOT NULL DEFAULT 1 CHECK (level > 0),
  id_jogador INT NOT NULL,
  FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador)
);

-- 5) conferir a estrutura
DESCRIBE personagem;

-- 6) ALTER: adicionar coluna
ALTER TABLE personagem ADD COLUMN experiencia INT DEFAULT 0;

-- 7) ALTER: mudar o tipo/tamanho
ALTER TABLE personagem MODIFY COLUMN nome VARCHAR(100) NOT NULL;

-- 8) ALTER: apagar coluna
ALTER TABLE personagem DROP COLUMN experiencia;

-- 9) criar tabela descartável e apagar
CREATE TABLE teste_temp (id INT);
DROP TABLE teste_temp;

-- ================= AULA 7: DML básico + INDEX =================

-- 10) inserir jogadores
INSERT INTO jogador (nome, email) VALUES
('Rafael Silva', 'rafael@pixelforge.com'),
('Ayla Costa',   'ayla@pixelforge.com'),
('Bruno Lima',   'bruno@pixelforge.com');

-- 11) inserir personagens (id_jogador = dono)
INSERT INTO personagem (nome, level, id_jogador) VALUES
('Kaeldor', 45, 1),
('Sylvara', 62, 2),
('Thorin',  30, 3);

-- 12) FK em ação: dono que não existe (ERRO 1452)
INSERT INTO personagem (nome, level, id_jogador) VALUES ('Fantasma', 1, 999);

-- 13) consultar
SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- 14) plano SEM índice (olhe o cost e "Table scan")
EXPLAIN FORMAT=TREE SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- 15) criar o índice
CREATE INDEX idx_personagem_nome ON personagem(nome);

-- 16) plano COM índice (cost menor, "Index lookup")
EXPLAIN FORMAT=TREE SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- 17) apagar o índice
DROP INDEX idx_personagem_nome ON personagem;

-- ================= AULA 8: DCL =================

-- 18) criar usuário (crachá sem nenhuma porta)
CREATE USER 'analista'@'localhost' IDENTIFIED BY 'Analista@2026';

-- 19) liberar leitura em todas as tabelas do banco
GRANT SELECT ON aetheria_revisao.* TO 'analista'@'localhost';

-- 20) conferir o que ele pode
SHOW GRANTS FOR 'analista'@'localhost';

-- 21) liberar mais, só em uma tabela
GRANT INSERT ON aetheria_revisao.jogador TO 'analista'@'localhost';

-- 22) tirar a permissão (REVOKE usa FROM)
REVOKE INSERT ON aetheria_revisao.jogador FROM 'analista'@'localhost';

-- 23) TESTAR em OUTRA conexão (login: analista)
--     SELECT * FROM aetheria_revisao.jogador;        -- funciona
--     DELETE FROM aetheria_revisao.jogador;          -- ERRO 1142 (negado)

-- 24) apagar o usuário
DROP USER 'analista'@'localhost';

-- ================= AULA 8: IMPORT / EXPORT =================

-- 25) Workbench: Server > Data Export > marcar aetheria_revisao
--     > Dump Structure and Data > Export to Self-Contained File
--     > "Include Create Schema" DESMARCADO > Start Export

-- 26) Terminal (cmd): exportar
--     mysqldump -u root -p aetheria_revisao > revisao.sql

-- 27) Terminal (cmd): criar banco novo e importar
--     mysql -u root -p -e "CREATE DATABASE aetheria_copia"
--     mysql -u root -p aetheria_copia < revisao.sql

-- 28) conferir a cópia (tem que ter as mesmas linhas)
SELECT COUNT(*) FROM aetheria_copia.jogador;

-- 29) limpar tudo no final
DROP DATABASE aetheria_copia;
DROP DATABASE aetheria_revisao;
