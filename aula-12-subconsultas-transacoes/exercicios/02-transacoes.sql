-- =====================================================================
-- EXERCÍCIO 2 | Transações: COMMIT, ROLLBACK e SAVEPOINT  (Aula 12)
-- Rode o 00b ANTES (dados padrão). Escreva embaixo de cada TODO.
-- Safe Updates: use o id (chave) no WHERE.
-- =====================================================================
USE aetheria_online;

-- TODO 1: abra uma transação, mude o level da Lyria (id 5) para 50,
--         confira com SELECT e DESFAÇA. Confira de novo: qual o level dela?


-- TODO 2: a Sylvara (id 2) vai dar a Poção de mana (item 7) para a Lyria (id 5).
--         Numa transação: mova o item em equipamento E registre a troca
--         (Sylvara propõe, Lyria recebe). Confira e GRAVE.


-- TODO 3: numa transação: dobre a recompensa_base da missão 1,
--         marque um SAVEPOINT chamado depois_do_bonus,
--         zere por engano a recompensa_base da missão 3,
--         volte até o SAVEPOINT e grave.
--         Quanto ficou a missão 1? E a missão 3?


-- TODO 4: rode um ROLLBACK agora. O que aconteceu com as mudanças do TODO 3?
--         Responda em comentário.


-- TODO 5: em 2 linhas de comentário: por que a troca do TODO 2 PRECISA
--         ser uma transação?
