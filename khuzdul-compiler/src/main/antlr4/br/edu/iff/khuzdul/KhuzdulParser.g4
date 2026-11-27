parser grammar KhuzdulParser;

options { tokenVocab=KhuzdulLexer; }

// Estrutura do programa
programa
    : blocoHardware declaracaoGlobal* funcao* blocoSetup blocoLoop EOF
    ;
blocoHardware
    : HARDWARE LBRACE recurso* RBRACE
    ;
blocoSetup
    : SETUP bloco
    ;
blocoLoop
    : LOOP bloco
    ;

// Recursos
recurso
    : tipoRecurso ID ASSIGN (DIGITAL_PIN | ANALOG_PIN) LPAREN INT_LITERAL RPAREN
      (COLON expressao)? SEMI
    ;
tipoRecurso
    : INPUT | INPUT_PULLUP | OUTPUT | ANALOG_INPUT | PWM_OUTPUT
    ;

// Rotinas
funcao
    : FUNCTION (tipo | VOID) ID LPAREN (parametro (COMMA parametro)*)? RPAREN bloco
    ;
parametro
    : (tipo | tipoRecurso) ID
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
    : tipoElemento
    | LBRACK tipoElemento SEMI INT_LITERAL RBRACK
    | TIME_TYPE (LT MILLIS GT)?
    | TEXT_TYPE
    | OPTIONAL_BYTE_TYPE
    ;

tipoElemento
    : tipoInteiro | FLOAT | BOOL_TYPE | LEVEL_TYPE
    ;
tipoInteiro
    : (INT_TYPE | BYTE_TYPE) largura?
    ;
largura
    : LT INT_LITERAL GT
    ;

// Blocos e comandos
bloco
    : LBRACE (declaracaoConstante | declaracaoVariavel | comando)* RBRACE
    ;
comando
    : atribuicao SEMI
    | ACTION acao SEMI
    | SERIAL_BEGIN INT_LITERAL SEMI
    | comandoIf
    | comandoSwitch
    | comandoWhile
    | comandoRepeat
    | comandoDo
    | comandoFor
    | BREAK SEMI
    | CONTINUE SEMI
    | RETURN expressao? SEMI
    ;
comandoIf
    : IF expressao (TO ID)? bloco (ELSE bloco)?
    ;
comandoSwitch
    : SWITCH expressao LBRACE casoSwitch+ (ELSE bloco)? RBRACE
    ;
casoSwitch
    : CASE expressao bloco
    ;
comandoWhile
    : WHILE expressao bloco
    ;
comandoRepeat
    : REPEAT expressao bloco
    ;
comandoDo
    : DO bloco WHILE expressao SEMI
    ;
comandoFor
    : FOR LPAREN inicioFor? SEMI expressao? SEMI passoFor? RPAREN bloco
    ;
inicioFor
    : tipo ID ASSIGN expressao | passoFor
    ;
passoFor
    : atribuicao | ACTION chamada
    ;
atribuicao
    : referencia ASSIGN expressao
    ;
referencia
    : ID (LBRACK expressao RBRACK)?
    ;
acao
    : (SERIAL_PRINT | SERIAL_PRINTLN | SERIAL_WRITE | DELAY) expressao
    | DIGITAL_WRITE expressao TO ID
    | ANALOG_WRITE ID expressao
    | chamada
    ;
chamada
    : ID LPAREN listaExpressoes? RPAREN
    ;
listaExpressoes
    : expressao (COMMA expressao)*
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
    | referencia
    | chamada
    | LBRACK listaExpressoes RBRACK
    | (FLOAT | tipoInteiro) LPAREN expressao RPAREN
    | (DIGITAL_READ | ANALOG_READ) ID
    | SERIAL_READ
    | MILLIS
    | TIME_TYPE LPAREN INT_LITERAL COMMA INT_LITERAL RPAREN
    | operacaoBits
    | LPAREN expressao RPAREN
    ;

operacaoBits
    : BIT_NOT largura LPAREN expressao RPAREN
    | (BIT_AND | BIT_OR | BIT_XOR | SHIFT_LEFT | SHIFT_RIGHT)
      largura LPAREN expressao COMMA expressao RPAREN
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
