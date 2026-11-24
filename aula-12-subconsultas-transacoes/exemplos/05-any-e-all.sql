-- 05 | ANY e ALL: comparar com uma lista
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- Levels dos guerreiros: 45, 30, 38, 8, 33
SELECT level FROM personagem
WHERE id_personagem IN (SELECT id_personagem FROM guerreiro);

-- > ALL: maior que TODOS os guerreiros (maior que 45)
SELECT nome, level FROM personagem
WHERE level > ALL (SELECT p.level FROM personagem p
                   INNER JOIN guerreiro g ON p.id_personagem = g.id_personagem);
-- Sylvara 62, Morgana 55, Nyx 50

-- > ANY: maior que PELO MENOS UM guerreiro (maior que 8)
SELECT nome, level FROM personagem
WHERE level > ANY (SELECT p.level FROM personagem p
                   INNER JOIN guerreiro g ON p.id_personagem = g.id_personagem);
-- 11 personagens (só o Dravik, level 8, fica de fora)

-- Curiosidade: "= ANY (lista)" é o mesmo que "IN (lista)".
