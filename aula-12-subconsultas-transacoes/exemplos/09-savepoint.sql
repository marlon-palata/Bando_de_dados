-- 09 | SAVEPOINT: ponto de volta no meio da transação
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

START TRANSACTION;

UPDATE personagem SET vida = 100 WHERE id_personagem = 9;  -- Dravik curado (certo)
SAVEPOINT depois_da_cura;                                   -- marca este ponto

UPDATE personagem SET level = 99 WHERE id_personagem = 9;  -- ops: digitei errado
ROLLBACK TO SAVEPOINT depois_da_cura;                       -- volta SÓ até a marca

COMMIT;                                                     -- grava a cura, sem o 99
SELECT nome, level, vida FROM personagem WHERE id_personagem = 9;   -- Dravik 8, vida 100
