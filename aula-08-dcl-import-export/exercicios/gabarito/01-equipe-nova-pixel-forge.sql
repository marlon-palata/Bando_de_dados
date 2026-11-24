-- GABARITO (só do professor) | Equipe nova na Pixel Forge

CREATE USER IF NOT EXISTS 'lia_estagio'@'localhost'  IDENTIFIED BY 'Lia@2026';
GRANT SELECT ON aetheria_online.* TO 'lia_estagio'@'localhost';

CREATE USER IF NOT EXISTS 'rui_suporte'@'localhost'  IDENTIFIED BY 'Rui@2026';
-- nível da TABELA, não do banco: o rui só mexe em jogador
GRANT SELECT, UPDATE ON aetheria_online.jogador TO 'rui_suporte'@'localhost';

CREATE USER IF NOT EXISTS 'vera_mercado'@'localhost' IDENTIFIED BY 'Vera@2026';
GRANT SELECT ON aetheria_online.item TO 'vera_mercado'@'localhost';

-- REVOKE usa FROM e precisa ser no mesmo nível do GRANT (tabela jogador)
REVOKE UPDATE ON aetheria_online.jogador FROM 'rui_suporte'@'localhost';

SHOW GRANTS FOR 'lia_estagio'@'localhost';
SHOW GRANTS FOR 'rui_suporte'@'localhost';
SHOW GRANTS FOR 'vera_mercado'@'localhost';
