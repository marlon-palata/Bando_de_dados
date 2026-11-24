-- ============================================================
-- REVISÃO COMPLETA — AULAS 7 e 8 | LIVE CODING
-- Banco de Dados · SENAI Ítalo Bologna · Aetheria Online
-- Aula 7: DDL (CREATE, ALTER, INDEX, DROP) + 1º contato com SELECT/EXPLAIN
-- Aula 8: DCL (usuários e permissões) + Import/Export
-- ------------------------------------------------------------
-- COMO USAR
--   * Rode COMO ROOT, nesta ordem, BLOCO A BLOCO (selecione + Ctrl+Enter).
--   * Não rode o arquivo inteiro de uma vez: alguns comandos geram erro
--     DE PROPÓSITO para mostrar o que acontece (marcados com ERRO).
--   * Partes que usam OUTRA conexão (analista_junior, estagio) estão marcadas.
--   * Para recomeçar do zero:  DROP DATABASE aetheria_online;
-- ============================================================
-- ÍNDICE
--   PARTE 1 (aula 7)  DDL: banco, 14 tabelas, ALTER, INDEX, DROP TABLE
--   PARTE 2 (aula 7)  Dados de teste, SELECT e INDEX com EXPLAIN
--   PARTE 3 (aula 8)  DCL: CREATE USER, GRANT, SHOW GRANTS, REVOKE, perfis
--   PARTE 4 (aula 8)  Import/Export: CSV (SQL) e dump (terminal)
-- ============================================================


-- ############################################################
-- PARTE 1 | DDL — Banco, 14 tabelas, ALTER, INDEX, DROP TABLE
-- Base: Esquema Lógico Relacional (diagrama) · ordem: pais primeiro, filhas depois
-- ############################################################
-- Ordem de criação: tabelas "pai" (sem FK) -> "filhas" (com FK).
-- Se criar a filha antes do pai: erro 1824 (tabela referenciada não existe).
-- Nomes das tabelas em minúsculo/snake_case (ContaPremium -> conta_premium):
-- no Linux o MySQL diferencia maiúscula de minúscula.

-- ------------------------------------------------------------
-- 1.1) BANCO DE DADOS
-- ------------------------------------------------------------
-- IF NOT EXISTS: pode rodar o script de novo sem erro.
CREATE DATABASE IF NOT EXISTS aetheria_online;
USE aetheria_online;
-- USE: todo comando seguinte vale dentro desse banco.
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

-- ############################################################
-- PARTE 2 | Dados de teste, SELECT e INDEX com EXPLAIN
-- 10 jogadores + 10 personagens; compare o custo antes e depois do índice
-- ############################################################

-- 1) 10 jogadores
INSERT INTO jogador (nome, email) VALUES
('Rafael Silva',  'rafael@pixelforge.com'),
('Ayla Costa',    'ayla@pixelforge.com'),
('Bruno Lima',    'bruno@pixelforge.com'),
('Carla Souza',   'carla@pixelforge.com'),
('Diego Alves',   'diego@pixelforge.com'),
('Elisa Ramos',   'elisa@pixelforge.com'),
('Fabio Neves',   'fabio@pixelforge.com'),
('Gabi Torres',   'gabi@pixelforge.com'),
('Hugo Pires',    'hugo@pixelforge.com'),
('Iara Matos',    'iara@pixelforge.com');

-- 2) 10 personagens (id_jogador = dono)
INSERT INTO personagem (nome, level, experiencia, id_jogador) VALUES
('Kaeldor',  45, 128500, 1),
('Sylvara',  62, 245800, 2),
('Zephyros', 23,  48200, 3),
('Thorin',   30,  90000, 4),
('Lyria',    12,   5400, 5),
('Gorak',    78, 301000, 6),
('Elowen',   50, 150000, 7),
('Draven',   33,  70000, 8),
('Mira',      8,   1200, 9),
('Aldric',   45, 120000, 10);

-- 3) SELECT: ver os dados
SELECT * FROM personagem;

-- 4) SELECT com filtro (WHERE)
SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- 5) EXPLAIN SEM índice (experiencia ainda não tem índice)
--    olhe: type = ALL (lê tudo) e cost = custo estimado
EXPLAIN FORMAT=TREE SELECT * FROM personagem WHERE experiencia = 128500;
SELECT * FROM personagem WHERE experiencia = 128500;

-- 6) criar o índice
CREATE INDEX idx_personagem_experiencia ON personagem(experiencia);
SHOW INDEX FROM personagem;

-- 7) EXPLAIN COM índice: a mesma consulta
--    olhe: "Index lookup" e cost menor
EXPLAIN FORMAT=TREE SELECT * FROM personagem WHERE experiencia = 128500;
SELECT * FROM personagem WHERE experiencia = 128500;

-- ############################################################
-- PARTE 3 | DCL — Usuários e permissões (COMO ROOT, salvo indicação)
-- Princípio do menor privilégio: cada um recebe só o que precisa
-- ############################################################


