-- 07 | UPDATE — alterando dados que já existem
USE aetheria_online;

-- SEMPRE confira com SELECT antes: as linhas que aparecem são as que vão mudar
SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- guarda o id (Safe Updates exige a chave no WHERE; o id pode não ser 1)
SET @kaeldor = (SELECT id_personagem FROM personagem WHERE nome = 'Kaeldor');

-- uma coluna
UPDATE personagem SET level = 46 WHERE id_personagem = @kaeldor;

-- duas colunas no mesmo comando
UPDATE personagem SET level = 47, experiencia = 150000 WHERE id_personagem = @kaeldor;

-- cálculo em cima do valor atual
UPDATE personagem SET experiencia = experiencia + 500 WHERE id_personagem = @kaeldor;

SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- SEM WHERE altera a TABELA INTEIRA. No Workbench o Safe Updates barra:
-- ERRO 1175: You are using safe update mode
-- UPDATE personagem SET level = 1;
