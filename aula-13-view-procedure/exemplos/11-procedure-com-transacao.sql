-- 11 | Procedure com transação (a troca da aula 12, guardada)
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

DROP PROCEDURE IF EXISTS sp_trocar_item;
DELIMITER $$
CREATE PROCEDURE sp_trocar_item(IN p_de INT, IN p_para INT, IN p_item INT)
BEGIN
    START TRANSACTION;
    UPDATE equipamento SET id_personagem = p_para
    WHERE id_personagem = p_de AND id_item = p_item;
    INSERT INTO troca (id_personagem_propoe, id_personagem_recebe) VALUES (p_de, p_para);
    COMMIT;
    SELECT * FROM equipamento WHERE id_item = p_item;
END $$
DELIMITER ;

CALL sp_trocar_item(1, 5, 6);   -- Kaeldor dá a Poção de vida para a Lyria
