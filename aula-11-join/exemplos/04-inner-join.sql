-- 04 | INNER JOIN ... ON
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- ON = a condição de ligação (FK = PK). Fica separada do WHERE.
SELECT personagem.nome, guilda.nome
FROM personagem
INNER JOIN guilda ON personagem.id_guilda = guilda.id_guilda;   -- 9 linhas

-- Apelidos (alias) deixam curto: p = personagem, g = guilda
SELECT p.nome AS personagem, g.nome AS guilda, g.cidade
FROM personagem p
INNER JOIN guilda g ON p.id_guilda = g.id_guilda
ORDER BY g.nome;

-- Sem dizer de qual tabela é a coluna "nome":
-- SELECT nome FROM personagem p INNER JOIN guilda g ON p.id_guilda = g.id_guilda;
-- ERRO ESPERADO 1052: Column 'nome' in field list is ambiguous

-- O INNER só traz quem TEM par: os 3 personagens sem guilda e o Clã dos Ventos sumiram.
