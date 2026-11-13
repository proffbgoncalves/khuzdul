# Khuzdul

Projeto da disciplina de Compiladores para a linguagem educacional Khuzdul, com
destino a Arduino Mega 2560.

Repositório: https://github.com/proffbgoncalves/khuzdul

O projeto contém as gramáticas léxica e sintática em ANTLR 4, com geração de
visitors habilitada. O programa Java imprime os tokens do arquivo
`avaliacao_aluno.khuzdul`.

## Estrutura

- `khuzdul-compiler/pom.xml`: projeto Maven.
- `khuzdul-compiler/src/main/antlr4/br/edu/iff/khuzdul/KhuzdulLexer.g4`:
  gramática léxica.
- `khuzdul-compiler/src/main/antlr4/br/edu/iff/khuzdul/KhuzdulParser.g4`: regras
  para a estrutura do programa, declarações, atribuições, expressões,
  condicionais, inicialização serial e impressão.
- `khuzdul-compiler/src/main/java/br/edu/iff/khuzdul/Main.java`: execução do
  analisador.
- `khuzdul-compiler/src/main/resources/avaliacao_aluno.khuzdul`: programa de
  exemplo.

## Execução

Requisitos: JDK 26 ou superior e Maven.

```sh
cd khuzdul-compiler
mvn clean compile exec:java
```
