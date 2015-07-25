/*******************************************
****************C++矩陣實現*****************
用法Example:
 
 Matrix data(2,2);
 data[0][0] = 1;
 data[1][0] = 1;
 data[0][1] = 1;
 data[1][1] = 1;
 cout<<data[0][0]<<data[1][0]<<data[0][1]<<data[1][1]<<endl; 
********************************************/

class Matrix{
	private:
		int rowNumber; //矩陣列數
		int columnNumber; //矩陣行數
		int **matrixData; //用來儲存矩陣元素的動態陣列 
	public:
		Matrix(int row_num, int col_num){
			rowNumber = row_num;
			columnNumber = col_num;
			
			matrixData = new int* [rowNumber];
			for (int i = 0; i < rowNumber; ++i){
				matrixData[i] = new int[columnNumber];
			}
		}
		~Matrix(){
			for(int i = 0; i < rowNumber; i++)
				delete [] matrixData[i];
			delete [] matrixData;
		}
		int* const operator[](const int i){  
			return matrixData[i];  
		}
};
