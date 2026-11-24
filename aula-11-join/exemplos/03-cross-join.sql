-- 03 | CROSS JOIN: todas as combinações
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT COUNT(*) FROM personagem CROSS JOIN guilda;  -- 12 × 4 = 48 linhas
SELECT personagem.nome, guilda.nome
FROM personagem CROSS JOIN guilda;                  -- cada personagem com CADA guilda

-- É o que acontece quando você ESQUECE a condição do WHERE no passo 2:
SELECT COUNT(*) FROM personagem, guilda;            -- 48 de novo (produto cartesiano)
