# Banco de Dados — SQL (Modelo Físico)

SENAI Ítalo Bologna · Técnico em Desenvolvimento de Sistemas · Prof. Marlon Palata Fanger Rodrigues
Fio condutor: **Aetheria Online** (Pixel Forge Studios) · banco `aetheria_online` · MySQL 8 + Workbench

## Aulas
| Pasta | Conteúdo | Plano de curso |
|---|---|---|
| `aula-07-ddl` | CREATE/ALTER/DROP, constraints, FK, INDEX | 2.4 DDL |
| `aula-08-dcl-import-export` | usuários, GRANT/REVOKE, perfis, importação e exportação | 2.3 DCL · 2.5 Migração |
| `aula-09-dml` | INSERT, SELECT, UPDATE, DELETE, transação básica | 2.6 DML |
| `aula-10-funcoes-group-by-union` | operadores, funções, GROUP BY/HAVING, UNION | 2.7 a 2.10 |
| `aula-11-join` | WHERE, CROSS, INNER, LEFT, RIGHT, OUTER | 2.11 |
| `aula-12-subconsultas-transacoes` | IN/NOT IN, ANY/ALL, EXISTS, COMMIT/ROLLBACK/SAVEPOINT | 2.12 · 2.13 |
| `aula-13-view-procedure` | VIEW e STORED PROCEDURE | 2.14 · 2.15 |
| `aula-14-function-trigger-event` | FUNCTION, TRIGGER e EVENT | 2.16 a 2.18 |
| `revisao-aulas-07-08` | revisão em live coding das aulas 7 e 8 | — |
| `aetheria-ddl-completo` | o físico completo das 14 tabelas | — |
| `lista-01-ddl-dcl` | gabarito da Lista 01 (banco de exercícios) | — |
| `atividade-revisao-dml` | gabarito da atividade de revisão + pesquisa DML | — |

## Como usar (aulas 10 a 14)
1. Workbench aberto como **root**.
2. Não tem o banco? Rode `exemplos/00a-estrutura-aetheria.sql`.
3. **Todo mundo, no começo da aula:** `exemplos/00b-dados-aetheria.sql` (dados padrão).
4. Confira: `SELECT COUNT(*) FROM personagem;` → 12.
5. Rode **bloco a bloco** (selecione + Ctrl+Enter). Blocos com `DELIMITER` rodam inteiros.

Cada aula tem: `README.md`, o live coding completo, `exemplos/`, `exercicios/` (com TODO e a pasta `gabarito/`) e `demonstracao/index.html` (abre no navegador).