-- ------------------------------------------------------------
-- 3.1 CREATE USER
-- ------------------------------------------------------------
-- 'analista_junior'@'localhost' = usuário@host.
-- 'localhost' = só entra do próprio computador. Evite '%' (qualquer lugar).
-- IF NOT EXISTS evita o erro 1396 quando o usuário já existe.
CREATE USER IF NOT EXISTS 'analista_junior'@'localhost' IDENTIFIED BY 'Analista@2026';

-- O usuário já aparece na lista, mas ainda NÃO pode fazer nada
SELECT user, host FROM mysql.user WHERE user = 'analista_junior';

-- ------------------------------------------------------------
-- 3.2 GRANT
-- ------------------------------------------------------------
-- aetheria_online.*  = todas as tabelas do banco aetheria_online
-- Use sempre o nível MAIS ESTREITO que resolve o problema.
GRANT SELECT ON aetheria_online.* TO 'analista_junior'@'localhost';

-- Outros níveis (só para comparar, não precisa rodar):
--   GRANT SELECT ON aetheria_online.jogador TO ...;            -- só uma tabela
--   GRANT SELECT (nome, level) ON aetheria_online.personagem TO ...;  -- só 2 colunas
--   GRANT SELECT ON *.* TO ...;                          -- TODOS os bancos (cuidado!)

-- ------------------------------------------------------------
-- 3.3 SHOW GRANTS
-- ------------------------------------------------------------
-- Mostra tudo o que o usuário pode fazer.
-- USAGE = "pode apenas conectar" (é o crachá sem nenhuma porta liberada)
SHOW GRANTS FOR 'analista_junior'@'localhost';

-- ------------------------------------------------------------
-- 3.4 TESTAR com OUTRA conexão: analista_junior (NÃO rode como root!)
--     Se rodar como root, o DROP TABLE abaixo APAGA a tabela de verdade.
-- ------------------------------------------------------------
SELECT CURRENT_USER();                       -- confirma quem sou eu: analista_junior@localhost

SELECT * FROM aetheria_online.jogador;              -- FUNCIONA (tem SELECT)

INSERT INTO aetheria_online.jogador (nome, email) VALUES ('Teste','teste@pf.com');
-- ERRO 1142: INSERT command denied  (não tem INSERT)

DROP TABLE aetheria_online.jogador;
-- ERRO 1142: DROP command denied    (não tem DROP)

-- ------------------------------------------------------------
-- 3.5 Liberar mais + permissão por coluna
-- ------------------------------------------------------------
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

-- ------------------------------------------------------------
-- 3.6 REVOKE
-- ------------------------------------------------------------
-- GRANT usa TO. REVOKE usa FROM.
REVOKE INSERT, UPDATE ON aetheria_online.jogador FROM 'analista_junior'@'localhost';

SHOW GRANTS FOR 'analista_junior'@'localhost';

-- Só se revoga NO MESMO NÍVEL em que foi dado:
-- um GRANT em aetheria_online.* NÃO se desfaz com REVOKE em aetheria_online.jogador
-- (dá ERRO 1147: There is no such grant defined, e a permissão continua valendo).

-- Tirar tudo de uma vez:
-- REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'analista_junior'@'localhost';

-- ------------------------------------------------------------
-- 3.7 Os 3 perfis da Pixel Forge
-- ------------------------------------------------------------
-- 1) ADMIN: tudo no aetheria_online e pode repassar permissões
CREATE USER IF NOT EXISTS 'admin_pf'@'localhost' IDENTIFIED BY 'Admin@2026';
GRANT ALL PRIVILEGES ON aetheria_online.* TO 'admin_pf'@'localhost' WITH GRANT OPTION;

-- 2) DEV: lê/grava dados e muda a estrutura. Sem DROP e sem repassar permissões
CREATE USER IF NOT EXISTS 'dev_pf'@'localhost' IDENTIFIED BY 'Dev@2026';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX
  ON aetheria_online.* TO 'dev_pf'@'localhost';

-- 3) ANALISTA: só lê (já criado no arquivo 02)
GRANT SELECT ON aetheria_online.* TO 'analista_junior'@'localhost';

SHOW GRANTS FOR 'admin_pf'@'localhost';
SHOW GRANTS FOR 'dev_pf'@'localhost';
SHOW GRANTS FOR 'analista_junior'@'localhost';

-- ------------------------------------------------------------
-- 3.8 Manutenção: ALTER USER, ROLE, DROP USER
-- ------------------------------------------------------------
-- Trocar senha
CREATE USER IF NOT EXISTS 'temp_pf'@'localhost' IDENTIFIED BY 'Temp@2026';
ALTER USER 'temp_pf'@'localhost' IDENTIFIED BY 'NovaSenha@2026';

-- Listar usuários
SELECT user, host FROM mysql.user;

-- ROLE (MySQL 8): um perfil pronto, sem repetir GRANTs para cada pessoa
CREATE ROLE IF NOT EXISTS 'perfil_leitura';
GRANT SELECT ON aetheria_online.* TO 'perfil_leitura';

