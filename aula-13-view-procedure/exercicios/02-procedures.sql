-- =====================================================================
-- EXERCÍCIO 2 | STORED PROCEDURE  (Aula 13)
-- Rode o 00b ANTES (dados padrão). Escreva embaixo de cada TODO.
-- Use o prefixo sp_, comece com DROP PROCEDURE IF EXISTS e lembre do DELIMITER.
-- =====================================================================
USE aetheria_online;

-- TODO 1: crie sp_listar_itens() que mostra nome e tipo de todos os itens,
--         em ordem de tipo. Execute.


-- TODO 2: crie sp_itens_do_personagem(IN p_id INT) que mostra o nome dos
--         itens equipados pelo personagem informado. Execute para o 1 e o 2.


-- TODO 3: crie sp_cadastrar_item(IN p_nome VARCHAR(60), IN p_tipo VARCHAR(30))
--         que insere um item. Cadastre 'Escudo de carvalho' (armadura) e confira.


-- TODO 4: crie sp_ouro_do_personagem(IN p_id INT, OUT p_total DECIMAL(10,2))
--         que devolve a soma da recompensa_recebida do personagem.
--         Execute para o personagem 1 e mostre o resultado. Quanto deu?


-- TODO 5: crie sp_curar(IN p_id INT) que coloca a vida do personagem em 100
--         e mostra nome e vida depois. Cure o Dravik (id 9).


-- TODO 6 (desafio): crie sp_dano(IN p_id INT, IN p_dano INT) que tira p_dano
--         da vida, MAS se o resultado ficar negativo, a vida vira 0.
--         Teste com o Dravik: dano 15 e depois dano 500.
