-- ============================================================
-- DCL 4/8 | Testar COMO analista_junior
-- No Workbench: "+" ao lado de MySQL Connections -> usuário
-- analista_junior -> Test Connection -> abrir a conexão.
-- ============================================================

SELECT CURRENT_USER();                       -- confirma quem sou eu: analista_junior@localhost

SELECT * FROM aetheria_online.jogador;              -- FUNCIONA (tem SELECT)

INSERT INTO aetheria_online.jogador (nome, email) VALUES ('Teste','teste@pf.com');
-- ERRO 1142: INSERT command denied  (não tem INSERT)

DROP TABLE aetheria_online.jogador;
-- ERRO 1142: DROP command denied    (não tem DROP)
