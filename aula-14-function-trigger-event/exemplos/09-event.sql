-- 09 | EVENT: a agenda do banco
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP EVENT IF EXISTS ev_regenerar_vida;
DROP EVENT IF EXISTS ev_missao_relampago;   -- permite rodar de novo

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
