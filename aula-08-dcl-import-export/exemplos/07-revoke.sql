-- ============================================================
-- DCL 6/8 | REVOKE  (rode COMO ROOT)
-- ============================================================

-- GRANT usa TO. REVOKE usa FROM.
REVOKE INSERT, UPDATE ON aetheria_online.jogador FROM 'analista_junior'@'localhost';

SHOW GRANTS FOR 'analista_junior'@'localhost';

-- Só se revoga NO MESMO NÍVEL em que foi dado:
-- um GRANT em aetheria_online.* NÃO se desfaz com REVOKE em aetheria_online.jogador
-- (dá ERRO 1147: There is no such grant defined, e a permissão continua valendo).

-- Tirar tudo de uma vez:
-- REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'analista_junior'@'localhost';
