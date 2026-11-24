-- =====================================================================
--  AULA 14 | FUNCTION, TRIGGER e EVENT  (LIVE CODING)
--  Banco: aetheria_online  ·  Antes: rode o 00b (dados padrão)
--  Rode BLOCO A BLOCO. Blocos com DELIMITER rodam INTEIROS.
-- =====================================================================
--  FUNCTION = devolve UM valor e é usada dentro do SELECT.
--  TRIGGER  = roda SOZINHO quando alguém faz INSERT, UPDATE ou DELETE.
--  EVENT    = roda SOZINHO num horário (agenda do banco).
-- =====================================================================


-- =====================================================================
-- PASSO 0 | Conferir e limpar execuções anteriores
-- =====================================================================
USE aetheria_online;
SET NAMES utf8mb4;
SELECT COUNT(*) FROM personagem;   -- 12

DROP FUNCTION IF EXISTS fn_classe;
DROP FUNCTION IF EXISTS fn_xp_por_level;
DROP FUNCTION IF EXISTS fn_ouro_total;
DROP TRIGGER  IF EXISTS tg_historico_level;
DROP TRIGGER  IF EXISTS tg_email_minusculo;
DROP TRIGGER  IF EXISTS tg_vida_maxima;
DROP TRIGGER  IF EXISTS tg_troca_valida;
DROP EVENT    IF EXISTS ev_regenerar_vida;
DROP EVENT    IF EXISTS ev_missao_relampago;


-- =====================================================================
-- PASSO 1 | FUNCTION: a primeira função
-- =====================================================================
-- Recebe o level e devolve a CLASSE do personagem (um texto).
DELIMITER $$
CREATE FUNCTION fn_classe(p_level INT)
RETURNS VARCHAR(20)
DETERMINISTIC                    -- mesma entrada → sempre a mesma saída
BEGIN
    IF p_level < 20 THEN
        RETURN 'Iniciante';
    ELSEIF p_level < 40 THEN
        RETURN 'Aventureiro';
    ELSEIF p_level < 60 THEN
        RETURN 'Veterano';
    ELSE
        RETURN 'Lenda';
    END IF;
END $$
DELIMITER ;

-- Usa-se DENTRO do SELECT, como as funções nativas (UPPER, ROUND...)
SELECT nome, level, fn_classe(level) AS classe FROM personagem;

-- Também no WHERE e no GROUP BY
SELECT nome FROM personagem WHERE fn_classe(level) = 'Veterano';
SELECT fn_classe(level) AS classe, COUNT(*) AS quantos
FROM personagem
GROUP BY fn_classe(level);


-- =====================================================================
-- PASSO 2 | FUNCTION com dois parâmetros
-- =====================================================================
DELIMITER $$
CREATE FUNCTION fn_xp_por_level(p_xp INT, p_level INT)
RETURNS DECIMAL(10,1)
DETERMINISTIC
BEGIN
    RETURN ROUND(p_xp / p_level, 1);
END $$
DELIMITER ;

SELECT nome, fn_xp_por_level(experiencia, level) AS eficiencia
FROM personagem
ORDER BY eficiencia DESC;


