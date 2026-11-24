-- =====================================================================
--  AULA 9 | DML — INSERT, SELECT, UPDATE, DELETE  (LIVE CODING)
--  Banco: aetheria_online (as 14 tabelas criadas na aula 7)
--  Rode BLOCO A BLOCO: selecione o comando + Ctrl+Enter.
--  Linhas com "ERRO ESPERADO" dão erro de propósito.
-- =====================================================================
--  DDL (aula 7) = cria a ESTRUTURA     DCL (aula 8) = controla o ACESSO
--  DML (hoje)   = mexe nos DADOS: INSERT · SELECT · UPDATE · DELETE
-- =====================================================================


-- =====================================================================
-- PASSO 0 | Conferir o banco
-- =====================================================================
USE aetheria_online;
SHOW TABLES;            -- tem que listar as 14 tabelas
DESCRIBE jogador;       -- mostra as colunas: é por elas que o INSERT se guia
-- Não tem o banco? Rode antes o arquivo 00-estrutura-aetheria.sql


-- =====================================================================
-- PASSO 1 | INSERT de uma linha
-- =====================================================================
-- Colunas entre parênteses e os valores na MESMA ordem.
-- id_jogador fica de fora: é AUTO_INCREMENT, o MySQL preenche.
INSERT INTO jogador (nome, email) VALUES ('Rafael Silva', 'rafael@pixelforge.com');

SELECT * FROM jogador;  -- confere: id 1 foi gerado sozinho


-- =====================================================================
-- PASSO 2 | INSERT de várias linhas
-- =====================================================================
-- Um VALUES só, vários parênteses separados por vírgula.
INSERT INTO jogador (nome, email) VALUES
  ('Ayla Costa',  'ayla@pixelforge.com'),
  ('Bruno Lima',  'bruno@pixelforge.com'),
  ('Carla Souza', 'carla@pixelforge.com');

INSERT INTO item (nome, tipo) VALUES
  ('Espada de ferro', 'arma'),
  ('Poção de vida',   'consumível');

-- Coluna com DEFAULT pode ficar de fora: recompensa_base vira 0.00
INSERT INTO missao (nome) VALUES ('Patrulha da vila');
INSERT INTO missao (nome, recompensa_base) VALUES ('Caçada ao dragão', 1500.00);

SELECT * FROM missao;


-- =====================================================================
-- PASSO 3 | As travas da tabela barram dado errado
-- =====================================================================
-- Tudo o que criamos na aula 7 agora trabalha a nosso favor.

-- NOT NULL: email é obrigatório
INSERT INTO jogador (nome) VALUES ('Sem Email');
-- ERRO ESPERADO 1364: Field 'email' doesn't have a default value

-- UNIQUE: esse e-mail já existe
INSERT INTO jogador (nome, email) VALUES ('Outro Rafael', 'rafael@pixelforge.com');
-- ERRO ESPERADO 1062: Duplicate entry

-- CHECK: level tem que ser maior que 0
INSERT INTO personagem (nome, level, id_jogador) VALUES ('Bugado', 0, 1);
-- ERRO ESPERADO 3819: Check constraint is violated

-- FOREIGN KEY: não existe jogador 999
INSERT INTO personagem (nome, level, id_jogador) VALUES ('Fantasma', 10, 999);
-- ERRO ESPERADO 1452: Cannot add or update a child row


-- =====================================================================
-- PASSO 4 | Ordem: o PAI entra antes da FILHA
-- =====================================================================
-- personagem aponta para jogador e guilda, então eles têm que existir antes.
INSERT INTO guilda (nome, cidade) VALUES ('Legião de Ferro', 'Valdoria');

INSERT INTO personagem (nome, level, vida, experiencia, id_jogador, id_guilda)
VALUES ('Kaeldor', 45, 100, 128500, 1, 1);

-- LAST_INSERT_ID(): o último id que o AUTO_INCREMENT gerou (o do Kaeldor)
SELECT LAST_INSERT_ID();

-- guerreiro usa o MESMO id do personagem (PK que também é FK)
INSERT INTO guerreiro (id_personagem, pontos_de_armadura, arma_equipada)
VALUES (LAST_INSERT_ID(), 50, 'Espada de ferro');

-- Mais personagens para ter o que consultar. NULL = sem guilda.
INSERT INTO personagem (nome, level, vida, experiencia, id_jogador, id_guilda) VALUES
  ('Sylvara',  62, 100, 245800, 2, 1),
  ('Zephyros', 23,  80,  48200, 2, NULL),
  ('Thorin',   30, 100,  90000, 3, 1),
  ('Lyria',    12,  60,   5400, 3, NULL);


-- =====================================================================
-- PASSO 5 | SELECT básico
-- =====================================================================
SELECT * FROM personagem;                                  -- * = todas as colunas
SELECT nome, level FROM personagem;                        -- só o que interessa
SELECT nome AS personagem, level AS nivel FROM personagem; -- AS muda só o cabeçalho


