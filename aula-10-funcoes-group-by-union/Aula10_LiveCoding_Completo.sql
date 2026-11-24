-- =====================================================================
--  AULA 10 | OPERADORES, FUNÇÕES, GROUP BY e UNION  (LIVE CODING)
--  Banco: aetheria_online  ·  Antes: rode 00a (estrutura) e 00b (dados)
--  Rode BLOCO A BLOCO: selecione o comando + Ctrl+Enter.
-- =====================================================================
--  Na aula 9 o SELECT só MOSTRAVA o que estava gravado.
--  Hoje ele vai CALCULAR, TRANSFORMAR e RESUMIR — sem mudar nada na tabela.
-- =====================================================================


-- =====================================================================
-- PASSO 0 | Conferir os dados
-- =====================================================================
USE aetheria_online;
SELECT COUNT(*) FROM personagem;   -- 12. Se não der 12, rode o 00b-dados-aetheria.sql


-- =====================================================================
-- PASSO 1 | Operadores aritméticos  ( +  -  *  /  % )
-- =====================================================================
-- A conta acontece no RESULTADO. A tabela continua igual.
SELECT nome, level, level + 1 AS proximo_level FROM personagem;

SELECT nome, recompensa_base,
       recompensa_base * 2   AS evento_em_dobro,     -- multiplicação
       recompensa_base / 2   AS dividido_em_dupla    -- divisão
FROM missao;

SELECT nome, experiencia, experiencia % 1000 AS sobra_do_milhar FROM personagem;  -- resto

-- Operador dentro do WHERE: personagens com menos da metade da vida
SELECT nome, vida FROM personagem WHERE vida < 100 / 2;


-- =====================================================================
-- PASSO 2 | Funções de texto (string)
-- =====================================================================
SELECT CONCAT(nome, ' (lv ', level, ')') AS apresentacao FROM personagem;  -- junta textos
SELECT UPPER(nome) AS maiusculo, LOWER(nome) AS minusculo FROM personagem; -- caixa
SELECT nome, CHAR_LENGTH(nome) AS letras FROM personagem;                  -- tamanho
SELECT nome, SUBSTRING(nome, 1, 3) AS apelido FROM personagem;             -- pedaço (início, quantos)
SELECT email, REPLACE(email, '@pixelforge.com', '@aetheria.gg') AS novo_email FROM jogador;  -- troca
SELECT TRIM('   Kaeldor   ') AS sem_espacos;                               -- tira espaços das pontas


-- =====================================================================
-- PASSO 3 | Funções matemáticas
-- =====================================================================
SELECT nome, experiencia / level AS xp_por_level,
       ROUND(experiencia / level, 1) AS arredondado,    -- 1 casa decimal
       CEIL(experiencia / level)     AS para_cima,      -- teto
       FLOOR(experiencia / level)    AS para_baixo      -- piso
FROM personagem;

SELECT ABS(25 - 40) AS distancia_de_level;   -- valor absoluto (sem sinal): 15
SELECT MOD(17, 5)   AS resto;                -- o mesmo que 17 % 5 = 2


-- =====================================================================
-- PASSO 4 | Funções de data e hora
-- =====================================================================
SELECT NOW()     AS agora;       -- data + hora do servidor
SELECT CURDATE() AS hoje;        -- só a data

SELECT id_jogador, data_assinatura,
       YEAR(data_assinatura)  AS ano,
       MONTH(data_assinatura) AS mes,
       DATEDIFF(CURDATE(), data_assinatura) AS dias_de_premium   -- muda a cada dia!
FROM conta_premium;

SELECT id_jogador, data_assinatura,
       DATE_ADD(data_assinatura, INTERVAL 1 YEAR) AS renovacao     -- soma 1 ano
FROM conta_premium;

SELECT id_troca, DATE_FORMAT(data_troca, '%d/%m/%Y %H:%i') AS data_br   -- formato brasileiro
FROM troca;


-- =====================================================================
-- PASSO 5 | Funções de agregação: resumem MUITAS linhas em UMA
-- =====================================================================
SELECT COUNT(*)        AS total_personagens,
       MAX(level)      AS maior_level,
       MIN(level)      AS menor_level,
       AVG(level)      AS media_level,
       SUM(experiencia) AS xp_do_servidor
