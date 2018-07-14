
//-------------------------------------------------------------------------------
//					Matrix.h
//-------------------------------------------------------------------------------
/*

Revision history:

Revised by <Name> <Month> <Year>
Originally written by Flávia Souza Santos
(162878@usn.no) Fall 2017.

This program implements matrix multiplication operation.

Input comes from cin. Output to the console and stored in a file.


*/
//-------------------------------------------------------------------------------

#include <iostream>
#include <string>
#include <fstream>

using namespace std;

//-------------------------------------------------------------------------------
// template<int rows, int colums>
class Matrix {


private:
	// Only with templates
	//	int elements[rows, columns];
	int* ptrArray; //pointer to an array
	int	rowSize, columnSize;

public:

	Matrix() { ptrArray = 0; rowSize = 0; columnSize = 0; cout << "default constructor" << endl; }

	Matrix(int rows, int columns);

	Matrix(const Matrix&);

	friend Matrix operator*(const Matrix &m1, const Matrix& m2);	//use as friend if I want to use more than one parameter

	friend ostream& operator<<(ostream& os, Matrix m);

	void getData();	//set values in the matrix from keyboard

	int getRowSize() const { return rowSize; };	//So I can se the number of rows and columns outside the class and on friends functions

	int getColumnSize() const { return columnSize; };

	~Matrix();
};
