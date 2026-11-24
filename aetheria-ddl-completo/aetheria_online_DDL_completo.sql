-- ============================================================
-- AETHERIA ONLINE | MODELO FÍSICO COMPLETO (somente DDL)
-- Base: Esquema Lógico Relacional (14 tabelas) + aula 7 (DDL)
-- SGBD: MySQL 8.0 | Rode COMO ROOT, no Workbench (Ctrl+Shift+Enter)
-- ============================================================
-- Ordem de criação: tabelas "pai" (sem FK) -> "filhas" (com FK).
-- Se criar a filha antes do pai: erro 1824 (tabela referenciada não existe).
-- Nomes das tabelas em minúsculo/snake_case (ContaPremium -> conta_premium):
-- no Linux o MySQL diferencia maiúscula de minúscula.
-- ============================================================

-- ------------------------------------------------------------
-- 1) BANCO DE DADOS
-- ------------------------------------------------------------
-- IF NOT EXISTS: pode rodar o script de novo sem erro.
CREATE DATABASE IF NOT EXISTS aetheria_online;
-- USE: todo comando seguinte vale dentro desse banco.
USE aetheria_online;
-- Para recomeçar do zero (APAGA TUDO, sem volta):
-- DROP DATABASE aetheria_online;

-- ------------------------------------------------------------
-- 2) TABELAS PAI (sem FK)
-- ------------------------------------------------------------
CREATE TABLE jogador (
    id_jogador INT PRIMARY KEY AUTO_INCREMENT,   -- AUTO_INCREMENT: o MySQL gera 1, 2, 3...
    nome       VARCHAR(80)  NOT NULL,            -- obrigatório
    email      VARCHAR(120) NOT NULL UNIQUE      -- obrigatório e não repete
);

CREATE TABLE guilda (
    id_guilda INT PRIMARY KEY AUTO_INCREMENT,
    nome      VARCHAR(60) NOT NULL UNIQUE,       -- duas guildas não podem ter o mesmo nome
    cidade    VARCHAR(60)                        -- opcional (aceita NULL)
);

CREATE TABLE missao (
    id_missao       INT PRIMARY KEY AUTO_INCREMENT,
    nome            VARCHAR(80)   NOT NULL,
    -- DECIMAL(10,2): dinheiro/moeda NUNCA em FLOAT (erro de arredondamento)
    recompensa_base DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE item (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    nome    VARCHAR(60) NOT NULL,
    tipo    VARCHAR(30) NOT NULL                 -- ex.: arma, armadura, poção
);

CREATE TABLE moderador (
    id_moderador INT PRIMARY KEY AUTO_INCREMENT,
    nome         VARCHAR(80) NOT NULL
);

-- ------------------------------------------------------------
-- 3) TABELAS COM FK (1º nível)
-- ------------------------------------------------------------
-- Jogador (0,1) assina ContaPremium (1,1): relação 1:1
-- -> a FK id_jogador é UNIQUE (um jogador tem no máximo uma conta premium).
CREATE TABLE conta_premium (
    id_conta        INT PRIMARY KEY AUTO_INCREMENT,
    data_assinatura DATE NOT NULL,
    id_jogador      INT  NOT NULL UNIQUE,
    FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador)
);

CREATE TABLE personagem (
    id_personagem INT PRIMARY KEY AUTO_INCREMENT,
    nome          VARCHAR(80) NOT NULL,
    -- DEFAULT 1: nasce no level 1. CHECK: nunca level <= 0.
    level         INT NOT NULL DEFAULT 1 CHECK (level > 0),
    vida          INT NOT NULL DEFAULT 100 CHECK (vida >= 0),
    experiencia   INT NOT NULL DEFAULT 0   CHECK (experiencia >= 0),
    id_jogador    INT NOT NULL,                  -- todo personagem TEM dono
    id_guilda     INT NULL,                      -- participação parcial: pode não ter guilda
    FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador),
    FOREIGN KEY (id_guilda)  REFERENCES guilda(id_guilda)
);