FROM personagem;

SELECT ROUND(AVG(level), 1) AS media_arredondada FROM personagem;  -- função dentro de função

-- COUNT(coluna) NÃO conta NULL. Compare:
SELECT COUNT(*) AS todos, COUNT(id_guilda) AS com_guilda FROM personagem;   -- 12 × 9

-- Agregação + WHERE: o WHERE filtra ANTES de contar
SELECT SUM(recompensa_recebida) AS ouro_pago FROM progresso WHERE data_conclusao IS NOT NULL;


-- =====================================================================
-- PASSO 6 | GROUP BY: um resumo POR grupo
-- =====================================================================
-- "Quantos personagens tem cada guilda?"
SELECT id_guilda, COUNT(*) AS membros
FROM personagem
GROUP BY id_guilda;                 -- NULL vira um grupo: os sem guilda

-- Quantos itens de cada tipo?
SELECT tipo, COUNT(*) AS quantidade FROM item GROUP BY tipo;

-- Quanto ouro cada missão já pagou? (do maior para o menor)
SELECT id_missao, SUM(recompensa_recebida) AS ouro_pago
FROM progresso
GROUP BY id_missao
ORDER BY ouro_pago DESC;

-- REGRA: no SELECT com GROUP BY, só entra a coluna do grupo + funções de agregação.
-- SELECT id_guilda, nome, COUNT(*) FROM personagem GROUP BY id_guilda;
-- ERRO ESPERADO 1055 (ONLY_FULL_GROUP_BY): "nome" de qual personagem do grupo?


-- =====================================================================
-- PASSO 7 | HAVING: filtrar os GRUPOS
-- =====================================================================
-- Guildas com 4 ou mais membros
SELECT id_guilda, COUNT(*) AS membros
FROM personagem
GROUP BY id_guilda
HAVING COUNT(*) >= 4;

-- WHERE filtra LINHAS (antes de agrupar) · HAVING filtra GRUPOS (depois)
SELECT id_personagem, COUNT(*) AS missoes_concluidas
FROM progresso
WHERE data_conclusao IS NOT NULL      -- 1) só concluídas
GROUP BY id_personagem                -- 2) agrupa por personagem
HAVING COUNT(*) >= 2                  -- 3) só quem concluiu 2 ou mais
ORDER BY missoes_concluidas DESC;     -- 4) ordena

-- Ordem obrigatória: SELECT · FROM · WHERE · GROUP BY · HAVING · ORDER BY · LIMIT


-- =====================================================================
-- PASSO 8 | UNION: empilhar resultados
-- =====================================================================
-- Lista única de nomes: jogadores E moderadores
SELECT nome, 'jogador'   AS papel FROM jogador
UNION
SELECT nome, 'moderador' AS papel FROM moderador;

-- UNION tira repetidos · UNION ALL mantém tudo
SELECT tipo FROM item WHERE tipo = 'arma'
UNION
SELECT tipo FROM item WHERE tipo = 'arma';       -- 1 linha

SELECT tipo FROM item WHERE tipo = 'arma'
UNION ALL
SELECT tipo FROM item WHERE tipo = 'arma';       -- 6 linhas

-- Os dois SELECT precisam ter o MESMO número de colunas:
-- SELECT nome, email FROM jogador UNION SELECT nome FROM moderador;
-- ERRO ESPERADO 1222: The used SELECT statements have a different number of columns


-- =====================================================================
-- RESUMO
-- =====================================================================
--  + - * / %                 contas no resultado
--  CONCAT UPPER LOWER CHAR_LENGTH SUBSTRING REPLACE TRIM     texto
--  ROUND CEIL FLOOR ABS MOD                                   números
--  NOW CURDATE YEAR MONTH DATEDIFF DATE_ADD DATE_FORMAT       datas
--  COUNT SUM AVG MAX MIN     muitas linhas → um valor
--  GROUP BY                  um resumo por grupo
--  HAVING                    filtra grupos (WHERE filtra linhas)
--  UNION / UNION ALL         empilha resultados (mesmo nº de colunas)
-- =====================================================================
