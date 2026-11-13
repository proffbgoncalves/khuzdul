parser grammar KhuzdulParser;

options { tokenVocab=KhuzdulLexer; }

// Estrutura do programa
programa
    : blocoHardware declaracaoGlobal* blocoSetup blocoLoop EOF
    ;
blocoHardware
    : HARDWARE LBRACE RBRACE
    ;
blocoSetup
    : SETUP bloco
    ;
blocoLoop
    : LOOP bloco
    ;

// Declarações
declaracaoGlobal
    : declaracaoConstante
    | tipo ID (ASSIGN expressao)? SEMI
    ;
declaracaoConstante
    : CONST tipo ID ASSIGN expressao SEMI
    ;
declaracaoVariavel
    : tipo ID ASSIGN expressao SEMI
    ;

// Tipos
tipo
    : INT_TYPE (LT INT_LITERAL GT)?
    | BYTE_TYPE (LT INT_LITERAL GT)?
    | FLOAT
    | BOOL_TYPE
    | LEVEL_TYPE
    | TIME_TYPE (LT MILLIS GT)?
    | TEXT_TYPE
    | OPTIONAL_BYTE_TYPE
    ;

// Blocos e comandos
bloco
    : LBRACE (declaracaoConstante | declaracaoVariavel | comando)* RBRACE
    ;
comando
    : comandoAtribuicao
    | comandoPrint
    | comandoSerialBegin
    | comandoIf
    ;
comandoAtribuicao
    : ID ASSIGN expressao SEMI
    ;
comandoPrint
    : ACTION (SERIAL_PRINT | SERIAL_PRINTLN | SERIAL_WRITE) expressao SEMI
    ;
comandoSerialBegin
    : SERIAL_BEGIN INT_LITERAL SEMI
    ;
comandoIf
    : IF expressao bloco (ELSE bloco)?
    ;

// Expressões
expressao
    : expressaoOu
    ;
expressaoOu
    : expressaoE (OR expressaoE)*
    ;
expressaoE
    : expressaoRelacional (AND expressaoRelacional)*
    ;
expressaoRelacional
    : expressaoAditiva ((EQ | NE | LT | LE | GT | GE) expressaoAditiva)?
    ;
expressaoAditiva
    : expressaoMultiplicativa ((PLUS | MINUS) expressaoMultiplicativa)*
    ;
expressaoMultiplicativa
    : expressaoUnaria ((STAR | SLASH | MOD) expressaoUnaria)*
    ;
expressaoUnaria
    : (NOT | MINUS) expressaoUnaria
    | expressaoPrimaria
    ;
expressaoPrimaria
    : literal
    | ID
    | LPAREN expressao RPAREN
    ;

// Literais
literal
    : INT_LITERAL
    | FLOAT_LITERAL
    | STRING_LITERAL
    | TRUE
    | FALSE
    | HIGH
    | LOW
    ;
