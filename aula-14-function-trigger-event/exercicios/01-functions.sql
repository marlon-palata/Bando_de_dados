-- =====================================================================
-- EXERCÍCIO 1 | FUNCTION  (Aula 14)
-- Rode o 00b ANTES. Escreva embaixo de cada TODO.
-- Prefixo fn_, comece com DROP FUNCTION IF EXISTS e use DELIMITER.
-- Lembre: DETERMINISTIC (só calcula) ou READS SQL DATA (lê tabela).
-- =====================================================================
USE aetheria_online;

-- TODO 1: crie fn_situacao(p_vida INT) que devolve:
--         'Saudável' se vida >= 80 · 'Ferido' se vida >= 50 · 'Crítico' nos outros casos.
--         Mostre nome, vida e a situação de todos os personagens.


-- TODO 2: usando a fn_situacao no WHERE, mostre só os personagens em
--         situação 'Crítico'. Quem apareceu?


-- TODO 3: crie fn_bonus(p_valor DECIMAL(10,2), p_percentual INT) que devolve
--         o valor com o bônus aplicado (valor + valor × percentual / 100).
--         Mostre o nome das missões e a recompensa com bônus de 15%.


-- TODO 4: crie fn_etiqueta(p_nome VARCHAR(80), p_level INT) que devolve o nome
--         em MAIÚSCULO e o level entre colchetes. Ex.: KAELDOR [45]


-- TODO 5: crie fn_qtd_itens(p_id INT) que devolve QUANTOS itens o personagem
--         tem equipados (consulta a tabela equipamento).
--         Mostre nome e quantidade de itens de cada personagem.
