-- =============================================================
-- LISTA 01 — DDL e DCL | GABARITO (professor)
-- Exemplo com o aluno João Pedro Lima (joao_lima) da Turma 1A.
-- Turma 1B: troque 1a por 1b em TODOS os nomes.
-- Rode como ROOT, bloco a bloco.
-- =============================================================

-- ---------- PASSO 0: o banco de exercícios (fica para as próximas listas) ----------
CREATE DATABASE IF NOT EXISTS exercicios_1a_joao_lima;
USE exercicios_1a_joao_lima;

-- ---------- PARTE A — DDL ----------
-- 1) editora (pai)
CREATE TABLE editora (
  id_editora INT PRIMARY KEY AUTO_INCREMENT,
  nome       VARCHAR(80) NOT NULL,
  cnpj       VARCHAR(18) NOT NULL UNIQUE,
  cidade     VARCHAR(60) DEFAULT 'Itu'
);

-- 2) livro (filha de editora)
CREATE TABLE livro (
  id_livro   INT PRIMARY KEY AUTO_INCREMENT,
  titulo     VARCHAR(120) NOT NULL,
  preco      DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  estoque    INT DEFAULT 0,
  lancamento DATE,
  id_editora INT NOT NULL,
  FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

-- 3) cliente (pai)
CREATE TABLE cliente (
  id_cliente    INT PRIMARY KEY AUTO_INCREMENT,
  nome          VARCHAR(80) NOT NULL,
  email         VARCHAR(120) NOT NULL UNIQUE,
  vip           BOOLEAN DEFAULT FALSE,
  cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4) venda (filha de cliente E de livro)
CREATE TABLE venda (
  id_venda   INT PRIMARY KEY AUTO_INCREMENT,
  data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
  quantidade INT DEFAULT 1 CHECK (quantidade > 0),
  id_cliente INT NOT NULL,
  id_livro   INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_livro)   REFERENCES livro(id_livro)
);

-- 5) ordem: editora e cliente (pais) antes; livro depois de editora; venda por último.

-- 6) ALTER: acrescentar colunas
ALTER TABLE livro ADD COLUMN isbn VARCHAR(20) UNIQUE;
ALTER TABLE livro ADD COLUMN paginas INT;

-- 7) MODIFY
ALTER TABLE livro MODIFY COLUMN titulo VARCHAR(200) NOT NULL;

-- 8) DROP COLUMN
ALTER TABLE livro DROP COLUMN paginas;

-- 9) FK depois
CREATE TABLE avaliacao (
  id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
  nota         INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
  id_livro     INT NOT NULL
);
ALTER TABLE avaliacao ADD FOREIGN KEY (id_livro) REFERENCES livro(id_livro);

-- 10) índices
CREATE INDEX idx_livro_titulo ON livro(titulo);
CREATE INDEX idx_cliente_nome ON cliente(nome);
DROP INDEX idx_cliente_nome ON cliente;

-- 11) tabela de rascunho e DROP TABLE
CREATE TABLE rascunho (id INT PRIMARY KEY AUTO_INCREMENT, anotacao VARCHAR(100));
DROP TABLE rascunho;

-- 12) encontre o erro — ver gabarito em PDF (respostas escritas)

-- conferência
SHOW TABLES;   -- editora, livro, cliente, venda, avaliacao

-- ---------- PARTE B — DCL ----------
-- 13) caixa: consulta livro e registra venda
CREATE USER 'joao_lima_1a_caixa'@'localhost' IDENTIFIED BY 'Caixa@2026';
GRANT SELECT ON exercicios_1a_joao_lima.livro TO 'joao_lima_1a_caixa'@'localhost';
GRANT SELECT, INSERT ON exercicios_1a_joao_lima.venda TO 'joao_lima_1a_caixa'@'localhost';

-- 14) conferir
SHOW GRANTS FOR 'joao_lima_1a_caixa'@'localhost';
-- 15) teste em outra conexão (logado como o caixa):
--   SELECT * FROM exercicios_1a_joao_lima.livro;      -- funciona
--   DELETE FROM exercicios_1a_joao_lima.venda;        -- ERRO 1142

-- 16) estoquista: lê e altera livro; vê só id e nome do cliente
CREATE USER 'joao_lima_1a_estoque'@'localhost' IDENTIFIED BY 'Estoque@2026';
GRANT SELECT, UPDATE ON exercicios_1a_joao_lima.livro TO 'joao_lima_1a_estoque'@'localhost';
GRANT SELECT (id_cliente, nome) ON exercicios_1a_joao_lima.cliente TO 'joao_lima_1a_estoque'@'localhost';

-- 17) gerente (admin do banco) e 18) dev
CREATE USER 'joao_lima_1a_gerente'@'localhost' IDENTIFIED BY 'Gerente@2026';
GRANT ALL PRIVILEGES ON exercicios_1a_joao_lima.* TO 'joao_lima_1a_gerente'@'localhost' WITH GRANT OPTION;

CREATE USER 'joao_lima_1a_dev'@'localhost' IDENTIFIED BY 'Dev@2026';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX ON exercicios_1a_joao_lima.* TO 'joao_lima_1a_dev'@'localhost';

-- 19) REVOKE
REVOKE INSERT ON exercicios_1a_joao_lima.venda FROM 'joao_lima_1a_caixa'@'localhost';
SHOW GRANTS FOR 'joao_lima_1a_caixa'@'localhost';

-- 20) manutenção
ALTER USER 'joao_lima_1a_dev'@'localhost' IDENTIFIED BY 'NovoDev@2026';
SELECT user, host FROM mysql.user WHERE user LIKE 'joao_lima_1a_%';
DROP USER 'joao_lima_1a_estoque'@'localhost';

-- 21) ROLE
CREATE ROLE 'joao_lima_1a_leitura';
GRANT SELECT ON exercicios_1a_joao_lima.* TO 'joao_lima_1a_leitura';
GRANT 'joao_lima_1a_leitura' TO 'joao_lima_1a_caixa'@'localhost';
SET DEFAULT ROLE 'joao_lima_1a_leitura' TO 'joao_lima_1a_caixa'@'localhost';

-- 22) revogar tudo do gerente sem apagar o usuário
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'joao_lima_1a_gerente'@'localhost';
