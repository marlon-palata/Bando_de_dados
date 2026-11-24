-- GABARITO | Exercício 2  (rode o 00b antes)
USE aetheria_online;
-- 1
DROP PROCEDURE IF EXISTS sp_listar_itens;
DELIMITER $$
CREATE PROCEDURE sp_listar_itens()
BEGIN
    SELECT nome, tipo FROM item ORDER BY tipo;
END $$
DELIMITER ;
CALL sp_listar_itens();
-- 2  personagem 1: Espada de ferro, Elmo de bronze, Poção de vida · personagem 2: Cajado de cristal, Poção de mana
DROP PROCEDURE IF EXISTS sp_itens_do_personagem;
DELIMITER $$
CREATE PROCEDURE sp_itens_do_personagem(IN p_id INT)
BEGIN
    SELECT i.nome
    FROM equipamento e
    INNER JOIN item i ON e.id_item = i.id_item
    WHERE e.id_personagem = p_id;
END $$
DELIMITER ;
CALL sp_itens_do_personagem(1);
CALL sp_itens_do_personagem(2);
-- 3
DROP PROCEDURE IF EXISTS sp_cadastrar_item;
DELIMITER $$
CREATE PROCEDURE sp_cadastrar_item(IN p_nome VARCHAR(60), IN p_tipo VARCHAR(30))
BEGIN
    INSERT INTO item (nome, tipo) VALUES (p_nome, p_tipo);
END $$
DELIMITER ;
CALL sp_cadastrar_item('Escudo de carvalho', 'armadura');
SELECT * FROM item WHERE nome = 'Escudo de carvalho';
-- 4  1550.00
DROP PROCEDURE IF EXISTS sp_ouro_do_personagem;
DELIMITER $$
CREATE PROCEDURE sp_ouro_do_personagem(IN p_id INT, OUT p_total DECIMAL(10,2))
BEGIN
    SELECT SUM(recompensa_recebida) INTO p_total
    FROM progresso WHERE id_personagem = p_id;
END $$
DELIMITER ;
CALL sp_ouro_do_personagem(1, @ouro);
SELECT @ouro;
-- 5  Dravik vida 100
DROP PROCEDURE IF EXISTS sp_curar;
DELIMITER $$
CREATE PROCEDURE sp_curar(IN p_id INT)
BEGIN
    UPDATE personagem SET vida = 100 WHERE id_personagem = p_id;
    SELECT nome, vida FROM personagem WHERE id_personagem = p_id;
END $$
DELIMITER ;
CALL sp_curar(9);
-- 6  dano 15: 100 → 85 · dano 500: vira 0
DROP PROCEDURE IF EXISTS sp_dano;
DELIMITER $$
CREATE PROCEDURE sp_dano(IN p_id INT, IN p_dano INT)
BEGIN
    UPDATE personagem SET vida = vida - p_dano WHERE id_personagem = p_id AND vida - p_dano >= 0;
    UPDATE personagem SET vida = 0 WHERE id_personagem = p_id AND vida - p_dano < 0;
    SELECT nome, vida FROM personagem WHERE id_personagem = p_id;
END $$
DELIMITER ;
CALL sp_dano(9, 15);
CALL sp_dano(9, 500);
