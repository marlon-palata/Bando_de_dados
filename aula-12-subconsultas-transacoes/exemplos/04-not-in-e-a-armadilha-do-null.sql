-- 04 | NOT IN: quem NÃO está na lista
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

SELECT nome
FROM jogador
WHERE id_jogador NOT IN (SELECT id_jogador FROM personagem);   -- Gabriela Alves

-- ARMADILHA: NOT IN com NULL na lista
SELECT nome
FROM guilda
WHERE id_guilda NOT IN (SELECT id_guilda FROM personagem);     -- VAZIO! Cadê o Clã dos Ventos?
-- A lista tem NULL (personagens sem guilda). "x NOT IN (1, 2, NULL)" nunca dá verdadeiro.

-- Correção: tire o NULL da lista
SELECT nome
FROM guilda
WHERE id_guilda NOT IN (SELECT id_guilda FROM personagem
                        WHERE id_guilda IS NOT NULL);           -- Clã dos Ventos
