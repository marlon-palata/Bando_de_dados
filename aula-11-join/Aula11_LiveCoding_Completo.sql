-- =====================================================================
--  AULA 11 | ASSOCIAÇÃO DE TABELAS — JOIN  (LIVE CODING)
--  Banco: aetheria_online  ·  Antes: rode 00a (se precisar) e 00b (dados)
--  Rode BLOCO A BLOCO: selecione o comando + Ctrl+Enter.
-- =====================================================================
--  Até agora cada SELECT olhava UMA tabela. Mas o nome da guilda está em
--  "guilda" e o personagem está em "personagem". O JOIN junta as duas
--  usando a FOREIGN KEY que criamos na aula 7.
-- =====================================================================


-- =====================================================================
-- PASSO 0 | Conferir os dados
-- =====================================================================
USE aetheria_online;
SELECT COUNT(*) FROM personagem;   -- 12
SELECT COUNT(*) FROM guilda;       -- 4  (o Clã dos Ventos ainda não tem membros)


-- =====================================================================
-- PASSO 1 | O problema: só aparece o número
-- =====================================================================
SELECT nome, id_guilda FROM personagem;   -- id_guilda = 1... mas 1 é qual guilda?
SELECT * FROM guilda;                     -- a resposta está em OUTRA tabela


-- =====================================================================
-- PASSO 2 | Associação pelo WHERE (o jeito antigo)
-- =====================================================================
-- Duas tabelas no FROM + a condição que liga a FK à PK no WHERE.
SELECT personagem.nome, guilda.nome
FROM personagem, guilda
WHERE personagem.id_guilda = guilda.id_guilda;      -- 9 linhas

-- Funciona, mas mistura "ligar tabelas" com "filtrar linhas" no mesmo WHERE.


-- =====================================================================
-- PASSO 3 | CROSS JOIN: todas as combinações
-- =====================================================================
SELECT COUNT(*) FROM personagem CROSS JOIN guilda;  -- 12 × 4 = 48 linhas
SELECT personagem.nome, guilda.nome
FROM personagem CROSS JOIN guilda;                  -- cada personagem com CADA guilda

-- É o que acontece quando você ESQUECE a condição do WHERE no passo 2:
SELECT COUNT(*) FROM personagem, guilda;            -- 48 de novo (produto cartesiano)


-- =====================================================================
-- PASSO 4 | INNER JOIN ... ON
-- =====================================================================
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


-- =====================================================================
-- PASSO 5 | INNER JOIN com 3 tabelas (ou mais)
-- =====================================================================
-- Personagem + dono (jogador) + guilda
SELECT p.nome AS personagem, j.nome AS jogador, g.nome AS guilda
FROM personagem p
INNER JOIN jogador j ON p.id_jogador = j.id_jogador
INNER JOIN guilda  g ON p.id_guilda  = g.id_guilda;

-- O que cada personagem está usando (equipamento liga personagem e item)
SELECT p.nome AS personagem, i.nome AS item, e.durabilidade_atual
FROM equipamento e
INNER JOIN personagem p ON e.id_personagem = p.id_personagem
INNER JOIN item       i ON e.id_item       = i.id_item
ORDER BY p.nome;

-- JOIN + WHERE: o ON liga, o WHERE filtra
SELECT p.nome, i.nome AS item
FROM equipamento e
INNER JOIN personagem p ON e.id_personagem = p.id_personagem
INNER JOIN item       i ON e.id_item       = i.id_item
WHERE i.tipo = 'poção';


-- =====================================================================
-- PASSO 6 | LEFT JOIN: todos da ESQUERDA, com ou sem par
-- =====================================================================
SELECT p.nome AS personagem, g.nome AS guilda
FROM personagem p                       -- esquerda: TODOS os personagens
LEFT JOIN guilda g ON p.id_guilda = g.id_guilda;   -- 12 linhas, sem guilda = NULL

