-- 04 | VIEW de relatório (JOIN + GROUP BY)
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;
DROP VIEW IF EXISTS vw_resumo_guildas;   -- permite rodar de novo

CREATE VIEW vw_resumo_guildas AS
SELECT g.nome AS guilda,
       COUNT(p.id_personagem)  AS membros,
       ROUND(AVG(p.level), 1)  AS media_level
FROM guilda g
LEFT JOIN personagem p ON g.id_guilda = p.id_guilda
GROUP BY g.nome;

SELECT * FROM vw_resumo_guildas ORDER BY membros DESC;
