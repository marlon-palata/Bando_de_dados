-- 04 | Funções de data e hora
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

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
