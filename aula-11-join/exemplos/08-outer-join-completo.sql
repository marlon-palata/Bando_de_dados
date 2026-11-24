-- 08 | OUTER JOIN completo: LEFT + RIGHT com UNION
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- O MySQL não tem FULL OUTER JOIN. Monta-se juntando os dois lados:
SELECT p.nome AS personagem, g.nome AS guilda
FROM personagem p LEFT JOIN guilda g ON p.id_guilda = g.id_guilda
UNION
SELECT p.nome, g.nome
FROM personagem p RIGHT JOIN guilda g ON p.id_guilda = g.id_guilda;
-- 13 linhas: personagens sem guilda E a guilda sem personagem

-- LEFT JOIN e RIGHT JOIN também se chamam LEFT OUTER JOIN e RIGHT OUTER JOIN.
