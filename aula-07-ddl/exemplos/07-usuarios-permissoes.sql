-- ============================================================
-- 07 - DCL (Data Control Language) - CREATE USER, GRANT, REVOKE
-- ============================================================
-- DCL controla QUEM pode fazer O QUE no banco. Principio do
-- menor privilegio: cada usuario recebe SO a permissao que
-- precisa pro seu trabalho, nunca mais que isso.
USE aetheria_online;

-- CREATE USER: cadastra um novo usuario no MySQL (nao e' um
-- usuario do JOGO, e' um login de acesso ao BANCO DE DADOS).
-- 'analista_junior'@'localhost' = usuario que so pode conectar
-- a partir da propria maquina do servidor.
CREATE USER IF NOT EXISTS 'analista_junior'@'localhost' IDENTIFIED BY 'senha123';

-- GRANT: da permissoes especificas. Aqui, o analista junior pode
-- CONSULTAR (SELECT) e CADASTRAR dados de teste (INSERT), mas
-- nao pode alterar nem apagar nada.
GRANT SELECT, INSERT ON aetheria_online.* TO 'analista_junior'@'localhost';

-- REVOKE: remove uma permissao ja concedida. Exemplo: o time
-- decidiu que ele nem deveria poder INSERT sem supervisao.
REVOKE INSERT ON aetheria_online.* FROM 'analista_junior'@'localhost';

-- FLUSH PRIVILEGES: garante que o MySQL recarrega as permissoes
-- na hora (normalmente automatico com GRANT/REVOKE, mas e' boa
-- pratica rodar depois de mexer em usuarios).
FLUSH PRIVILEGES;

-- Conferindo as permissoes atuais do usuario:
SHOW GRANTS FOR 'analista_junior'@'localhost';

-- Pra remover o usuario completamente (nao roda por padrao):
-- DROP USER 'analista_junior'@'localhost';