-- ------------------------------------------------------------
-- 4) TABELAS COM FK (2º nível) - dependem de personagem
-- ------------------------------------------------------------
-- Especialização Total/Exclusiva: cada personagem aparece em UMA destas 3.
-- PK = FK: o id da subclasse é o mesmo id do personagem.
CREATE TABLE guerreiro (
    id_personagem      INT PRIMARY KEY,
    pontos_de_armadura INT NOT NULL DEFAULT 0,
    arma_equipada      VARCHAR(60),
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE mago (
    id_personagem  INT PRIMARY KEY,
    pontos_de_mana INT NOT NULL DEFAULT 0,
    grimorio       VARCHAR(60),
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem)
);

CREATE TABLE arqueiro (
    id_personagem        INT PRIMARY KEY,
    precisao_a_distancia INT NOT NULL DEFAULT 0,
    flechas_disponiveis  INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem)
);

-- Tabelas associativas / entidades fracas: PK COMPOSTA (2 colunas).
CREATE TABLE equipamento (
    id_personagem      INT NOT NULL,
    id_item            INT NOT NULL,
    data_equipado      DATE,
    durabilidade_atual INT NOT NULL DEFAULT 100,
    PRIMARY KEY (id_personagem, id_item),
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem),
    FOREIGN KEY (id_item)       REFERENCES item(id_item)
);

CREATE TABLE progresso (
    id_personagem      INT NOT NULL,
    id_missao          INT NOT NULL,
    data_conclusao     DATE,
    recompensa_recebida DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_personagem, id_missao),
    FOREIGN KEY (id_personagem) REFERENCES personagem(id_personagem),
    FOREIGN KEY (id_missao)     REFERENCES missao(id_missao)
);

-- Troca tem DUAS FK para a mesma tabela (quem propõe e quem recebe).
CREATE TABLE troca (
    id_troca               INT PRIMARY KEY AUTO_INCREMENT,
    data_troca             DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_personagem_propoe   INT NOT NULL,
    id_personagem_recebe   INT NOT NULL,
    FOREIGN KEY (id_personagem_propoe) REFERENCES personagem(id_personagem),
    FOREIGN KEY (id_personagem_recebe) REFERENCES personagem(id_personagem)
);

-- ------------------------------------------------------------
-- 5) ÚLTIMO NÍVEL - depende de troca e moderador
-- ------------------------------------------------------------
CREATE TABLE denuncia (
    id_troca     INT NOT NULL,
    id_moderador INT NOT NULL,
    motivo       VARCHAR(200),
    PRIMARY KEY (id_troca, id_moderador),
    FOREIGN KEY (id_troca)     REFERENCES troca(id_troca),
    FOREIGN KEY (id_moderador) REFERENCES moderador(id_moderador)
);

-- ------------------------------------------------------------
-- 6) ALTER TABLE (aula 7) - evoluir a estrutura sem perder dados
-- ------------------------------------------------------------
-- ADD COLUMN: linhas existentes recebem o DEFAULT.
ALTER TABLE jogador ADD COLUMN data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP;
-- MODIFY COLUMN: muda tipo/tamanho (aqui, nome do personagem aceita 100).
ALTER TABLE personagem MODIFY COLUMN nome VARCHAR(100) NOT NULL;
-- DROP COLUMN: apaga a coluna e os dados dela, sem volta.
-- (extra da aula 7, fora do diagrama: removemos para voltar ao diagrama)
ALTER TABLE jogador DROP COLUMN data_criacao;

-- ------------------------------------------------------------
-- 7) ÍNDICES (aula 7)
-- ------------------------------------------------------------
-- Índice = atalho de busca. Só em coluna muito consultada (WHERE/ORDER BY).
CREATE INDEX idx_personagem_nome  ON personagem(nome);
CREATE INDEX idx_personagem_level ON personagem(level);
-- DROP INDEX idx_personagem_level ON personagem;

-- ------------------------------------------------------------
-- 8) DROP TABLE (aula 7) - demonstrado com tabela descartável
-- ------------------------------------------------------------
CREATE TABLE teste_temp (id INT PRIMARY KEY AUTO_INCREMENT, observacao VARCHAR(50));
SHOW TABLES LIKE 'teste_temp';
DROP TABLE teste_temp;               -- apaga estrutura + dados
SHOW TABLES LIKE 'teste_temp';       -- vazio: sumiu

-- ------------------------------------------------------------
-- 9) CONFERÊNCIA FINAL: devem aparecer 14 tabelas
-- ------------------------------------------------------------
SHOW TABLES;
DESCRIBE personagem;
SHOW INDEX FROM personagem;
