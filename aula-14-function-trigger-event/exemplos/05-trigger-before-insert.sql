-- 05 | BEFORE INSERT: arrumar o dado antes de gravar
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP TRIGGER IF EXISTS tg_email_minusculo;   -- permite rodar de novo

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
