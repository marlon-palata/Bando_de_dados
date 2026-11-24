-- 01 | O problema: dois passos na mão
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- "Quais personagens têm level ACIMA DA MÉDIA?"
SELECT AVG(level) FROM personagem;                  -- 1) descubro: 35.3333
SELECT nome, level FROM personagem WHERE level > 35.3333;   -- 2) copio o número

-- Problema: se alguém subir de level, a média muda e o número copiado fica errado.
