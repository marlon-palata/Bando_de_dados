-- 01 | FUNCTION: a primeira função
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP FUNCTION IF EXISTS fn_classe;   -- permite rodar de novo

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
