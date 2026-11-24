-- 10 | Pausar, listar e apagar eventos
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;

SHOW EVENTS;
ALTER EVENT ev_regenerar_vida DISABLE;   -- pausa (sem apagar)
ALTER EVENT ev_regenerar_vida ENABLE;    -- volta
DROP EVENT ev_regenerar_vida;            -- IMPORTANTE: apague no fim da aula!

-- Para voltar aos dados padrão: rode o 00b de novo.
-- (Functions e triggers continuam no banco. O trigger de histórico vai
--  registrar os UPDATEs de level das próximas atividades — isso é esperado.)
