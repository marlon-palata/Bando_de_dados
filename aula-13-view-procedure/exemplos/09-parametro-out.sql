-- 09 | Parâmetro de saída (OUT) e variável
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

DROP PROCEDURE IF EXISTS sp_contar_membros;
DELIMITER $$
CREATE PROCEDURE sp_contar_membros(IN p_id_guilda INT, OUT p_total INT)
BEGIN
    SELECT COUNT(*) INTO p_total            -- INTO guarda o resultado no parâmetro
    FROM personagem
    WHERE id_guilda = p_id_guilda;
END $$
DELIMITER ;

CALL sp_contar_membros(1, @total);          -- @total recebe a resposta
SELECT @total AS membros_da_legiao;         -- 4
