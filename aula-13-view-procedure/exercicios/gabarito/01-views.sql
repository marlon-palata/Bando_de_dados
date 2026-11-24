-- GABARITO | Exercício 1  (rode o 00b antes)
USE aetheria_online;
DROP VIEW IF EXISTS vw_inventario, vw_ouro_por_personagem;   -- só para poder rodar de novo
-- 1  (14 linhas)
CREATE VIEW vw_inventario AS
SELECT p.nome AS personagem, i.nome AS item, i.tipo, e.durabilidade_atual
FROM equipamento e
INNER JOIN personagem p ON e.id_personagem = p.id_personagem
INNER JOIN item i       ON e.id_item = i.id_item;
SELECT * FROM vw_inventario;
-- 2  2 linhas: Ragnar/Espada de ferro 30 · Thorin/Peitoral de aço 50
SELECT * FROM vw_inventario WHERE durabilidade_atual < 60;
-- 3
CREATE VIEW vw_ouro_por_personagem AS
SELECT p.nome AS personagem, SUM(pr.recompensa_recebida) AS ouro
FROM progresso pr
INNER JOIN personagem p ON pr.id_personagem = p.id_personagem
GROUP BY p.nome
HAVING SUM(pr.recompensa_recebida) > 0;
-- 4  Nyx 1900 · Sylvara 1900 · Kaeldor 1550
SELECT * FROM vw_ouro_por_personagem ORDER BY ouro DESC LIMIT 3;
-- 5
CREATE OR REPLACE VIEW vw_inventario AS
SELECT p.nome AS personagem, i.nome AS item, i.tipo, e.durabilidade_atual,
       DATE_FORMAT(e.data_equipado, '%d/%m/%Y') AS equipado_em
FROM equipamento e
INNER JOIN personagem p ON e.id_personagem = p.id_personagem
INNER JOIN item i       ON e.id_item = i.id_item;
SELECT * FROM vw_inventario;
-- 6  Não: DROP VIEW apaga só a consulta guardada; a tabela progresso continua igual.
SHOW FULL TABLES WHERE Table_type = 'VIEW';
DROP VIEW vw_ouro_por_personagem;
