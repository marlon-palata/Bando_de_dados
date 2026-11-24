-- GABARITO (só do professor) | Mande o Aetheria para o colega

CREATE DATABASE aetheria_copia;

-- (importação feita pelo Workbench: Server > Data Import, Default Target Schema = aetheria_copia)

SHOW TABLES FROM aetheria_copia;

SELECT 'original' AS banco, COUNT(*) AS total FROM aetheria_online.jogador
UNION ALL
SELECT 'copia', COUNT(*) FROM aetheria_copia.jogador;
