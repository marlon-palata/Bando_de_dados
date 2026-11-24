-- 05 | WHERE — filtrando linhas
USE aetheria_online;

-- igual
SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- maior que
SELECT nome, level FROM personagem WHERE level > 40;

-- faixa de valores
SELECT nome, level FROM personagem WHERE level BETWEEN 20 AND 50;

-- lista de valores
SELECT nome FROM personagem WHERE id_jogador IN (1, 2, 3);

-- começa com "Kael" (% = qualquer coisa depois)
SELECT nome FROM personagem WHERE nome LIKE 'Kael%';

-- sem guilda: para NULL use IS NULL, nunca = NULL
SELECT nome FROM personagem WHERE id_guilda IS NULL;

-- duas condições ao mesmo tempo
SELECT nome FROM personagem WHERE level > 20 AND id_guilda IS NOT NULL;
