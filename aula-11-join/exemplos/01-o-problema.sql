-- 01 | O problema: só aparece o número
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT nome, id_guilda FROM personagem;   -- id_guilda = 1... mas 1 é qual guilda?
SELECT * FROM guilda;                     -- a resposta está em OUTRA tabela
