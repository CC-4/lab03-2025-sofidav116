/*

    Laboratorio No. 3 - Recursive Descent Parsing
    CC4 - Compiladores

    En este archivo ustedes tienen que crear un lexer que sea capaz de reconocer
    los tokens de la siguiente gramática:

    S ::= E;
    E ::= E + E
        | E - E
        | E * E
        | E / E
        | E % E
        | E ^ E
        | - E
        | (E)
        | number

*/

import java.io.StringReader;
import java.io.IOException;

%%

%{

    public static void main(String[] args) throws IOException {
        String input = "";
        for(int i=0; i < args.length; i++) {
            input += args[i];
        }
        Lexer lexer = new Lexer(new StringReader(input));
        Token token;
        while((token = lexer.nextToken()) != null) {
            System.out.println(token);
        }
    }

%}

%public
%class Lexer
%function nextToken
%type Token

// ==========================
// Definición de tokens
// ==========================

SEMI      = ";"
PLUS      = \+
MINUS     = -
TIMES     = \*
DIVIDE    = /
MOD       = %
POWER     = \^
LPAREN    = \(
RPAREN    = \)
WHITE     = (" "|\t|\n)

// Número tipo double:
DIGIT     = [0-9]
SIGN      = [+-]
EXP       = [eE]
NUMBER    = {SIGN}?{DIGIT}+(\.{DIGIT}*)?({EXP}{SIGN}?{DIGIT}+)?

%%

// ==========================
// Reglas léxicas
// ==========================

<YYINITIAL>{SEMI}      { return new Token(Token.SEMI); }
<YYINITIAL>{PLUS}      { return new Token(Token.PLUS); }
<YYINITIAL>{MINUS}     { return new Token(Token.MINUS); }
<YYINITIAL>{TIMES}     { return new Token(Token.TIMES); }
<YYINITIAL>{DIVIDE}    { return new Token(Token.DIVIDE); }
<YYINITIAL>{MOD}       { return new Token(Token.MOD); }
<YYINITIAL>{POWER}     { return new Token(Token.POWER); }
<YYINITIAL>{LPAREN}    { return new Token(Token.LPAREN); }
<YYINITIAL>{RPAREN}    { return new Token(Token.RPAREN); }

<YYINITIAL>{NUMBER}    {
    double val = Double.parseDouble(yytext());
    return new Token(Token.NUMBER, val);
}

<YYINITIAL>{WHITE}     { /* Ignorar espacios */ }

<YYINITIAL>.           { return new Token(Token.ERROR); }
