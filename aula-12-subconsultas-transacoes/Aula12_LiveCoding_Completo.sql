-- =====================================================================
--  AULA 12 | SUBCONSULTAS e TRANSAÇÕES (TCL)  (LIVE CODING)
--  Banco: aetheria_online  ·  Antes: rode o 00b (dados padrão)
--  Rode BLOCO A BLOCO: selecione o comando + Ctrl+Enter.
-- =====================================================================
--  Parte 1: um SELECT DENTRO de outro SELECT (subconsulta).
--  Parte 2: um grupo de comandos que vale TUDO ou NADA (transação).
-- =====================================================================


-- =====================================================================
-- PASSO 0 | Conferir os dados
-- =====================================================================
USE aetheria_online;
SET NAMES utf8mb4;
SELECT COUNT(*) FROM personagem;   -- 12
SELECT COUNT(*) FROM guilda;       -- 4


-- =====================================================================
-- PASSO 1 | O problema: dois passos na mão
-- =====================================================================
-- "Quais personagens têm level ACIMA DA MÉDIA?"
SELECT AVG(level) FROM personagem;                  -- 1) descubro: 35.3333
SELECT nome, level FROM personagem WHERE level > 35.3333;   -- 2) copio o número

-- Problema: se alguém subir de level, a média muda e o número copiado fica errado.


-- =====================================================================
-- PASSO 2 | Subconsulta que devolve UM valor (escalar)
-- =====================================================================
-- O SELECT de dentro roda primeiro e entrega o número para o de fora.
SELECT nome, level
FROM personagem
WHERE level > (SELECT AVG(level) FROM personagem);   -- 6 personagens

-- O personagem de maior level
SELECT nome, level
FROM personagem
WHERE level = (SELECT MAX(level) FROM personagem);   -- Sylvara 62

-- Subconsulta escalar também cabe no SELECT (uma coluna calculada)
SELECT nome, level,
       (SELECT ROUND(AVG(level), 1) FROM personagem) AS media_geral
FROM personagem;


-- =====================================================================
-- PASSO 3 | IN: a subconsulta devolve uma LISTA
-- =====================================================================
-- Quem concluiu a missão 2 (Caçada ao dragão)?
SELECT nome
FROM personagem
WHERE id_personagem IN (SELECT id_personagem
                        FROM progresso
                        WHERE id_missao = 2 AND data_conclusao IS NOT NULL);
-- Kaeldor, Sylvara, Nyx

-- Subconsulta dentro de subconsulta: pela missão pelo NOME
SELECT nome
FROM personagem
WHERE id_personagem IN (SELECT id_personagem FROM progresso
                        WHERE data_conclusao IS NOT NULL
                          AND id_missao = (SELECT id_missao FROM missao
                                           WHERE nome = 'Caçada ao dragão'));

-- Se a subconsulta devolver mais de um valor e você usar "=" em vez de IN:
-- SELECT nome FROM personagem WHERE id_personagem = (SELECT id_personagem FROM progresso);
-- ERRO ESPERADO 1242: Subquery returns more than 1 row


-- =====================================================================
-- PASSO 4 | NOT IN: quem NÃO está na lista
-- =====================================================================
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


-- =====================================================================
-- PASSO 5 | ANY e ALL: comparar com uma lista
-- =====================================================================
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


-- =====================================================================
-- PASSO 6 | EXISTS: existe pelo menos uma linha?
-- =====================================================================
-- Jogadores que TÊM conta premium
SELECT j.nome
FROM jogador j
WHERE EXISTS (SELECT 1 FROM conta_premium c
              WHERE c.id_jogador = j.id_jogador);              -- Rafael, Ayla, Diego

-- NOT EXISTS: guildas sem membros (aqui o NULL não atrapalha)
SELECT g.nome
FROM guilda g
WHERE NOT EXISTS (SELECT 1 FROM personagem p
                  WHERE p.id_guilda = g.id_guilda);             -- Clã dos Ventos

-- A subconsulta usa "j" e "g" de fora: ela roda uma vez para CADA linha de fora.


-- =====================================================================
-- PASSO 7 | Transação: o resumo (autocommit)
-- =====================================================================
-- Por padrão o MySQL grava cada comando NA HORA (autocommit = 1).
SELECT @@autocommit;               -- 1

-- START TRANSACTION abre um "rascunho": nada é definitivo até o COMMIT.
START TRANSACTION;
UPDATE personagem SET level = 1 WHERE id_personagem = 1;   -- Kaeldor
SELECT nome, level FROM personagem WHERE id_personagem = 1; -- 1 (só no rascunho)
ROLLBACK;                                                   -- joga o rascunho fora
SELECT nome, level FROM personagem WHERE id_personagem = 1; -- 45 de novo


-- =====================================================================
-- PASSO 8 | COMMIT: tudo ou nada
-- =====================================================================
-- Kaeldor (1) entrega a Poção de vida (item 6) para a Lyria (5).
-- São DOIS comandos que precisam acontecer juntos: mover o item e registrar a troca.
START TRANSACTION;

UPDATE equipamento SET id_personagem = 5
WHERE id_personagem = 1 AND id_item = 6;                    -- 1) o item muda de dono

INSERT INTO troca (id_personagem_propoe, id_personagem_recebe)
VALUES (1, 5);                                              -- 2) registro da troca

SELECT * FROM equipamento WHERE id_item = 6;                -- confere
COMMIT;                                                     -- grava os dois de vez

-- Se o 2) desse erro, o ROLLBACK desfaria o 1): nunca fica "meio feito".
-- Depois do COMMIT, ROLLBACK não desfaz mais nada.


-- =====================================================================
-- PASSO 9 | SAVEPOINT: ponto de volta no meio da transação
-- =====================================================================
START TRANSACTION;

UPDATE personagem SET vida = 100 WHERE id_personagem = 9;  -- Dravik curado (certo)
SAVEPOINT depois_da_cura;                                   -- marca este ponto

UPDATE personagem SET level = 99 WHERE id_personagem = 9;  -- ops: digitei errado
ROLLBACK TO SAVEPOINT depois_da_cura;                       -- volta SÓ até a marca

COMMIT;                                                     -- grava a cura, sem o 99
SELECT nome, level, vida FROM personagem WHERE id_personagem = 9;   -- Dravik 8, vida 100


-- =====================================================================
-- PASSO 10 | Cuidados com transação
-- =====================================================================
-- 1) CREATE, ALTER e DROP (DDL) fazem COMMIT sozinhos: não dá ROLLBACK neles.
-- 2) Transação aberta e esquecida segura as linhas: sempre termine com COMMIT ou ROLLBACK.
-- 3) Só funciona em tabela InnoDB (o padrão do MySQL 8).

-- Para voltar aos dados padrão depois desta aula: rode o 00b de novo.


-- =====================================================================
-- RESUMO
-- =====================================================================
--  WHERE x > (SELECT AVG...)      subconsulta escalar (1 valor)
--  IN / NOT IN (SELECT ...)       lista (cuidado: NOT IN + NULL = vazio)
--  > ALL / > ANY (SELECT ...)     maior que todos / que pelo menos um
--  EXISTS / NOT EXISTS            existe (ou não) alguma linha relacionada
--  START TRANSACTION              abre o rascunho
--  COMMIT / ROLLBACK              grava / descarta tudo
--  SAVEPOINT nome · ROLLBACK TO SAVEPOINT nome   volta só até a marca
-- =====================================================================
