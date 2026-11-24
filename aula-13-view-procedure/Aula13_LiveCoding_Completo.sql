-- =====================================================================
--  AULA 13 | VIEW e STORED PROCEDURE  (LIVE CODING)
--  Banco: aetheria_online  ·  Antes: rode o 00b (dados padrão)
--  Rode BLOCO A BLOCO. Os blocos com DELIMITER rodam INTEIROS
--  (selecione do DELIMITER $$ até o DELIMITER ; e Ctrl+Enter).
-- =====================================================================
--  VIEW      = uma consulta guardada com nome. Usa-se como se fosse tabela.
--  PROCEDURE = uma rotina guardada com nome. Executa-se com CALL.
--  As duas ficam DENTRO do banco: qualquer sistema pode usar.
-- =====================================================================


-- =====================================================================
-- PASSO 0 | Conferir os dados
-- =====================================================================
USE aetheria_online;
SET NAMES utf8mb4;
SELECT COUNT(*) FROM personagem;   -- 12
DROP VIEW IF EXISTS vw_ranking, vw_resumo_guildas;   -- limpa se você já rodou este arquivo antes


-- =====================================================================
-- PASSO 1 | O problema: a mesma consulta grande toda hora
-- =====================================================================
-- O site, o app e o painel do suporte precisam deste ranking:
SELECT p.nome AS personagem, p.level, j.nome AS jogador, g.nome AS guilda
FROM personagem p
INNER JOIN jogador j ON p.id_jogador = j.id_jogador
LEFT  JOIN guilda  g ON p.id_guilda  = g.id_guilda
ORDER BY p.level DESC;
-- Copiar e colar em três sistemas = três lugares para errar.


-- =====================================================================
-- PASSO 2 | CREATE VIEW: guardar a consulta com um nome
-- =====================================================================
CREATE VIEW vw_ranking AS
SELECT p.nome AS personagem, p.level, j.nome AS jogador, g.nome AS guilda
FROM personagem p
INNER JOIN jogador j ON p.id_jogador = j.id_jogador
LEFT  JOIN guilda  g ON p.id_guilda  = g.id_guilda;

-- Agora usa-se como se fosse uma tabela:
SELECT * FROM vw_ranking ORDER BY level DESC;
SELECT * FROM vw_ranking WHERE guilda = 'Ordem Arcana';
SELECT personagem, level FROM vw_ranking ORDER BY level DESC LIMIT 3;


-- =====================================================================
-- PASSO 3 | A VIEW não guarda dados: ela roda a consulta na hora
-- =====================================================================
UPDATE personagem SET level = 70 WHERE id_personagem = 5;   -- Lyria treinou muito
SELECT * FROM vw_ranking ORDER BY level DESC LIMIT 3;       -- Lyria já está no topo
UPDATE personagem SET level = 12 WHERE id_personagem = 5;   -- volta ao normal

-- Criar de novo com o mesmo nome dá erro:
-- CREATE VIEW vw_ranking AS SELECT nome FROM personagem;
-- ERRO ESPERADO 1050: Table 'vw_ranking' already exists


-- =====================================================================
-- PASSO 4 | VIEW de relatório (JOIN + GROUP BY)
-- =====================================================================
CREATE VIEW vw_resumo_guildas AS
SELECT g.nome AS guilda,
       COUNT(p.id_personagem)  AS membros,
       ROUND(AVG(p.level), 1)  AS media_level
FROM guilda g
LEFT JOIN personagem p ON g.id_guilda = p.id_guilda
GROUP BY g.nome;

SELECT * FROM vw_resumo_guildas ORDER BY membros DESC;


-- =====================================================================
-- PASSO 5 | Alterar, listar e apagar views
-- =====================================================================
-- CREATE OR REPLACE: cria ou troca a definição (acrescentei a cidade)
CREATE OR REPLACE VIEW vw_resumo_guildas AS
SELECT g.nome AS guilda, g.cidade,
       COUNT(p.id_personagem)  AS membros,
       ROUND(AVG(p.level), 1)  AS media_level
FROM guilda g
LEFT JOIN personagem p ON g.id_guilda = p.id_guilda
GROUP BY g.nome, g.cidade;

SELECT * FROM vw_resumo_guildas;

SHOW FULL TABLES WHERE Table_type = 'VIEW';   -- lista só as views

-- DROP VIEW vw_resumo_guildas;               -- apaga só a view (os dados continuam)

-- Segurança (DCL, aula 8): dá para liberar a VIEW sem liberar a tabela.
-- GRANT SELECT ON aetheria_online.vw_ranking TO 'analista'@'localhost';
-- O analista vê o ranking, mas não vê o e-mail dos jogadores.


-- =====================================================================
-- PASSO 6 | STORED PROCEDURE: a primeira rotina
-- =====================================================================
-- DELIMITER troca o ";" por "$$" só enquanto criamos a procedure,
-- porque dentro dela existem vários ";".
DROP PROCEDURE IF EXISTS sp_listar_missoes;
DELIMITER $$
CREATE PROCEDURE sp_listar_missoes()
BEGIN
    SELECT nome, recompensa_base
    FROM missao
    ORDER BY recompensa_base DESC;
