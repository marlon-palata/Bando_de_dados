# Aula 08 — DCL completo + Import/Export (Banco de Dados)

**Curso:** Técnico em Desenvolvimento de Sistemas — SENAI Ítalo Bologna
**Fio condutor:** Aetheria Online (Pixel Forge Studios)
**Capacidades:** 8 (usuários e permissões) · 13 (importação e exportação)

## Objetivo da aula
Fechar o Modelo Físico: criar usuários e controlar permissões (DCL) com o princípio do
menor privilégio, e exportar/importar o banco Aetheria (aetheria_online, 14 tabelas do diagrama lógico) (dump, CSV e backup).

## Tópicos cobertos
1. DCL: CREATE USER, GRANT, REVOKE, SHOW GRANTS, ALTER USER, DROP USER
2. Níveis de permissão (`*.*`, `banco.*`, `banco.tabela`, colunas) e privilégio FILE
3. Menor privilégio e os 3 perfis (admin, dev, analista)
4. mysqldump, restore (`mysql <`, `source`), Data Export/Import do Workbench
5. CSV com `SELECT ... INTO OUTFILE` e `LOAD DATA INFILE`
6. Backup full × incremental

## Como rodar
Abra o **MySQL Workbench**, conecte como **root** e rode os arquivos de `exemplos/` na ordem
numérica (`01` a `12`). O `05` roda na conexão do `analista_junior`. O `13` é texto com os
comandos de **terminal** (cmd), fora do Workbench.

Nos arquivos `10` e `11`, troque o caminho pela pasta do **seu** `secure_file_priv`
(`SHOW VARIABLES LIKE 'secure_file_priv';`).

## Estrutura
```
07_Codigo_Aula/
├── exemplos/                  live code do professor (01 a 13)
├── exercicios/                dinâmicas do aluno (com TODO)
│   └── gabarito/              só do professor, não publicar
└── README.md
```

## Atenção
- Dump feito com `--databases` traz `CREATE DATABASE` e `USE`: importar **sobrescreve** o banco original.
  Para copiar em outro banco, use o dump **sem** `--databases`.
- `source` só funciona no terminal, não na aba SQL do Workbench.
