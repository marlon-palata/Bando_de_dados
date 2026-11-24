# Aula 7 — DDL Física + DCL Usuários

## Objetivo da aula
Sair do esquema relacional normalizado (aula anterior) e criar o banco de
dados do Aetheria de verdade no MySQL: `CREATE DATABASE`, `CREATE TABLE`
com tipos/PK/FK/constraints, `ALTER TABLE`, `CREATE INDEX` e DCL
(`CREATE USER`, `GRANT`, `REVOKE`).

## Como rodar
Ordem obrigatória — cada script depende do anterior:

| # | Arquivo | O que faz |
|---|---|---|
| 1 | `01-criar-database.sql` | Cria o banco `aetheria_online` |
| 2 | `02-criar-tabela-jogador.sql` | Tabela pai — sem FK |
| 3 | `03-criar-tabela-guilda.sql` | Tabela pai — sem FK |
| 4 | `04-criar-tabela-personagem.sql` | Tabela filha — 2 FOREIGN KEY (jogador, guilda) |
| 5 | `05-alterar-tabelas.sql` | ALTER TABLE — ADD/MODIFY COLUMN |
| 6 | `06-indices.sql` | CREATE INDEX |
| 9 | `09-index-na-pratica.sql` | Index na prática: SELECT sem x com índice |
| 7 | `07-usuarios-permissoes.sql` | DCL — CREATE USER, GRANT, REVOKE |
| 8 | `08-tipos-extra.sql` | DECIMAL(10,2) (tabela `missao`) + DROP TABLE de verdade |

**No MySQL Workbench:** `File > Open SQL Script...` → selecione o arquivo →
ícone de raio ⚡ (Execute) ou `Ctrl+Shift+Enter` para rodar tudo.

**No terminal:**
```
mysql -u root -p < 01-criar-database.sql
mysql -u root -p < 02-criar-tabela-jogador.sql
mysql -u root -p < 03-criar-tabela-guilda.sql
mysql -u root -p < 04-criar-tabela-personagem.sql
mysql -u root -p < 05-alterar-tabelas.sql
mysql -u root -p < 06-indices.sql
mysql -u root -p < 07-usuarios-permissoes.sql
mysql -u root -p < 08-tipos-extra.sql
```

## Tópicos cobertos
- `CREATE DATABASE`, `DROP DATABASE`, `USE`
- `CREATE TABLE` — tipos de dado, `PRIMARY KEY`, `AUTO_INCREMENT`
- `FOREIGN KEY` — integridade referencial
- Constraints — `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`
- `ALTER TABLE` — `ADD COLUMN`, `MODIFY COLUMN`, `DROP COLUMN`, `ADD FOREIGN KEY`
- `DROP TABLE`, `CREATE INDEX`, `DROP INDEX`
- DCL — `CREATE USER`, `GRANT`, `REVOKE`, `FLUSH PRIVILEGES`

## Recomeçar do zero
Se algo quebrar durante a demonstração, descomente a linha `DROP DATABASE
aetheria_online;` no fim de `01-criar-database.sql`, rode só ela, e execute
os 7 scripts novamente na ordem.
