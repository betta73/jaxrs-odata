grammar ODataFilter;

/*
 * Parser Rules
 */
 
filter: expr;

expr :
| CONTAINS BR_OPEN FIELD COMMA STRINGLITERAL BR_CLOSE
| TOLOWER BR_OPEN FIELD BR_CLOSE EQ STRINGLITERAL
| TOUPPER BR_OPEN FIELD BR_CLOSE EQ STRINGLITERAL
| FIELD IN BR_OPEN NUMBER (COMMA NUMBER)* BR_CLOSE
| FIELD IN BR_OPEN STRINGLITERAL (COMMA STRINGLITERAL)* BR_CLOSE
| FIELD ANYEXPR BR_OPEN KEY COLON expr BR_CLOSE
| FIELD ANYEXPR BR_OPEN VALUE COLON expr BR_CLOSE
| LENGTH BR_OPEN FIELD BR_CLOSE EQ NUMBER
| BR_OPEN expr BR_CLOSE
| FIELD HAS NUMBER
| FIELD HAS TIME
| FIELD HAS DATETIME
| FIELD HAS STRINGLITERAL
| FIELD HAS BOOLEAN
| FIELD EQ NUMBER
| FIELD EQ TIME
| FIELD EQ DATETIME
| FIELD EQ STRINGLITERAL
| FIELD EQ NULL
| FIELD EQ BOOLEAN
| FIELD NE NUMBER
| FIELD NE TIME
| FIELD NE DATETIME
| FIELD NE STRINGLITERAL
| FIELD NE NULL
| FIELD NE BOOLEAN
| FIELD GT NUMBER
| FIELD GT TIME
| FIELD GT DATETIME
| FIELD GE NUMBER
| FIELD GE TIME
| FIELD GE DATETIME
| FIELD LT NUMBER
| FIELD LT TIME
| FIELD LT DATETIME
| FIELD LE NUMBER
| FIELD LE TIME
| FIELD LE DATETIME
| expr AND expr
| expr OR expr
| NOT expr
; 

/*
 * Lexer Rules
 */
start: range;
range: period '-' period;
period: DATETIME;
fragment D: ('0'..'9');
fragment TZO: '.' D D D 'Z';
ISODate: D D D D '-' D D '-' D D;
ISOTime: D D ':' D D ':' D D ('.' D)?;
TIME: '\'' ISOTime ('Z' | TZO)? '\'';
DATETIME: '\'' (ISODate ('T' ISOTime ('Z' | TZO)?)?) '\'';
STRINGLITERAL: '\'' (~'\'')* '\'';
BOOLEAN: TRUE | FALSE;
ANYEXPR: '/any';
NULL: 'null';
COLON: ':';
COMMA: ',';
LENGTH: 'length';
CONTAINS: 'contains';
TOLOWER: 'tolower';
TOUPPER: 'toupper';
KEY: 'key';
VALUE: 'value';
TRUE: 'true';
FALSE: 'false';
NOT: 'not';
BR_OPEN: '(';
BR_CLOSE: ')';
AND: 'and';
OR: 'or';
HAS: 'has';
IN: 'in';
EQ: 'eq';
NE: 'ne';
GT: 'gt';
GE: 'ge';
LT: 'lt';
LE: 'le';
NUMBER: [0-9]+;
FIELD: [A-Za-z0-9/{}]+;


WS: [ \t\r\n]+ -> skip;
