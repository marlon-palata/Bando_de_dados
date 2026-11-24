-- 12 | Listar e apagar procedures
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

SHOW PROCEDURE STATUS WHERE Db = 'aetheria_online';
-- DROP PROCEDURE sp_listar_missoes;

-- Para voltar aos dados padrão: rode o 00b de novo (views e procedures continuam).
