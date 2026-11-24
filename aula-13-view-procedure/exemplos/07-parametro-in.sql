-- 07 | Parâmetro de entrada (IN)
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

DROP PROCEDURE IF EXISTS sp_membros_da_guilda;
DELIMITER $$
CREATE PROCEDURE sp_membros_da_guilda(IN p_id_guilda INT)
BEGIN
    SELECT nome, level
    FROM personagem
    WHERE id_guilda = p_id_guilda
    ORDER BY level DESC;
END $$
DELIMITER ;

CALL sp_membros_da_guilda(1);     -- Legião de Ferro
CALL sp_membros_da_guilda(2);     -- Ordem Arcana
