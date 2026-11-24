-- 09 | Transação: desfazer um UPDATE/DELETE errado
USE aetheria_online;

START TRANSACTION;

UPDATE personagem SET level = 1;          -- erro de propósito: sem WHERE

SELECT nome, level FROM personagem;       -- todo mundo level 1

ROLLBACK;                                 -- desfaz tudo desde o START TRANSACTION

SELECT nome, level FROM personagem;       -- voltou ao normal

-- COMMIT no lugar do ROLLBACK grava de vez (aí não tem mais volta)