-- Quem NÃO tem par: LEFT JOIN + IS NULL
SELECT j.nome AS jogador_sem_personagem
FROM jogador j
LEFT JOIN personagem p ON j.id_jogador = p.id_jogador
WHERE p.id_personagem IS NULL;          -- Gabriela Alves

SELECT i.nome AS item_nunca_usado
FROM item i
LEFT JOIN equipamento e ON i.id_item = e.id_item
WHERE e.id_item IS NULL;                -- Anel do dragão


-- =====================================================================
-- PASSO 7 | RIGHT JOIN: todos da DIREITA
-- =====================================================================
SELECT p.nome AS personagem, g.nome AS guilda
FROM personagem p
RIGHT JOIN guilda g ON p.id_guilda = g.id_guilda;  -- todas as guildas: Clã dos Ventos com NULL

-- É o LEFT ao contrário. Estas duas dão o mesmo resultado:
--   FROM personagem p RIGHT JOIN guilda g ...
--   FROM guilda g LEFT JOIN personagem p ...
-- Na prática quase todo mundo escreve LEFT e só troca a ordem das tabelas.


-- =====================================================================
-- PASSO 8 | OUTER JOIN completo: LEFT + RIGHT com UNION
-- =====================================================================
-- O MySQL não tem FULL OUTER JOIN. Monta-se juntando os dois lados:
SELECT p.nome AS personagem, g.nome AS guilda
FROM personagem p LEFT JOIN guilda g ON p.id_guilda = g.id_guilda
UNION
SELECT p.nome, g.nome
FROM personagem p RIGHT JOIN guilda g ON p.id_guilda = g.id_guilda;
-- 13 linhas: personagens sem guilda E a guilda sem personagem

-- LEFT JOIN e RIGHT JOIN também se chamam LEFT OUTER JOIN e RIGHT OUTER JOIN.


-- =====================================================================
-- PASSO 9 | A mesma tabela duas vezes (troca: quem propõe × quem recebe)
-- =====================================================================
SELECT t.id_troca,
       DATE_FORMAT(t.data_troca, '%d/%m/%Y') AS data,
       propoe.nome  AS quem_propoe,
       recebe.nome  AS quem_recebe
FROM troca t
INNER JOIN personagem propoe ON t.id_personagem_propoe = propoe.id_personagem
INNER JOIN personagem recebe ON t.id_personagem_recebe = recebe.id_personagem;


-- =====================================================================
-- PASSO 10 | JOIN + GROUP BY (a aula 10 com nomes de verdade)
-- =====================================================================
-- Membros por guilda, com o NOME e incluindo a guilda vazia
SELECT g.nome AS guilda, COUNT(p.id_personagem) AS membros   -- COUNT(coluna): ignora NULL → 0
FROM guilda g
LEFT JOIN personagem p ON g.id_guilda = p.id_guilda
GROUP BY g.nome
ORDER BY membros DESC;

-- Ouro recebido por missão, com o nome da missão
SELECT m.nome AS missao, SUM(pr.recompensa_recebida) AS ouro_pago
FROM progresso pr
INNER JOIN missao m ON pr.id_missao = m.id_missao
GROUP BY m.nome
ORDER BY ouro_pago DESC;


-- =====================================================================
-- RESUMO
-- =====================================================================
--  FROM a, b WHERE a.fk = b.pk   associação pelo WHERE (antigo)
--  CROSS JOIN                    todas as combinações (a × b)
--  INNER JOIN ... ON             só quem tem par nos dois lados
--  LEFT  JOIN ... ON             todos da esquerda (+ NULL onde não tem par)
--  RIGHT JOIN ... ON             todos da direita
--  LEFT ... UNION ... RIGHT      OUTER completo (MySQL não tem FULL)
--  LEFT JOIN + IS NULL           quem NÃO tem par
--  Alias (p, g) + tabela.coluna  evita o erro 1052 (coluna ambígua)
-- =====================================================================
