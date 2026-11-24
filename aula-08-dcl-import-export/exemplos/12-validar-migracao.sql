-- ============================================================
-- Import/Export | Validar a cópia  (COMO ROOT)
-- Critério da capacidade 13: conferir se os dados vieram certos.
-- Troque aetheria_copia pelo nome do banco onde você importou o dump.
-- ============================================================

SHOW TABLES FROM aetheria_copia;

-- As contagens têm que ser IGUAIS às do banco original
SELECT 'original' AS banco, COUNT(*) AS total FROM aetheria_online.jogador
UNION ALL
SELECT 'copia',             COUNT(*)          FROM aetheria_copia.jogador;

-- Confere se as FKs também foram recriadas
SHOW CREATE TABLE aetheria_copia.personagem;
