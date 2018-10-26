lexer grammar VIASearchLexer;

SLASH: '/';
fragment WS: ' ';
fragment SLASH_RIGTH_BRACKET: '/]';
fragment LEFT_BRACKET: '[';
fragment RIGTH_BRACKET: ']';
TEXT: ( ~[[])+;

START_TAG: LEFT_BRACKET -> pushMode(IN_TAG);

mode IN_TAG;
TAG_ATTRIBUTE: (TAG_NAME TAG_EQUALS ATTVALUE_VALUE)
	| (TAG_NAME WS);
END_TAG: (SLASH_RIGTH_BRACKET WS | SLASH_RIGTH_BRACKET)-> popMode;

// attribute values
mode ATTVALUE;

// an attribute value may have spaces b/t the '=' and the value
ATTVALUE_VALUE: [ ]* ATTRIBUTE -> popMode;

ATTRIBUTE:
	DOUBLE_QUOTE_STRING
	| SINGLE_QUOTE_STRING
	| ATTCHARS
	| HEXCHARS
	| DECCHARS;

fragment ATTCHAR:
	'-'
	| '_'
	| '.'
	| '/'
	| '+'
	| ','
	| '?'
	| '='
	| ':'
	| ';'
	| '#'
	| [0-9a-zA-Z];

fragment ATTCHARS: ATTCHAR+ ' '?;

fragment HEXCHARS: '#' [0-9a-fA-F]+;

fragment DECCHARS: [0-9]+ '%'?;

fragment DOUBLE_QUOTE_STRING: '"' ~[<"]* '"';
fragment SINGLE_QUOTE_STRING: '\'' ~[<']* '\'';

// lexing mode for attribute values
TAG_EQUALS: '=' -> pushMode(ATTVALUE);

TAG_NAME: TAG_NameStartChar TAG_NameChar*;

TAG_WHITESPACE: [ \t\r\n] -> skip;

fragment HEXDIGIT: [a-fA-F0-9];

fragment DIGIT: [0-9];

fragment TAG_NameChar:
	TAG_NameStartChar
	| '-'
	| '_'
	| '.'
	| DIGIT
	| '\u00B7'
	| '\u0300' ..'\u036F'
	| '\u203F' ..'\u2040';

fragment TAG_NameStartChar:
	[:a-zA-Z]
	| '\u2070' ..'\u218F'
	| '\u2C00' ..'\u2FEF'
	| '\u3001' ..'\uD7FF'
	| '\uF900' ..'\uFDCF'
	| '\uFDF0' ..'\uFFFD';
