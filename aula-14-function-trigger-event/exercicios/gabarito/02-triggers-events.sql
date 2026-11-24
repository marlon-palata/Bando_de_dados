-- GABARITO | Exercício 2  (rode o 00b antes)
USE aetheria_online;
SET NAMES utf8mb4;
CREATE TABLE IF NOT EXISTS auditoria_jogador (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    acao         VARCHAR(30) NOT NULL,
    nome_jogador VARCHAR(80) NOT NULL,
    data_acao    DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- 1
DROP TRIGGER IF EXISTS tg_auditoria_jogador;
DELIMITER $$
CREATE TRIGGER tg_auditoria_jogador
AFTER INSERT ON jogador
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_jogador (acao, nome_jogador) VALUES ('novo jogador', NEW.nome);
END $$
DELIMITER ;
INSERT INTO jogador (nome, email) VALUES ('Lara Teles', 'lara@pixelforge.com');
SELECT * FROM auditoria_jogador;
-- 2  recompensa_base = 0.00
DROP TRIGGER IF EXISTS tg_missao_sem_negativo;
DELIMITER $$
CREATE TRIGGER tg_missao_sem_negativo
BEFORE INSERT ON missao
FOR EACH ROW
BEGIN
    IF NEW.recompensa_base < 0 THEN
        SET NEW.recompensa_base = 0;
    END IF;
END $$
DELIMITER ;
INSERT INTO missao (nome, recompensa_base) VALUES ('Missão bugada', -100);
SELECT nome, recompensa_base FROM missao WHERE nome = 'Missão bugada';
-- 3  jogador, missao (+ personagem e troca se o live coding foi rodado)
SHOW TRIGGERS;
-- 4
DROP EVENT IF EXISTS ev_evento_de_fim_de_semana;
CREATE EVENT ev_evento_de_fim_de_semana
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
    INSERT INTO missao (nome, recompensa_base) VALUES ('Invasão de goblins', 600.00);
-- depois de 1 minuto:
SELECT * FROM missao WHERE nome = 'Invasão de goblins';
-- 5
DROP EVENT IF EXISTS ev_desgaste;
CREATE EVENT ev_desgaste
ON SCHEDULE EVERY 1 MINUTE
DO
    UPDATE equipamento SET durabilidade_atual = durabilidade_atual - 5
    WHERE durabilidade_atual > 5;
-- depois de 1 minuto: SELECT * FROM equipamento;  (tudo 5 a menos)
ALTER EVENT ev_desgaste DISABLE;
SHOW EVENTS;
DROP EVENT ev_desgaste;
-- 6  item 1 → ERRO 1644 'Item em uso...' · item 8 → apagado
DROP TRIGGER IF EXISTS tg_item_em_uso;
DELIMITER $$
CREATE TRIGGER tg_item_em_uso
BEFORE DELETE ON item
FOR EACH ROW
BEGIN
    DECLARE v_qtd INT;
    SELECT COUNT(*) INTO v_qtd FROM equipamento WHERE id_item = OLD.id_item;
    IF v_qtd > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Item em uso: não pode ser apagado';
    END IF;
END $$
DELIMITER ;
DELETE FROM item WHERE id_item = 1;   -- ERRO 1644
DELETE FROM item WHERE id_item = 8;   -- apaga o Anel do dragão
