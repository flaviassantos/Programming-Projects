///*
//
//Simple C++ calculator 
//
//Revision history:
//
//Revised by <Name> <Month> <Year>
//Originally written by Flávia Souza Santos
//(162878@usn.no) Fall 2017.
//
//This program implements a basic expression calculator.
//
//Input comes from cin. Output to cout.
//
//main.cpp:
//
//	-double number()			// deal with numbers and parentheses
//	-double precedence_term()	// deal with * and /
//	-double expression()		// deal with + and –
//	-int main()					// main loop and deal with errors
//
//*/
//
////------------------------------------------------------------------------------
//
#include "Token.h"
//
////------------------------------------------------------------------------------
//
//double expression(Parser&);			// declaration so that number() can call expression()
//
////------------------------------------------------------------------------------
//
//double number(Parser& t_stream)		
//{
//	Token t = t_stream.get();
//	switch (t.kind) {
//	case t_number:
//		return t.value;
//		break;
//	case '-':
//		return -number(t_stream);
//		break;
//	case '+':
//		return +number(t_stream);
//		break;
//	case '(':
//	{
//		double n = expression(t_stream);
//		t = t_stream.get();
//		if (t.kind != ')') throw ("')' expected");
//		return n;
//		break;
//	}
//	default:
//	throw ("number expected");
//	}
//}
//
////------------------------------------------------------------------------------
//
//double precedence_term(Parser& t_stream)	
//{
//	double left_operand = number(t_stream);
//	Token t = t_stream.get();
//
//	while (t_stream.input) {
//		switch (t.kind)
//		{
//		case '*':
//			left_operand *= number(t_stream);
//			t = t_stream.get();
//			break;
//		case '/':
//		{
//			double n = number(t_stream);
//			t = t_stream.get();
//			if (n == 0) throw ("divided by zero");
//			left_operand /= n;
//			break;
//		}
//		default:
//			t_stream.copy_buffer(t);
//			return left_operand;
//		}
//	}
//}
//
////------------------------------------------------------------------------------
//
//double expression(Parser& t_stream)				
//{
//	double left_operand = precedence_term(t_stream);
//	Token t = t_stream.get();
//
//	while (t_stream.input) {
//		switch (t.kind) {
//		case '+':
//			left_operand += precedence_term(t_stream);
//			t = t_stream.get();
//			break;
//		case '-':
//			left_operand -= precedence_term(t_stream);
//			t = t_stream.get();
//			break;
//		default:
//			t_stream.copy_buffer(t);
//			return left_operand;
//		}
//	}
//}
////------------------------------------------------------------------------------
//
//int main()		
//{
//	Parser t_stream(cin);
//	cout << "              C++ Calculator\n\n Please enter your expression followed by '='\n";
//	cout << " (type 'x' to exit the calculator)\n";
//	cout << "---------------------------------------------\n\n";
//
//	while (t_stream.input)
//	try {
//		cout << ">";
//		Token t = t_stream.get();
//		while (t.kind == '=') t = t_stream.get();
//		if (t.kind == 'x') return 0; 
//		t_stream.copy_buffer(t);
//		cout << " Result = " << expression(t_stream) << "\n\n";
//	}
//	catch (const char *e) {
//		cout << "\n Bad Expression: " << e << '\n' << endl;
//		cin.clear();
//		cin.ignore();
//		cin.get();
//	}
//}
////------------------------------------------------------------------------------
//

class Mother {
public:
	Mother()
	{
		cout << "Mother: no parameters\n";
	}
	Mother(int a)
	{
		cout << "Mother: int parameter\n";
	}
};

class Daughter : public Mother {
public:
	Daughter(int a)
	{
		cout << "Daughter: int parameter\n\n";
	}
};

class Son : public Mother {
public:
	Son(int a) : Mother(a)
	{
		cout << "Son: int parameter\n\n";
	}
};

int main() {
	Daughter kelly(0);
	Son bud(0);

	return 0;
}
