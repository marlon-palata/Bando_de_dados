-- 07 | SIGNAL: o trigger que BARRA a operação
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP TRIGGER IF EXISTS tg_troca_valida;   -- permite rodar de novo

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
