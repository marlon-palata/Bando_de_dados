-- 10 | Regra de negócio: IF dentro da procedure
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

-- Subir de level, mas só se a quantidade for positiva.
DROP PROCEDURE IF EXISTS sp_subir_level;
DELIMITER $$
CREATE PROCEDURE sp_subir_level(IN p_id INT, IN p_qtd INT)
BEGIN
    IF p_qtd <= 0 THEN
        SELECT 'Quantidade inválida: use um número maior que zero' AS aviso;
    ELSE
        UPDATE personagem SET level = level + p_qtd WHERE id_personagem = p_id;
        SELECT nome, level FROM personagem WHERE id_personagem = p_id;
    END IF;
END $$
DELIMITER ;

CALL sp_subir_level(9, 2);      -- Dravik: 8 → 10
CALL sp_subir_level(9, -5);     -- aviso, nada muda
