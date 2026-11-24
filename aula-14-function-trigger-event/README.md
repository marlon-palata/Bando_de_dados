# Aula 14 — FUNCTION, TRIGGER e EVENT

**Objetivo:** criar funções próprias e fazer o banco do Aetheria reagir sozinho a ações (trigger) e ao relógio (event).
Plano de curso: itens 2.16 (FUNCTION), 2.17 (TRIGGERS) e 2.18 (EVENT).

## Como rodar
1. MySQL Workbench aberto como **root**.
2. Não tem o banco? Rode `exemplos/00a-estrutura-aetheria.sql`.
3. **Todo mundo:** rode `exemplos/00b-dados-aetheria.sql`.
4. Blocos com DELIMITER: selecione do `DELIMITER $$` até o `DELIMITER ;` e rode inteiro.
5. Eventos: confira `SHOW VARIABLES LIKE 'event_scheduler';` (ON). **No fim, apague os eventos que criou.**

## Tabelas extras (fora do diagrama do Aetheria)
`historico_level` (live coding), `auditoria_jogador` (exercício 2) e `conquista` (dinâmica) — criadas só para mostrar os triggers.

## Arquivos
| Arquivo | Conteúdo |
|---|---|
| `Aula14_LiveCoding_Completo.sql` | a aula inteira num arquivo só |
| `exemplos/01-primeira-function.sql` | fn_classe: RETURNS, DETERMINISTIC, IF/ELSEIF |
| `exemplos/02-function-dois-parametros.sql` | fn_xp_por_level |
| `exemplos/03-function-que-le-tabela.sql` | fn_ouro_total: DECLARE, READS SQL DATA |
| `exemplos/04-trigger-after-update.sql` | histórico de level (OLD/NEW) |
| `exemplos/05-trigger-before-insert.sql` | e-mail em minúsculo |
| `exemplos/06-trigger-before-update.sql` | vida máxima 100 |
| `exemplos/07-trigger-com-signal.sql` | SIGNAL barrando troca inválida |
| `exemplos/08-listar-apagar-triggers.sql` | SHOW TRIGGERS, DROP TRIGGER |
| `exemplos/09-event.sql` | EVERY e AT |
| `exemplos/10-pausar-listar-apagar-events.sql` | ALTER EVENT, SHOW EVENTS, DROP EVENT |
| `exercicios/01-functions.sql` | Atividade — Parte 1 (5 TODO) |
| `exercicios/02-triggers-events.sql` | Atividade — Parte 2 (6 TODO) |
| `exercicios/gabarito/` | respostas (professor) |

## Tópicos cobertos
CREATE FUNCTION · RETURNS/RETURN · DETERMINISTIC/READS SQL DATA · DECLARE · CREATE TRIGGER (BEFORE/AFTER, OLD/NEW) · SIGNAL · CREATE EVENT (EVERY/AT) · ALTER/DROP EVENT.
