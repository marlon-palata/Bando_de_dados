-- 08 | Procedure que GRAVA (INSERT com parâmetros)
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

DROP PROCEDURE IF EXISTS sp_cadastrar_jogador;
DELIMITER $$
CREATE PROCEDURE sp_cadastrar_jogador(IN p_nome VARCHAR(80), IN p_email VARCHAR(120))
BEGIN
    INSERT INTO jogador (nome, email) VALUES (p_nome, p_email);
    SELECT LAST_INSERT_ID() AS novo_id;
END $$
DELIMITER ;

CALL sp_cadastrar_jogador('Hugo Prado', 'hugo@pixelforge.com');   -- novo_id 9
-- As travas continuam valendo:
-- CALL sp_cadastrar_jogador('Hugo de novo', 'hugo@pixelforge.com');
-- ERRO ESPERADO 1062: Duplicate entry (UNIQUE do e-mail)
