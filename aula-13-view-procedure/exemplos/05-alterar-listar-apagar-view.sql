-- 05 | Alterar, listar e apagar views
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

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
