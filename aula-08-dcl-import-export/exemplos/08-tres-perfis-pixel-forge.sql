-- ============================================================
-- DCL 7/8 | Os 3 perfis da Pixel Forge  (rode COMO ROOT)
-- Princípio do menor privilégio: cada um recebe só o que precisa.
-- ============================================================

-- 1) ADMIN: tudo no aetheria_online e pode repassar permissões
CREATE USER IF NOT EXISTS 'admin_pf'@'localhost' IDENTIFIED BY 'Admin@2026';
GRANT ALL PRIVILEGES ON aetheria_online.* TO 'admin_pf'@'localhost' WITH GRANT OPTION;

-- 2) DEV: lê/grava dados e muda a estrutura. Sem DROP e sem repassar permissões
CREATE USER IF NOT EXISTS 'dev_pf'@'localhost' IDENTIFIED BY 'Dev@2026';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX
  ON aetheria_online.* TO 'dev_pf'@'localhost';

-- 3) ANALISTA: só lê (já criado no arquivo 02)
GRANT SELECT ON aetheria_online.* TO 'analista_junior'@'localhost';

SHOW GRANTS FOR 'admin_pf'@'localhost';
SHOW GRANTS FOR 'dev_pf'@'localhost';
SHOW GRANTS FOR 'analista_junior'@'localhost';
