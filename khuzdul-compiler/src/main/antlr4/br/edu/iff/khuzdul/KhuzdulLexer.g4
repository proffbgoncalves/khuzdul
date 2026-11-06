lexer grammar KhuzdulLexer;

// Palavras reservadas
HARDWARE : 'garakh';
SETUP : 'mahignin';
LOOP : 'igiggin';
CONST : 'therdul';
FUNCTION : 'amhul';
RETURN : 'innik';
INT_TYPE : 'khaishu';
BYTE_TYPE : 'gimon';
BOOL_TYPE : 'abkât';
LEVEL_TYPE : 'azdâr';
TIME_TYPE : 'adrân';
TEXT_TYPE : 'mazarb';
OPTIONAL_BYTE_TYPE : 'gimon_fa_asrâj';
VOID : 'asrâj';
TRUE : 'baktul';
FALSE : 'hahdul';
HIGH : 'zudrâ';
LOW : 'bazir';
IF : 'nî';
ELSE : 'ninral';
SWITCH : 'ibjib';
CASE : 'bujbu';
WHILE : 'ina';
REPEAT : 'iggin';
DO : 'imihhil';
FOR : 'tur';
BREAK : 'idrib';
CONTINUE : 'idrinat';
AND : 'ra';
OR : 'fa';
NOT : 'lu';
ACTION : 'imhil';
TO : 'du';
DIGITAL_WRITE : 'ikdis_azdâr';
ANALOG_WRITE : 'ikdis_shâlakbashd';
DELAY : 'itdin';
DIGITAL_READ : 'imkib_azdâr';
ANALOG_READ : 'imkib_khaishu';
SERIAL_PRINT : 'ikdis';
SERIAL_PRINTLN : 'ikdis_zadkh';
SERIAL_WRITE : 'ikdis_gimon';
SERIAL_BEGIN : 'mahignin_aglâb';
SERIAL_READ : 'imkib';
MILLIS : 'imkib_adrân';
DIGITAL_PIN : 'zirak';
ANALOG_PIN : 'zirak_khaishu';
INPUT : 'jindîn';
INPUT_PULLUP : 'jindîn_zudrâ';
OUTPUT : 'yamar';
ANALOG_INPUT : 'jindîn_khaishu';
PWM_OUTPUT : 'yamar_shâlakbashd';
BIT_AND : 'ra_lakham';
BIT_OR : 'fa_lakham';
BIT_XOR : 'fa_lu_ra_lakham';
BIT_NOT : 'lu_lakham';
SHIFT_LEFT : 'ubnus_lakham';
SHIFT_RIGHT : 'uhgur_lakham';
FLOAT : 'azrumab';

// Operadores e delimitadores
GE : '>=';
LE : '<=';
EQ : '==';
NE : '!=';
GT : '>';
LT : '<';
ASSIGN : '=';
PLUS : '+';
MINUS : '-';
STAR : '*';
SLASH : '/';
MOD : '%';
COLON : ':';
SEMI : ';';
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACK : '[';
RBRACK : ']';
COMMA : ',';

// Literais
FLOAT_LITERAL
    : DECIMAL '.' DIGIT+ EXPONENT?
    | DECIMAL EXPONENT
    ;
INT_LITERAL
    : '0b' [01]+
    | '0x' [0-9a-fA-F]+
    | DECIMAL
    ;
STRING_LITERAL : '"' (ESCAPE | ~["\\\r\n])* '"';

// Identificadores
ID : LETTER ID_CONTINUE*;

// Comentários
LINE_COMMENT : '//' ~[\r\n]* -> skip;
BLOCK_COMMENT : '/*' .*? '*/' -> skip;

// Espaços em branco
WS : [ \t\r\n]+ -> skip;

// Fragmentos
fragment DIGIT : [0-9];
fragment DECIMAL : '0' | [1-9] DIGIT*;
fragment EXPONENT : [eE] [+-]? DIGIT+;
fragment LETTER : [\p{L}_];
fragment ID_CONTINUE : [\p{L}\p{M}\p{Nd}_];
fragment ESCAPE : '\\' [nrt"\\];
