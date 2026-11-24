-- 10 | JOIN + GROUP BY (a aula 10 com nomes de verdade)
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

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
