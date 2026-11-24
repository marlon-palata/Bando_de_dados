-- 06 | BEFORE UPDATE: aplicar uma regra
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP TRIGGER IF EXISTS tg_vida_maxima;   -- permite rodar de novo

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