END $$
DELIMITER ;

CALL sp_listar_missoes();         -- CALL executa a procedure


-- =====================================================================
-- PASSO 7 | Parâmetro de entrada (IN)
-- =====================================================================
DROP PROCEDURE IF EXISTS sp_membros_da_guilda;
DELIMITER $$
CREATE PROCEDURE sp_membros_da_guilda(IN p_id_guilda INT)
BEGIN
    SELECT nome, level
    FROM personagem
    WHERE id_guilda = p_id_guilda
    ORDER BY level DESC;
END $$
DELIMITER ;

CALL sp_membros_da_guilda(1);     -- Legião de Ferro
CALL sp_membros_da_guilda(2);     -- Ordem Arcana


-- =====================================================================
-- PASSO 8 | Procedure que GRAVA (INSERT com parâmetros)
-- =====================================================================
DROP PROCEDURE IF EXISTS sp_cadastrar_jogador;
DELIMITER $$
CREATE PROCEDURE sp_cadastrar_jogador(IN p_nome VARCHAR(80), IN p_email VARCHAR(120))
BEGIN
    INSERT INTO jogador (nome, email) VALUES (p_nome, p_email);
    SELECT LAST_INSERT_ID() AS novo_id;
END $$
DELIMITER ;

CALL sp_cadastrar_jogador('Hugo Prado', 'hugo@pixelforge.com');   -- novo_id 9
-- As travas continuam valendo:
-- CALL sp_cadastrar_jogador('Hugo de novo', 'hugo@pixelforge.com');
-- ERRO ESPERADO 1062: Duplicate entry (UNIQUE do e-mail)


-- =====================================================================
-- PASSO 9 | Parâmetro de saída (OUT) e variável
-- =====================================================================
DROP PROCEDURE IF EXISTS sp_contar_membros;
DELIMITER $$
CREATE PROCEDURE sp_contar_membros(IN p_id_guilda INT, OUT p_total INT)
BEGIN
    SELECT COUNT(*) INTO p_total            -- INTO guarda o resultado no parâmetro
    FROM personagem
    WHERE id_guilda = p_id_guilda;
END $$
DELIMITER ;

CALL sp_contar_membros(1, @total);          -- @total recebe a resposta
SELECT @total AS membros_da_legiao;         -- 4


-- =====================================================================
-- PASSO 10 | Regra de negócio: IF dentro da procedure
-- =====================================================================
-- Subir de level, mas só se a quantidade for positiva.
DROP PROCEDURE IF EXISTS sp_subir_level;
DELIMITER $$
CREATE PROCEDURE sp_subir_level(IN p_id INT, IN p_qtd INT)
BEGIN
    IF p_qtd <= 0 THEN
        SELECT 'Quantidade inválida: use um número maior que zero' AS aviso;
    ELSE
        UPDATE personagem SET level = level + p_qtd WHERE id_personagem = p_id;
        SELECT nome, level FROM personagem WHERE id_personagem = p_id;
    END IF;
END $$
DELIMITER ;

CALL sp_subir_level(9, 2);      -- Dravik: 8 → 10
CALL sp_subir_level(9, -5);     -- aviso, nada muda


-- =====================================================================
-- PASSO 11 | Procedure com transação (a troca da aula 12, guardada)
-- =====================================================================
DROP PROCEDURE IF EXISTS sp_trocar_item;
DELIMITER $$
CREATE PROCEDURE sp_trocar_item(IN p_de INT, IN p_para INT, IN p_item INT)
BEGIN
    START TRANSACTION;
    UPDATE equipamento SET id_personagem = p_para
    WHERE id_personagem = p_de AND id_item = p_item;
    INSERT INTO troca (id_personagem_propoe, id_personagem_recebe) VALUES (p_de, p_para);
    COMMIT;
    SELECT * FROM equipamento WHERE id_item = p_item;
END $$
DELIMITER ;

CALL sp_trocar_item(1, 5, 6);   -- Kaeldor dá a Poção de vida para a Lyria


-- =====================================================================
-- PASSO 12 | Listar e apagar procedures
-- =====================================================================
SHOW PROCEDURE STATUS WHERE Db = 'aetheria_online';
-- DROP PROCEDURE sp_listar_missoes;

-- Para voltar aos dados padrão: rode o 00b de novo (views e procedures continuam).


-- =====================================================================
-- RESUMO
-- =====================================================================
--  CREATE VIEW nome AS SELECT ...        consulta guardada (tabela virtual)
--  CREATE OR REPLACE VIEW / DROP VIEW    trocar / apagar
--  DELIMITER $$ ... DELIMITER ;          necessário para criar procedure
--  CREATE PROCEDURE nome(IN.., OUT..)    rotina guardada
--  BEGIN ... END                         corpo da procedure
--  CALL nome(...)                        executa
--  SELECT ... INTO p_saida / @variavel   devolve um valor
--  IF ... THEN ... ELSE ... END IF       regra de negócio
-- =====================================================================
