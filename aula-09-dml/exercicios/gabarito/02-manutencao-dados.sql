-- GABARITO | Exercício 2
-- Safe Updates do Workbench: UPDATE/DELETE só com a CHAVE (id) no WHERE.
-- Vale também: rodar o SELECT, ver o id e digitar o número no WHERE.
USE aetheria_online;

-- 1
SELECT nome, level FROM personagem WHERE level > 30;

-- 2
SELECT nome FROM personagem WHERE id_guilda IS NULL;

-- 3
SELECT nome, level FROM personagem ORDER BY level DESC LIMIT 3;

-- 4
SELECT * FROM personagem WHERE nome = 'Aldric';              -- confere antes
SET @meu = (SELECT id_personagem FROM personagem WHERE nome = 'Aldric');
UPDATE personagem SET level = level + 5 WHERE id_personagem = @meu;

-- 5
SELECT * FROM jogador WHERE nome = 'Marlon Rodrigues';
SET @eu = (SELECT id_jogador FROM jogador WHERE nome = 'Marlon Rodrigues');
UPDATE jogador SET email = 'marlon.r@pixelforge.com' WHERE id_jogador = @eu;

-- 6
SELECT * FROM item WHERE nome = 'Elmo de bronze';
SET @item = (SELECT id_item FROM item WHERE nome = 'Elmo de bronze');
DELETE FROM item WHERE id_item = @item;

-- 7  ERRO 1451 (cannot delete or update a parent row): a FK protege o pai
--    enquanto existir uma linha filha apontando para ele.
DELETE FROM jogador WHERE id_jogador = @eu;
