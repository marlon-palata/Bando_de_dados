-- 04 | SELECT — lendo o que está gravado
USE aetheria_online;

-- tudo
SELECT * FROM personagem;

-- só as colunas que interessam
SELECT nome, level FROM personagem;

-- apelido na coluna (só muda o cabeçalho do resultado)
SELECT nome AS personagem, level AS nivel FROM personagem;
