-- 06 | STORED PROCEDURE: a primeira rotina
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

-- DELIMITER troca o ";" por "$$" só enquanto criamos a procedure,
-- porque dentro dela existem vários ";".
DROP PROCEDURE IF EXISTS sp_listar_missoes;
DELIMITER $$
CREATE PROCEDURE sp_listar_missoes()
BEGIN
    SELECT nome, recompensa_base
    FROM missao
    ORDER BY recompensa_base DESC;
END $$
DELIMITER ;

CALL sp_listar_missoes();         -- CALL executa a procedure