-- =====================================================================
-- PASSO 6 | WHERE: filtrar linhas
-- =====================================================================
SELECT * FROM personagem WHERE nome = 'Kaeldor';                    -- igual (texto entre aspas)
SELECT nome, level FROM personagem WHERE level > 40;                -- maior que
SELECT nome, level FROM personagem WHERE level BETWEEN 20 AND 50;   -- faixa (inclui 20 e 50)
SELECT nome FROM personagem WHERE id_jogador IN (1, 3);             -- está na lista
SELECT nome FROM personagem WHERE nome LIKE 'Ka%';                  -- começa com "Ka"
SELECT nome FROM personagem WHERE id_guilda IS NULL;                -- sem guilda (nunca "= NULL")
SELECT nome FROM personagem WHERE level > 20 AND id_guilda IS NOT NULL; -- as duas condições


-- =====================================================================
-- PASSO 7 | ORDER BY, LIMIT e COUNT
-- =====================================================================
SELECT nome, level FROM personagem ORDER BY level;                  -- menor → maior (ASC é o padrão)
SELECT nome, level FROM personagem ORDER BY level DESC;             -- maior → menor
SELECT nome, level FROM personagem ORDER BY level DESC LIMIT 3;     -- TOP 3 do ranking
SELECT COUNT(*) AS total_personagens FROM personagem;               -- quantas linhas


-- =====================================================================
-- PASSO 8 | UPDATE: alterar o que já existe
-- =====================================================================
-- REGRA: primeiro o SELECT com o MESMO WHERE. O que aparecer é o que vai mudar.
-- No WHERE use o ID: é a chave, aponta para UMA linha só.
-- (O Safe Updates do Workbench barra WHERE por nome: só aceita coluna chave.)
SELECT id_personagem, nome, level FROM personagem WHERE nome IN ('Kaeldor', 'Lyria');
-- Repare: o Kaeldor pode NÃO ter o id 1. O INSERT que falhou no Passo 3
-- gastou um número do AUTO_INCREMENT (o contador não volta atrás).

-- Guardamos o id numa variável (@) para não digitar o número errado.
SET @kaeldor = (SELECT id_personagem FROM personagem WHERE nome = 'Kaeldor');
SET @lyria   = (SELECT id_personagem FROM personagem WHERE nome = 'Lyria');
SELECT @kaeldor, @lyria;

SELECT * FROM personagem WHERE id_personagem = @kaeldor;                          -- confere antes

UPDATE personagem SET level = 46 WHERE id_personagem = @kaeldor;                  -- uma coluna
UPDATE personagem SET level = 47, experiencia = 150000 WHERE id_personagem = @kaeldor; -- duas colunas
UPDATE personagem SET experiencia = experiencia + 500 WHERE id_personagem = @kaeldor;  -- soma ao valor atual
UPDATE personagem SET id_guilda = 1 WHERE id_personagem = @lyria;                 -- Lyria entrou na guilda

SELECT nome, level, experiencia, id_guilda FROM personagem WHERE id_personagem IN (@kaeldor, @lyria);

-- UPDATE SEM WHERE muda a TABELA INTEIRA. O Workbench barra (Safe Updates):
UPDATE personagem SET level = 1;
-- ERRO ESPERADO 1175: You are using safe update mode


-- =====================================================================
-- PASSO 9 | DELETE: apagar linhas
-- =====================================================================
SELECT * FROM jogador WHERE nome = 'Carla Souza';   -- confere antes
SET @carla = (SELECT id_jogador FROM jogador WHERE nome = 'Carla Souza');
DELETE FROM jogador WHERE id_jogador = @carla;      -- apaga só ela (não tem personagem)
SELECT * FROM jogador;                              -- confere: a Carla sumiu

-- A FK protege o pai: o Rafael (id 1) tem o personagem Kaeldor
DELETE FROM jogador WHERE id_jogador = 1;
-- ERRO ESPERADO 1451: Cannot delete or update a parent row
-- Para apagar de verdade: filha primeiro (guerreiro → personagem → jogador).

-- Comparação (NÃO rodar, só mostrar):
--   DELETE FROM tabela WHERE ...  → apaga as linhas filtradas
--   TRUNCATE TABLE tabela         → esvazia tudo e zera o AUTO_INCREMENT
--   DROP TABLE tabela             → a tabela deixa de existir (é DDL)


-- =====================================================================
-- PASSO 10 | Rede de segurança: transação
-- =====================================================================
-- Desligamos o Safe Updates SÓ para mostrar o desastre e o conserto.
SET SQL_SAFE_UPDATES = 0;

START TRANSACTION;                          -- daqui para frente, nada é definitivo

UPDATE personagem SET level = 1;            -- o "erro": sem WHERE
SELECT nome, level FROM personagem;         -- todo mundo level 1

ROLLBACK;                                   -- desfaz tudo desde o START TRANSACTION
SELECT nome, level FROM personagem;         -- voltou ao normal

SET SQL_SAFE_UPDATES = 1;                   -- religa a proteção
-- Se estivesse certo, o comando seria COMMIT (grava de vez, sem volta).


-- =====================================================================
-- RESUMO
-- =====================================================================
--  INSERT INTO t (col) VALUES (...);      cria linha     → pai antes da filha
--  SELECT col FROM t WHERE ...;           lê            → ORDER BY, LIMIT, COUNT
--  UPDATE t SET col = ... WHERE ...;      altera        → SELECT antes, sempre WHERE
--  DELETE FROM t WHERE ...;               apaga         → filha antes do pai
--  START TRANSACTION ... ROLLBACK/COMMIT  desfazer / confirmar
-- =====================================================================
