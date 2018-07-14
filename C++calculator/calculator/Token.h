/*

Token.h:

Header file to be used for the basic expression calculator, it contains declarations 
of the classes Token and Parser.


*/

//------------------------------------------------------------------------------
#include<iostream>
#include<string>
#include <sstream>

using namespace std;

const char print = '=';


//------------------------------------------------------------------------------

class Token {
public:
	char kind;
	double value;
	Token(char ch)
		:kind(ch), value(0) { }
	Token(char ch, double val)
		:kind(ch), value(val) { }
};

//------------------------------------------------------------------------------

class Parser {
public:
	Token get();
	void copy_buffer(Token t);
	void ignore(char c);
	istream& input;
	Parser(istream& cin_input) :full(0), buffer(0), input(cin_input) {}
private:
	bool full{ false };
	Token buffer;
};

//------------------------------------------------------------------------------

const char t_number = '1';

//------------------------------------------------------------------------------
