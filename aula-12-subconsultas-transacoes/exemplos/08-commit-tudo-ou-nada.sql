-- 08 | COMMIT: tudo ou nada
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- Kaeldor (1) entrega a Poção de vida (item 6) para a Lyria (5).
-- São DOIS comandos que precisam acontecer juntos: mover o item e registrar a troca.
START TRANSACTION;

UPDATE equipamento SET id_personagem = 5
WHERE id_personagem = 1 AND id_item = 6;                    -- 1) o item muda de dono

INSERT INTO troca (id_personagem_propoe, id_personagem_recebe)
VALUES (1, 5);                                              -- 2) registro da troca

SELECT * FROM equipamento WHERE id_item = 6;                -- confere
COMMIT;                                                     -- grava os dois de vez

-- Se o 2) desse erro, o ROLLBACK desfaria o 1): nunca fica "meio feito".
-- Depois do COMMIT, ROLLBACK não desfaz mais nada.
