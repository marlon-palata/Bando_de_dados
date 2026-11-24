-- 03 | FUNCTION que consulta uma tabela
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP FUNCTION IF EXISTS fn_ouro_total;   -- permite rodar de novo

DELIMITER $$
CREATE FUNCTION fn_ouro_total(p_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA                   -- lê dados do banco (não é DETERMINISTIC)
BEGIN
    DECLARE v_total DECIMAL(10,2);           -- variável local
    SELECT SUM(recompensa_recebida) INTO v_total
    FROM progresso WHERE id_personagem = p_id;
    RETURN v_total;
END $$
DELIMITER ;

SELECT nome, fn_ouro_total(id_personagem) AS ouro FROM personagem;
-- Quem nunca fez missão aparece com NULL (SUM de nada = NULL).

-- Sem DETERMINISTIC / READS SQL DATA, em servidor com log binário ligado:
-- ERRO 1418: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA...
