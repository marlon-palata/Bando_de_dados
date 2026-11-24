-- 07 | Transação: o resumo (autocommit)
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- Por padrão o MySQL grava cada comando NA HORA (autocommit = 1).
SELECT @@autocommit;               -- 1

-- START TRANSACTION abre um "rascunho": nada é definitivo até o COMMIT.
START TRANSACTION;
UPDATE personagem SET level = 1 WHERE id_personagem = 1;   -- Kaeldor
SELECT nome, level FROM personagem WHERE id_personagem = 1; -- 1 (só no rascunho)
ROLLBACK;                                                   -- joga o rascunho fora
SELECT nome, level FROM personagem WHERE id_personagem = 1; -- 45 de novo
