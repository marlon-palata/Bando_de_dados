-- ============================================================
-- DCL 1/8 | CREATE USER  (rode COMO ROOT)
-- ============================================================

-- 'analista_junior'@'localhost' = usuário@host.
-- 'localhost' = só entra do próprio computador. Evite '%' (qualquer lugar).
-- IF NOT EXISTS evita o erro 1396 quando o usuário já existe.
CREATE USER IF NOT EXISTS 'analista_junior'@'localhost' IDENTIFIED BY 'Analista@2026';

-- O usuário já aparece na lista, mas ainda NÃO pode fazer nada
SELECT user, host FROM mysql.user WHERE user = 'analista_junior';
