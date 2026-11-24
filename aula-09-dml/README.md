# Aula 09 — DML: INSERT, UPDATE, DELETE e SELECT

**Curso:** Técnico em Desenvolvimento de Sistemas — SENAI Ítalo Bologna
**Fio condutor:** Aetheria Online (Pixel Forge Studios) — banco `aetheria_online`
**Capacidade:** 5 (Implementar DML)

## Objetivo da aula
Depois de construir a estrutura (DDL) e controlar o acesso (DCL), agora os dados entram:
inserir, consultar, alterar e apagar — sempre com WHERE e sempre conferindo antes.

## Como rodar
1. Abra o MySQL Workbench como **root**.
2. Se você já tem o banco `aetheria_online` da aula 7, comece pelo arquivo `01`.
   Se perdeu o banco, rode antes `exemplos/00-estrutura-aetheria.sql`.
3. Execute **bloco a bloco** (selecione + Ctrl+Enter), na ordem dos números.

> Os arquivos `02` e `08` têm comandos que dão **erro de propósito**, para mostrar
> as travas da tabela funcionando. O erro esperado está escrito no comentário.

## Tópicos cobertos
| Arquivo | Assunto |
|---|---|
| 00 | Estrutura das 14 tabelas (só se precisar recriar) |
| 01 | INSERT de uma e de várias linhas |
| 02 | NOT NULL, UNIQUE, CHECK e FK barrando o INSERT |
| 03 | Ordem pai → filha, LAST_INSERT_ID |
| 04 | SELECT: tudo, colunas, apelido |
| 05 | WHERE: =, >, BETWEEN, IN, LIKE, IS NULL, AND |
| 06 | ORDER BY, LIMIT, COUNT |
| 07 | UPDATE com WHERE e o perigo do UPDATE sem WHERE |
| 08 | DELETE, FK protegendo o pai, DELETE × TRUNCATE × DROP |
| 09 | START TRANSACTION / ROLLBACK como rede de segurança |

**Live coding completo (tudo num arquivo só):** `Aula09_LiveCoding_Completo.sql`

## Exercícios
`exercicios/` tem os arquivos com TODO para o aluno. O `exercicios/gabarito/` é do professor.
