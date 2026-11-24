-- GABARITO | Exercício 2  (rode o 00b antes)
USE aetheria_online;
-- 1  no fim, level 12 (o ROLLBACK desfez)
START TRANSACTION;
UPDATE personagem SET level = 50 WHERE id_personagem = 5;
SELECT nome, level FROM personagem WHERE id_personagem = 5;   -- 50
ROLLBACK;
SELECT nome, level FROM personagem WHERE id_personagem = 5;   -- 12
-- 2
START TRANSACTION;
UPDATE equipamento SET id_personagem = 5 WHERE id_personagem = 2 AND id_item = 7;
INSERT INTO troca (id_personagem_propoe, id_personagem_recebe) VALUES (2, 5);
SELECT * FROM equipamento WHERE id_item = 7;
COMMIT;
-- 3  missão 1 = 100.00 · missão 3 = 25.50
START TRANSACTION;
UPDATE missao SET recompensa_base = recompensa_base * 2 WHERE id_missao = 1;
SAVEPOINT depois_do_bonus;
UPDATE missao SET recompensa_base = 0 WHERE id_missao = 3;
ROLLBACK TO SAVEPOINT depois_do_bonus;
COMMIT;
SELECT id_missao, nome, recompensa_base FROM missao WHERE id_missao IN (1, 3);
-- 4  nada: o COMMIT do TODO 3 já gravou. ROLLBACK depois do COMMIT não desfaz.
ROLLBACK;
-- 5  (resposta esperada) São dois comandos que só fazem sentido juntos. Se o item
--    mudar de dono e o registro da troca falhar (ou o contrário), o jogo fica
--    inconsistente. A transação garante tudo ou nada.
