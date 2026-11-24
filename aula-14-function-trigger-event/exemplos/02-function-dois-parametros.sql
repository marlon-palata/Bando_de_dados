-- 02 | FUNCTION com dois parâmetros
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP FUNCTION IF EXISTS fn_xp_por_level;   -- permite rodar de novo

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
