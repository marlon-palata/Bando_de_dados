-- ============================================================
-- DCL 8/8 | Manutenção de usuários  (rode COMO ROOT)
-- Usamos usuários de teste (temp_pf, leitor_pf) para não mexer nos 3 perfis.
-- ============================================================

-- Trocar senha
CREATE USER IF NOT EXISTS 'temp_pf'@'localhost' IDENTIFIED BY 'Temp@2026';
ALTER USER 'temp_pf'@'localhost' IDENTIFIED BY 'NovaSenha@2026';

-- Listar usuários
SELECT user, host FROM mysql.user;

-- ROLE (MySQL 8): um perfil pronto, sem repetir GRANTs para cada pessoa
CREATE ROLE IF NOT EXISTS 'perfil_leitura';
GRANT SELECT ON aetheria_online.* TO 'perfil_leitura';

CREATE USER IF NOT EXISTS 'leitor_pf'@'localhost' IDENTIFIED BY 'Leitor@2026';
GRANT 'perfil_leitura' TO 'leitor_pf'@'localhost';
-- Sem esta linha o role NÃO vale automaticamente quando o usuário conecta:
SET DEFAULT ROLE 'perfil_leitura' TO 'leitor_pf'@'localhost';

-- Conecte como leitor_pf e rode:  SELECT * FROM aetheria_online.jogador;   -- funciona pelo role

-- Apagar usuários e role de teste
DROP USER IF EXISTS 'temp_pf'@'localhost';
DROP USER IF EXISTS 'leitor_pf'@'localhost';
DROP ROLE IF EXISTS 'perfil_leitura';

-- FLUSH PRIVILEGES: só é necessário se você editar as tabelas mysql.* na mão.
-- GRANT / REVOKE / CREATE USER já valem na hora.
