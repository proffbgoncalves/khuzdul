parser grammar KhuzdulParser;

options { tokenVocab=KhuzdulLexer; }

programa
    : HARDWARE LBRACE RBRACE
      SETUP LBRACE RBRACE
      LOOP LBRACE RBRACE EOF
    ;
