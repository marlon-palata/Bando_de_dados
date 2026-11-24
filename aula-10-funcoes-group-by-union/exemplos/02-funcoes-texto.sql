-- 02 | Funções de texto (string)
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT CONCAT(nome, ' (lv ', level, ')') AS apresentacao FROM personagem;  -- junta textos
SELECT UPPER(nome) AS maiusculo, LOWER(nome) AS minusculo FROM personagem; -- caixa
SELECT nome, CHAR_LENGTH(nome) AS letras FROM personagem;                  -- tamanho
SELECT nome, SUBSTRING(nome, 1, 3) AS apelido FROM personagem;             -- pedaço (início, quantos)
SELECT email, REPLACE(email, '@pixelforge.com', '@aetheria.gg') AS novo_email FROM jogador;  -- troca
SELECT TRIM('   Kaeldor   ') AS sem_espacos;                               -- tira espaços das pontas
