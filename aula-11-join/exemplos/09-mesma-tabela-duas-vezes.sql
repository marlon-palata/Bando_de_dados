-- 09 | A mesma tabela duas vezes (troca: quem propõe × quem recebe)
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

SELECT t.id_troca,
       DATE_FORMAT(t.data_troca, '%d/%m/%Y') AS data,
       propoe.nome  AS quem_propoe,
       recebe.nome  AS quem_recebe
FROM troca t
INNER JOIN personagem propoe ON t.id_personagem_propoe = propoe.id_personagem
INNER JOIN personagem recebe ON t.id_personagem_recebe = recebe.id_personagem;
