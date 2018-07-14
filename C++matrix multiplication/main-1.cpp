//-------------------------------------------------------------------------------
//					main.cpp
//-------------------------------------------------------------------------------

#include "Matrix.h"

void writeFile(ofstream& file, Matrix& mtx) {
	if (file.is_open())
	{
		file << "\n---------------------------------------------------------" << endl;
		file << mtx << endl;
	}
	else cout << "unable to open file" << endl;
}

int main() {
	string nameFile;
	int m,n,p = 0;	//a[m][n]	b[n][p]		ab[m][p]

	cout << "            Matrix Multiplication\n" << endl;
	cout << "---------------------------------------------\n" << endl;

	//Prompt Matrix 1
		cout << "\nEnter the number of rows and columns for the Matrix 1:" << endl;
	cin >> m >> n;
	Matrix m1(m,n);
	cout << "Enter the values of Matrix[" << m << "][" << n <<"]:" << endl;
	m1.getData();
	cout << "\n Matrix 1: \n" << m1 << endl;
	
	//Prompt Matrix 2
	cout << "\nEnter the number of columns of Matrix 2:  " << endl;
	cin >> p;
	Matrix m2(n,p);
	cout << "\nEnter the values of Matrix[" << n << "][" << p << "]:" << endl;
	m2.getData();
	cout << "\n Matrix 2: \n" << m2 << endl;
	
	
	//Result
	cout << "\nThe result is matrix[" << m << "]["<< p <<"]:  " << endl;
	cout << m1*m2 << endl;	
	
	
	//myfile.txt
	cout << "---------------------------------------------\n" << endl;
	cout << "enter file name to store the result (e.g. one.txt):" << endl; // 
	cin >> nameFile; 
	ofstream myfile(nameFile);	//stream class to write on files
	writeFile(myfile, m1);
	writeFile(myfile, m2);
	writeFile(myfile,m1*m2);

	myfile.close();
	cin.clear();
	cin.ignore();
	cin.get();
	return 0;
}