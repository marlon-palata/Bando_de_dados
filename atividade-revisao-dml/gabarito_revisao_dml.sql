-- =============================================================
-- ATIVIDADE DE REVISÃO (DDL + DCL) + PESQUISA (DML) | GABARITO
-- Academia FitLab · exemplo: aluno João Pedro Lima, Turma 1A
-- Turma 1B: troque 1a por 1b em TODOS os nomes. Rode como ROOT, bloco a bloco.
-- =============================================================

-- PASSO 0
USE exercicios_1a_joao_lima;
SHOW TABLES;

-- ================= PARTE A — DDL =================
-- 1
CREATE TABLE plano (
  id_plano    INT PRIMARY KEY AUTO_INCREMENT,
  nome        VARCHAR(30)   NOT NULL UNIQUE,
  mensalidade DECIMAL(10,2) NOT NULL CHECK (mensalidade > 0)
);
-- 2
CREATE TABLE instrutor (
  id_instrutor  INT PRIMARY KEY AUTO_INCREMENT,
  nome          VARCHAR(80) NOT NULL,
  especialidade VARCHAR(40) DEFAULT 'Musculação'
);
-- 3
CREATE TABLE aluno (
  id_aluno       INT PRIMARY KEY AUTO_INCREMENT,
  nome           VARCHAR(80) NOT NULL,
  cpf            VARCHAR(14) NOT NULL UNIQUE,
  ativo          BOOLEAN DEFAULT TRUE,
  matriculado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  id_plano       INT NOT NULL,
  FOREIGN KEY (id_plano) REFERENCES plano(id_plano)
);
-- 4
CREATE TABLE treino (
  id_treino    INT PRIMARY KEY AUTO_INCREMENT,
  data_treino  DATE NOT NULL,
  duracao_min  INT DEFAULT 60 CHECK (duracao_min > 0),
  id_aluno     INT NOT NULL,
  id_instrutor INT NOT NULL,
  FOREIGN KEY (id_aluno)     REFERENCES aluno(id_aluno),
  FOREIGN KEY (id_instrutor) REFERENCES instrutor(id_instrutor)
);
-- 5
ALTER TABLE aluno ADD COLUMN telefone VARCHAR(15);
-- 6
ALTER TABLE instrutor MODIFY COLUMN nome VARCHAR(100) NOT NULL;
-- 7
CREATE INDEX idx_aluno_nome ON aluno(nome);

-- ================= PARTE B — DCL =================
-- 8
CREATE USER 'joao_lima_1a_recepcao'@'localhost' IDENTIFIED BY 'Recep@2026';
GRANT SELECT, INSERT ON exercicios_1a_joao_lima.aluno TO 'joao_lima_1a_recepcao'@'localhost';
GRANT SELECT ON exercicios_1a_joao_lima.plano TO 'joao_lima_1a_recepcao'@'localhost';
-- 9
SHOW GRANTS FOR 'joao_lima_1a_recepcao'@'localhost';
-- (conectado como recepcao) DROP TABLE exercicios_1a_joao_lima.treino;  → ERRO 1142
-- 10
CREATE USER 'joao_lima_1a_coach'@'localhost' IDENTIFIED BY 'Coach@2026';
GRANT SELECT (id_aluno, nome) ON exercicios_1a_joao_lima.aluno TO 'joao_lima_1a_coach'@'localhost';
GRANT SELECT, INSERT, UPDATE ON exercicios_1a_joao_lima.treino TO 'joao_lima_1a_coach'@'localhost';
-- 11
REVOKE INSERT ON exercicios_1a_joao_lima.aluno FROM 'joao_lima_1a_recepcao'@'localhost';
SHOW GRANTS FOR 'joao_lima_1a_recepcao'@'localhost';

-- ================= PARTE C — PESQUISA + DML =================
-- 13
INSERT INTO plano (nome, mensalidade) VALUES
  ('Básico', 89.90), ('Plus', 129.90), ('Black', 179.90);
INSERT INTO instrutor (nome) VALUES ('Carla Mendes');              -- especialidade fica no DEFAULT
INSERT INTO instrutor (nome, especialidade) VALUES
  ('Diego Rocha', 'Funcional'), ('Paula Nunes', 'Pilates');
INSERT INTO aluno (nome, cpf, id_plano) VALUES
  ('Marcos Silva',   '111.111.111-11', 1),
  ('Juliana Prado',  '222.222.222-22', 3),
  ('Mateus Lima',    '333.333.333-33', 2),
  ('Renata Alves',   '444.444.444-44', 3),
  ('Bruno Costa',    '555.555.555-55', 1),
  ('Larissa Gomes',  '666.666.666-66', 2);
INSERT INTO treino (data_treino, duracao_min, id_aluno, id_instrutor) VALUES
  ('2026-11-10', 60, 1, 1),
  ('2026-11-10', 45, 2, 3),
  ('2026-11-11', 90, 3, 2),
  ('2026-11-11', 30, 4, 1),
  ('2026-11-12', 75, 2, 2),
  ('2026-11-12', 60, 5, 1),
  ('2026-11-13', 120, 4, 3),
  ('2026-11-13', 50, 1, 2);
-- 14 (erros de propósito)
INSERT INTO aluno (nome, cpf, id_plano) VALUES ('Clone', '111.111.111-11', 1);   -- 1062 UNIQUE
INSERT INTO plano (nome, mensalidade) VALUES ('Grátis', 0);                       -- 3819 CHECK
INSERT INTO treino (data_treino, id_aluno, id_instrutor) VALUES ('2026-11-14', 99, 1); -- 1452 FK
-- 15
SELECT * FROM aluno;
-- 16
SELECT nome, cpf FROM aluno ORDER BY nome;
-- 17
SELECT * FROM treino WHERE duracao_min > 60;
-- 18
SELECT * FROM treino WHERE id_instrutor = 1 AND duracao_min >= 60;
-- 19
SELECT * FROM plano WHERE id_plano = 3;
UPDATE plano SET mensalidade = 197.89 WHERE id_plano = 3;
-- (desafio) UPDATE plano SET mensalidade = mensalidade * 1.10 WHERE id_plano = 3;
SELECT * FROM plano WHERE id_plano = 3;
-- 20
SELECT * FROM aluno WHERE id_aluno = 5;
UPDATE aluno SET ativo = FALSE, telefone = '(11) 99999-0000' WHERE id_aluno = 5;
-- 21
SELECT * FROM treino WHERE id_aluno = 5;          -- treino 6
DELETE FROM treino WHERE id_treino = 6;
DELETE FROM plano WHERE id_plano = 3;             -- 1451: alunos usam o plano Black
SELECT COUNT(*) FROM treino;                      -- 7 (conferência do professor)
