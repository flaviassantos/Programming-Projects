/*
Token.cpp

Source file contains the definitions of the Parser class.

*/

//------------------------------------------------------------------------------

#include "Token.h"

//------------------------------------------------------------------------------

Token Parser::get()
{
	if (full) {
		full = false;
		return buffer;
	}

	char ch;
	input >> ch;

	switch (ch) {
	case '=': case 'x': 
	case '(': case ')':	
	case '+': case '-':	case '*': case '/':
		return Token(ch);
		break;
	default:
		if (isdigit(ch)||ch=='.') {
			input.putback(ch);
			double val;
			input >> val;
			return Token{ t_number,val };
		}
		throw ("illegal input");
	}
}

//------------------------------------------------------------------------------

void Parser::copy_buffer(Token t)
{
	if (full) throw ("copy into a full buffer");
	buffer = t;       
	full = true;      
}


//------------------------------------------------------------------------------

void Parser::ignore(char c)

{

	if (full && c == buffer.kind) {
		full = false;
		return;
	}
	full = false;

	char ch = 0;
	while (input >> ch)
		if (ch == c) return;
}

//------------------------------------------------------------------------------