CREATE USER IF NOT EXISTS 'leitor_pf'@'localhost' IDENTIFIED BY 'Leitor@2026';
GRANT 'perfil_leitura' TO 'leitor_pf'@'localhost';
-- Sem esta linha o role NÃO vale automaticamente quando o usuário conecta:
SET DEFAULT ROLE 'perfil_leitura' TO 'leitor_pf'@'localhost';

-- Conecte como leitor_pf e rode:  SELECT * FROM aetheria_online.jogador;   -- funciona pelo role

-- Apagar usuários e role de teste
DROP USER IF EXISTS 'temp_pf'@'localhost';
DROP USER IF EXISTS 'leitor_pf'@'localhost';
DROP ROLE IF EXISTS 'perfil_leitura';

-- FLUSH PRIVILEGES: só é necessário se você editar as tabelas mysql.* na mão.
-- GRANT / REVOKE / CREATE USER já valem na hora.

-- ############################################################
-- PARTE 4 | Import / Export
-- CSV pelo SQL; dump e restore pelo terminal (comandos no fim)
-- ############################################################

-- 4.1 EXPORTAR CSV
-- 1) O MySQL só grava na pasta indicada aqui. Copie o caminho que aparecer!
SHOW VARIABLES LIKE 'secure_file_priv';

-- 2) Troque o caminho pelo SEU secure_file_priv (barras normais "/", mesmo no Windows).
--    O arquivo NÃO pode existir antes, e o usuário precisa do privilégio FILE (root tem).
SELECT * FROM aetheria_online.jogador
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/jogadores.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 4.2 IMPORTAR CSV
-- A tabela de destino JÁ precisa existir, com as mesmas colunas e na mesma ordem.
-- Aqui criamos uma tabela vazia igual à jogador para receber o CSV.
CREATE TABLE IF NOT EXISTS aetheria_online.jogador_importado LIKE aetheria_online.jogador;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/jogadores.csv'
INTO TABLE aetheria_online.jogador_importado
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Mais fácil no Workbench: botão direito na tabela -> Table Data Import Wizard

-- 4.3 VALIDAR A CÓPIA (só depois de importar um dump em aetheria_copia, ver 4.4)
SHOW TABLES FROM aetheria_copia;

-- As contagens têm que ser IGUAIS às do banco original
SELECT 'original' AS banco, COUNT(*) AS total FROM aetheria_online.jogador
UNION ALL
SELECT 'copia',             COUNT(*)          FROM aetheria_copia.jogador;

-- Confere se as FKs também foram recriadas
SHOW CREATE TABLE aetheria_copia.personagem;

-- ------------------------------------------------------------
-- 4.4 TERMINAL (cmd) — NÃO rodar no Workbench
-- ------------------------------------------------------------
-- ============================================================
--  Import/Export | Comandos de TERMINAL (cmd), fora do Workbench
-- ============================================================
-- Se aparecer "não é reconhecido como comando", entre antes na pasta:
--   cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
--
-- --- EXPORTAR (dump) ------------------------------------------
-- # banco inteiro (inclui CREATE DATABASE e USE)
-- mysqldump -u root -p --databases aetheria_online > aetheria_backup.sql
--
-- # só a estrutura, sem dados
-- mysqldump -u root -p --no-data aetheria_online > aetheria_estrutura.sql
--
-- # backup consistente sem travar as tabelas (InnoDB) + procedures/functions
-- mysqldump -u root -p --single-transaction --routines --databases aetheria_online > aetheria_completo.sql
--
-- --- IMPORTAR (restore) ---------------------------------------
-- # dump feito com --databases (já tem CREATE DATABASE)
-- mysql -u root -p < aetheria_backup.sql
--
-- # dump SEM --databases: o banco de destino precisa existir antes
-- mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS aetheria_copia"
-- mysql -u root -p aetheria_copia < aetheria_estrutura.sql
--
-- # dentro do cliente mysql (terminal). Use barras normais "/".
-- # ATENÇÃO: "source" NÃO funciona na aba SQL do Workbench.
-- mysql -u root -p
-- mysql> source C:/dumps/aetheria_backup.sql;
--
-- --- NO WORKBENCH (sem terminal) -------------------------------
-- Exportar: Server > Data Export > marque "aetheria_online" > Dump Structure and Data
--           > Export to Self-Contained File > Start Export
-- Importar: Server > Data Import > Import from Self-Contained File
--           > escolha o .sql e o Default Target Schema > Start Import

-- ------------------------------------------------------------
-- 4.5 WORKBENCH: Server > Data Export
--   marque aetheria_online > Dump Structure and Data
--   > troque para "Export to Self-Contained File" (o padrão é Project Folder)
--   > deixe "Include Create Schema" DESMARCADO para fazer cópia
--   > Start Export
-- ------------------------------------------------------------

-- ============================================================
-- RESUMO RÁPIDO
--   DDL: CREATE / ALTER / DROP (estrutura)    DCL: CREATE USER / GRANT / REVOKE
--   GRANT usa TO · REVOKE usa FROM · teste sempre com OUTRA conexão
--   Índice acelera o SELECT; EXPLAIN mostra o plano e o custo
--   Dump COM --databases sobrescreve o banco original ao importar
-- ============================================================