-- =====================================================================
-- PASSO 3 | FUNCTION que consulta uma tabela
-- =====================================================================
DELIMITER $$
CREATE FUNCTION fn_ouro_total(p_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA                   -- lê dados do banco (não é DETERMINISTIC)
BEGIN
    DECLARE v_total DECIMAL(10,2);           -- variável local
    SELECT SUM(recompensa_recebida) INTO v_total
    FROM progresso WHERE id_personagem = p_id;
    RETURN v_total;
END $$
DELIMITER ;

SELECT nome, fn_ouro_total(id_personagem) AS ouro FROM personagem;
-- Quem nunca fez missão aparece com NULL (SUM de nada = NULL).

-- Sem DETERMINISTIC / READS SQL DATA, em servidor com log binário ligado:
-- ERRO 1418: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA...


-- =====================================================================
-- PASSO 4 | TRIGGER: o banco reagindo sozinho
-- =====================================================================
-- Tabela EXTRA (fora do diagrama do Aetheria): o histórico de mudanças de level.
CREATE TABLE IF NOT EXISTS historico_level (
    id_historico  INT PRIMARY KEY AUTO_INCREMENT,
    id_personagem INT NOT NULL,
    level_antigo  INT NOT NULL,
    level_novo    INT NOT NULL,
    data_mudanca  DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- AFTER UPDATE: depois de cada UPDATE em personagem, grava o histórico.
-- OLD = a linha ANTES · NEW = a linha DEPOIS
DELIMITER $$
CREATE TRIGGER tg_historico_level
AFTER UPDATE ON personagem
FOR EACH ROW
BEGIN
    IF NEW.level <> OLD.level THEN
        INSERT INTO historico_level (id_personagem, level_antigo, level_novo)
        VALUES (NEW.id_personagem, OLD.level, NEW.level);
    END IF;
END $$
DELIMITER ;

UPDATE personagem SET level = 46 WHERE id_personagem = 1;   -- Kaeldor sobe
UPDATE personagem SET vida = 90 WHERE id_personagem = 1;    -- muda só a vida
SELECT * FROM historico_level;   -- só UMA linha (45 → 46): ninguém escreveu esse INSERT!


-- =====================================================================
-- PASSO 5 | BEFORE INSERT: arrumar o dado antes de gravar
-- =====================================================================
DELIMITER $$
CREATE TRIGGER tg_email_minusculo
BEFORE INSERT ON jogador
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(TRIM(NEW.email));   -- mexe no NEW antes de gravar
END $$
DELIMITER ;

INSERT INTO jogador (nome, email) VALUES ('Ivo Ramos', '  IVO@PixelForge.COM ');
SELECT nome, email FROM jogador WHERE nome = 'Ivo Ramos';   -- ivo@pixelforge.com


-- =====================================================================
-- PASSO 6 | BEFORE UPDATE: aplicar uma regra
-- =====================================================================
DELIMITER $$
CREATE TRIGGER tg_vida_maxima
BEFORE UPDATE ON personagem
FOR EACH ROW
BEGIN
    IF NEW.vida > 100 THEN
        SET NEW.vida = 100;          -- ninguém passa de 100 de vida
    END IF;
END $$
DELIMITER ;

UPDATE personagem SET vida = 250 WHERE id_personagem = 9;   -- tentaram dar 250 ao Dravik
SELECT nome, vida FROM personagem WHERE id_personagem = 9;  -- 100


-- =====================================================================
-- PASSO 7 | SIGNAL: o trigger que BARRA a operação
-- =====================================================================
DELIMITER $$
CREATE TRIGGER tg_troca_valida
BEFORE INSERT ON troca
FOR EACH ROW
BEGIN
    IF NEW.id_personagem_propoe = NEW.id_personagem_recebe THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Um personagem não pode trocar com ele mesmo';
    END IF;
END $$
DELIMITER ;

-- INSERT INTO troca (id_personagem_propoe, id_personagem_recebe) VALUES (3, 3);
-- ERRO ESPERADO 1644: Um personagem não pode trocar com ele mesmo
INSERT INTO troca (id_personagem_propoe, id_personagem_recebe) VALUES (3, 4);   -- essa passa


-- =====================================================================
-- PASSO 8 | Listar e apagar triggers
-- =====================================================================
SHOW TRIGGERS;
-- DROP TRIGGER tg_vida_maxima;


-- =====================================================================
-- PASSO 9 | EVENT: a agenda do banco
-- =====================================================================
SHOW VARIABLES LIKE 'event_scheduler';   -- tem que estar ON
SET GLOBAL event_scheduler = ON;         -- liga (precisa ser root)

-- Evento que se repete: a cada 1 minuto, todo mundo ferido regenera 10 de vida.
CREATE EVENT ev_regenerar_vida
ON SCHEDULE EVERY 1 MINUTE
DO
    UPDATE personagem SET vida = vida + 10 WHERE vida <= 90;

SELECT nome, vida FROM personagem WHERE vida < 100;   -- rode agora...
-- ...espere 1 minuto e rode de novo: a vida subiu sozinha.

-- Evento de uma vez só: daqui a 1 minuto abre uma missão relâmpago.
CREATE EVENT ev_missao_relampago
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
    INSERT INTO missao (nome, recompensa_base) VALUES ('Missão relâmpago', 300.00);

-- Depois de 1 minuto:
SELECT * FROM missao;     -- a missão relâmpago apareceu (e o evento some sozinho)


-- =====================================================================
-- PASSO 10 | Pausar, listar e apagar eventos
-- =====================================================================
SHOW EVENTS;
ALTER EVENT ev_regenerar_vida DISABLE;   -- pausa (sem apagar)
ALTER EVENT ev_regenerar_vida ENABLE;    -- volta
DROP EVENT ev_regenerar_vida;            -- IMPORTANTE: apague no fim da aula!

-- Para voltar aos dados padrão: rode o 00b de novo.
-- (Functions e triggers continuam no banco. O trigger de histórico vai
--  registrar os UPDATEs de level das próximas atividades — isso é esperado.)


-- =====================================================================
-- RESUMO
-- =====================================================================
--  CREATE FUNCTION nome(p ...) RETURNS tipo DETERMINISTIC|READS SQL DATA
--      BEGIN ... RETURN valor; END            → usa no SELECT / WHERE
--  CREATE TRIGGER nome BEFORE|AFTER INSERT|UPDATE|DELETE ON tabela
--      FOR EACH ROW BEGIN ... END             → roda sozinho a cada linha
--  OLD (antes) · NEW (depois) · SIGNAL SQLSTATE '45000' barra a operação
--  CREATE EVENT nome ON SCHEDULE EVERY n | AT momento DO comando
--  ALTER EVENT ... DISABLE/ENABLE · SHOW TRIGGERS · SHOW EVENTS · DROP ...
-- =====================================================================
