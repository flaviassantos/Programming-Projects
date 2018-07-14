//-------------------------------------------------------------------------------
//					Matrix.cpp
//-------------------------------------------------------------------------------

#include "Matrix.h"

Matrix::Matrix(int rows, int columns) : rowSize(rows), columnSize(columns)
{
	cout << "normal constructor" << endl;
	ptrArray = new int[rows*columns];	//array of pointers to 'size' many integers	
}

Matrix::Matrix(const Matrix& m) : rowSize(m.rowSize), columnSize(m.columnSize)
{
	cout << "copy constructor" << endl;
	ptrArray = new int[rowSize*columnSize];	//array of pointers to 'size' many integers	
	for (int rowIndex = 0; rowIndex < rowSize; ++rowIndex)
	{
		for (int columnIndex = 0; columnIndex < columnSize; ++columnIndex)
			this->ptrArray[columnIndex + rowIndex*columnSize] = m.ptrArray[columnIndex + rowIndex*columnSize];// [] works as a * (which returns value of pointer)
	}
	//(*this).ptrArray//is the same as this->ptrArray
}


Matrix operator*(const Matrix &a, const Matrix& b) {	//all the time I use * it will recognize my 2 matricies

	Matrix ab(a.getRowSize(), b.getColumnSize());

	for (int mIndex = 0; mIndex < a.getRowSize(); ++mIndex)
	{
		for (int pIndex = 0; pIndex < b.getColumnSize(); ++pIndex)
		{
			int dotproduct = 0;
			for (int nIndex = 0; nIndex < a.getColumnSize(); ++nIndex)
			{
				dotproduct += a.ptrArray[mIndex*a.getColumnSize() + nIndex]
					* b.ptrArray[nIndex*b.getColumnSize() + pIndex]; //n
			}
			ab.ptrArray[pIndex + mIndex*b.getColumnSize()] = dotproduct;
		}
	}
	return ab;
}

ostream& operator<<(ostream& os, Matrix m) {
	for (int rowIndex = 0; rowIndex < m.rowSize; ++rowIndex) {
		for (int columnIndex = 0; columnIndex < m.columnSize; ++columnIndex) {
			os << m.ptrArray[rowIndex*m.columnSize + columnIndex];
			if (columnIndex < m.columnSize - 1)
				os << " ";
		}
		os << endl;		//avoids printing space in the end of the row
	}
	return os;
}

void Matrix::getData()
{
	for (int rowIndex = 0; rowIndex < rowSize; ++rowIndex)
	{
		for (int columnIndex = 0; columnIndex < columnSize; ++columnIndex)
			cin >> ptrArray[columnIndex + rowIndex*columnSize];// [] works as a * (which returns value of pointer)
	}
}


//int Matrix::getValue(int rowIndex, int columnIndex) 
//{ //getting the addres???
//	return ptrArray[columnIndex + rowIndex*columnSize];
//}

Matrix::~Matrix()
{
	delete[] ptrArray;
}


