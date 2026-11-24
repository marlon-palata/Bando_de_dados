-- GABARITO | Exercício 1  (rode o 00b antes)
USE aetheria_online;
SET NAMES utf8mb4;
-- 1
DROP FUNCTION IF EXISTS fn_situacao;
DELIMITER $$
CREATE FUNCTION fn_situacao(p_vida INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_vida >= 80 THEN
        RETURN 'Saudável';
    ELSEIF p_vida >= 50 THEN
        RETURN 'Ferido';
    ELSE
        RETURN 'Crítico';
    END IF;
END $$
DELIMITER ;
SELECT nome, vida, fn_situacao(vida) AS situacao FROM personagem;
-- 2  Dravik (vida 40)
SELECT nome, vida FROM personagem WHERE fn_situacao(vida) = 'Crítico';
-- 3  Patrulha 57.50 · Caçada 1725.00 · Entrega 29.33 · Ruínas 460.00 · Defesa 977.50 · Tesouro 2300.00
DROP FUNCTION IF EXISTS fn_bonus;
DELIMITER $$
CREATE FUNCTION fn_bonus(p_valor DECIMAL(10,2), p_percentual INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_valor + p_valor * p_percentual / 100;
END $$
DELIMITER ;
SELECT nome, fn_bonus(recompensa_base, 15) AS com_bonus FROM missao;
-- 4
DROP FUNCTION IF EXISTS fn_etiqueta;
DELIMITER $$
CREATE FUNCTION fn_etiqueta(p_nome VARCHAR(80), p_level INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(UPPER(p_nome), ' [', p_level, ']');
END $$
DELIMITER ;
SELECT fn_etiqueta(nome, level) AS etiqueta FROM personagem;
-- 5  Kaeldor 3 · Sylvara 2 · ... · Lyria 0
DROP FUNCTION IF EXISTS fn_qtd_itens;
DELIMITER $$
CREATE FUNCTION fn_qtd_itens(p_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_qtd INT;
    SELECT COUNT(*) INTO v_qtd FROM equipamento WHERE id_personagem = p_id;
    RETURN v_qtd;
END $$
DELIMITER ;
SELECT nome, fn_qtd_itens(id_personagem) AS itens FROM personagem;
