#include<iostream>
#include<sstream>
#include<fstream>
#include<queue>
#include<map>
#include<utility>
#include<stdio.h>
#include<string>

#define SIZE 100

using namespace std;

//Store the variable information in map
struct VariableInfo{
	string type;
	string value;
};

//Extract comma parameters from parameter string into queue
class CommaSeperation{
	private:
		//Store the parameter strings
		queue<string> paramQueue;
	public:
		//Extract the parameter strings
		void extractParams(string _params){
			
			if(!_params.empty()){
				
				size_t pos = _params.find(',', 0);
				size_t temp = 0;
				paramQueue.push(_params.substr(0,pos-temp));
				while(pos != string::npos){
					temp = pos+1;
					pos = _params.find(',',pos+1);
					paramQueue.push(_params.substr(temp,pos-temp));
				}
				
			}
			
		}
		queue<string> getQueue(){
			return paramQueue;
		}		
};

//Extract plus parameters from parameter string into queue
class PlusSeperation{
	private:
		//Store the parameter strings
		queue<string> paramQueue;
	public:
		//Extract the parameter strings
		void extractParams(string _params){
			
			if(!_params.empty()){
				
				size_t pos = _params.find('+', 0);
				size_t temp = 0;
				paramQueue.push(_params.substr(0,pos-temp));
				while(pos != string::npos){
					temp = pos+1;
					pos = _params.find('+',pos+1);
					paramQueue.push(_params.substr(temp,pos-temp));
				}
				
			}
			
		}
		queue<string> getQueue(){
			return paramQueue;
		}		
};

//Seperate the string describing about function
class FuncSeperation{
	private:
		//Variable name
		string varName;
		//Function name
		string funcName;
		//Parameter names
		CommaSeperation params;
	public:
		void FuncSepInit(string _order){
			
			//Positions of the conserved signs
			int equalSite = _order.find_first_of('=');
			int leftParen = _order.find_first_of('(');
			int rightParen = _order.find_last_of(')');
			//Extract the strings
			varName = _order.substr(9,equalSite-9);
			funcName = _order.substr(equalSite+1,leftParen-equalSite-1);
			//Convert parameter string into ParamSeperation object
			params.extractParams(_order.substr(leftParen+1,rightParen-leftParen-1));
			
		}
		string getFuncName(){
			return funcName;
		}
		string getOutputVarName(){
			return varName;
		}
		CommaSeperation getParams(){
			return params;
		}

};

//Let WordSepSys and seeVariables know each other
class WordSepSys;
void seeVariables(WordSepSys sys);
//For-word seperation system
class ForWordSepSys;
//Enable using seeQueue function
template <typename T>
void seeQueue(queue<T> q);
//Convert string to integer
int str2int(string _str);
//Convert string to float
float str2float(string _str);
//Convert integer to string
string int2str(int i);
//Convert float to string
string float2str(float f);

//For-word seperation system
class ForWordSepSys{
	private:
		//Loop counter
		string loopCounter;
		//Start value
		int startVal;
		//End value
		int endVal;
		//Store the variables information for searching, name(string), type and value(VariableInfo)
		map<string,VariableInfo> forVarMap;
		map<string,VariableInfo>::iterator fmi;
	public:
		//Store the orders
		queue<string> strQueue;
		//Constructor - devode the parameters and store
		ForWordSepSys(string _forParamStr){
			
			size_t equalPos = _forParamStr.find_first_of('=');
			size_t toPos = _forParamStr.find_first_of(':');
			loopCounter = _forParamStr.substr(0,equalPos);
			startVal = str2int(_forParamStr.substr(equalPos+1,toPos-equalPos-1));
			endVal = str2int(_forParamStr.substr(toPos+1));
			cout<<"Counter: "<<loopCounter<<", from "<<startVal<<" to "<<endVal<<endl;
									
		}
		//Decode the orders inside for-loop
		void orderDecode(int _curCounterVal){
			
			//Decode the order line-by-line
			while(!strQueue.empty()){
				
				//Extract the command type
				size_t pos = strQueue.front().find_first_of(' ');
				string command = strQueue.front().substr(0,pos-0);
				int commandType = 0;
				if(command == "for") commandType = 1;
				else if(command == "if") commandType = 2;
				else{
					commandType = 0;
				}
				//Do different behaviors according to command type
				switch(commandType){
					
					//Do for command
					case 1:{
						printf("nested for\n");
						break;
					}
					//Do if command
					case 2:{
						printf("for if\n");
						break;
					}
					//Do other command
					default:
						//Diferentiate plus or given value
						size_t plusPos = strQueue.front().find('+');
						if(plusPos != string::npos){
							//To process the plus-value orders
							plusValue(strQueue.front());
						} else{
							//To process the given-value orders
							givenValue(strQueue.front());
						}
					
				}
				
				strQueue.pop();
				
			}
			
		}
		//To process the given-value orders
		void givenValue(string _givenOrder){
			//Find the equal site
			size_t equalPos = _givenOrder.find('=');
			//Find if the variable is a float
			size_t floatPos = _givenOrder.find('.');
			//Find if the variable is a string
			size_t strPos = _givenOrder.find('"');
			//According to data type store the data
			if(floatPos != string::npos){
				//Store the float-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "float";
				info.value = _givenOrder.substr(equalPos+1);
				forVarMap.insert(pair<string,VariableInfo>(name,info));
			} else if(strPos != string::npos){
				//Store the string-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "string";
				info.value = _givenOrder.substr(equalPos+1);
				forVarMap.insert(pair<string,VariableInfo>(name,info));
			} else{
				//Store the int-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "int";
				info.value = _givenOrder.substr(equalPos+1);
				forVarMap.insert(pair<string,VariableInfo>(name,info));
			}
			cout<<_givenOrder.substr(0,equalPos-0)<<" is given value "<<_givenOrder.substr(equalPos+1)<<endl;
		}
		//Handle the plus order
		void plusValue(string _plusOrder){
			//Find the equal site
			size_t equalPos = _plusOrder.find('=');
			//Extract variables into PlusSeperation object
			string resultName = _plusOrder.substr(0,equalPos-0);
			PlusSeperation params;
			params.extractParams(_plusOrder.substr(equalPos+1));					
			//Check if they are 0:variables, 1:numbers, 2:floats, or 3:strings,
			queue<int> paramTypes = checkVarTypes(params);
			//Copy the params queue
			queue<string> paramsStr = params.getQueue();
			//Store the result value
			string resultValStr = "";
			//Declare a result value variable
			int resultInt = 0;
			float resultFloat = 0.0;
			//Record the result type
			int resultType = 0;
			string resultTypeStr = "string";
			//Sum the variables
			while(!paramTypes.empty()){
				if(paramTypes.front() == 0){
					//Find the variable type
					fmi = forVarMap.find(paramsStr.front());
					string varType = (*fmi).second.type; 
					//Convert to the type
					if(varType == "int"){
						resultInt = resultInt + str2int((*fmi).second.value);
						resultType = 1;
					} else if(varType == "float"){
						resultFloat = resultFloat + str2float((*fmi).second.value);
						resultType = 2;
					} else if(varType == "string"){
						resultValStr = resultValStr + (*fmi).second.value;
						resultType = 3;
					}
				} else{
					switch(paramTypes.front()){
						case 1:{
							resultInt = resultInt + str2int(paramsStr.front());
							resultType = 1;
							break;
						}
						case 2:{
							resultFloat = resultFloat + str2float(paramsStr.front());
							resultType = 2;
							break;
						}
						case 3:{
							resultValStr = resultValStr + paramsStr.front();
							resultType = 3;
							break;
						}
						default:
							cout<<"Unsupported type!"<<endl;
					}
				}
				paramsStr.pop();
				paramTypes.pop();
			}
			//convert to string
			switch(resultType){
				case 1:{
					resultValStr = int2str(resultInt);
					resultTypeStr = "int";
					break;
				}
				case 2:{
					resultValStr = float2str(resultFloat);
					resultTypeStr = "float";
					break;
				}
			}
			//Store into variable table
			VariableInfo resultInfo;
			resultInfo.type = resultTypeStr;
			resultInfo.value = resultValStr;
			forVarMap.insert(pair<string,VariableInfo>(resultName,resultInfo));
		}
		//Check plus parameters' types
		queue<int> checkVarTypes(PlusSeperation _params){
			
			//Copy the queue
			queue<string> temp = _params.getQueue();
			//Store types into queue
			queue<int> types;
			//Check each variable type
			while(!temp.empty()){
				
				//Take the first character
				char word = temp.front()[0];
				//Find if the variable is a float
				size_t floatPos = temp.front().find('.');
				//Find if the variable is a string
				size_t strPos = temp.front().find('"');
				//Determine the type of the variable
				if(word - '0' >= 49 && word - '0' < 75){
					types.push(0);
				} else if(word - '0' >= 0 && word - '0' < 10 && floatPos == string::npos){
					types.push(1);
				} else if(floatPos != string::npos){
					types.push(2);
				} else if(strPos != string::npos){
					types.push(3);
				} else{}
				
				temp.pop();
			}
			
			return types;
		}
		int getStartVal(){
			return startVal;
		}
		int getEndVal(){
			return endVal;
		}
};

//Word seperation system - Read the file and call other functions to convert orders into program
class WordSepSys{
	private:
		//Store the orders
		queue<string> strQueue;
		//Store the functions
		FuncSeperation func1;
	public:
		//Store the variables information for searching, name(string), type and value(VariableInfo)
		map<string,VariableInfo> varMap;
		map<string,VariableInfo>::iterator mi;
		//Constructor
		WordSepSys(string addr){
			
			//Open txt file
			ifstream file;
			file.open(addr.c_str());
			//Store the current line
			string curLine;
			//Looping to read each line
			if(file.is_open()){
				while (getline(file, curLine)){
					strQueue.push(curLine);
				}  
			}
			//Enter into main console to convert the string queue into programs line by line
			mainConsole(strQueue);
			//Close the file
			file.close();
									
		}
		//Main console: Looping and convert every order into program
		void mainConsole(queue<string> _strQueue){
			
			//Store the function information
			funcInformStore(_strQueue.front());
			_strQueue.pop();
			//Read every order in queue and convert to program
			orderDecode(_strQueue);
			
		}
		//Restore the function information
		void funcInformStore(string _funcInform){

			string order = _funcInform;
			func1.FuncSepInit(order);
						
		}
		//Decide how to decode the order
		void orderDecode(queue<string> _stringQueue){
			
			//Decode the order line-by-line
			while(!_stringQueue.empty()){
				
				//Extract the command type
				size_t pos = _stringQueue.front().find_first_of(' ');
				string command = _stringQueue.front().substr(0,pos-0);
				int commandType = 0;
				if(command == "for") commandType = 1;
				else if(command == "if") commandType = 2;
				else{
					commandType = 0;
				}
				//Do different behaviors according to command type
				switch(commandType){
					
					//Do for command
					case 1:{
						_stringQueue = forInfoExtract(_stringQueue,pos);
						break;
					}
					//Do if command
					case 2:{
						printf("if\n");
						break;
					}
					//Do other command
					default:
						//Diferentiate plus or given value
						size_t plusPos = _stringQueue.front().find('+');
						if(plusPos != string::npos){
							printf("plus\n");
							//To process the plus-value orders
							plusValue(_stringQueue.front());
						} else{
							printf("given\n");
							//To process the given-value orders
							givenValue(_stringQueue.front());
						}
					
				}
				
				_stringQueue.pop();
				
			}
			seeVariables(*this);
			
		}
		//Extracting for information and orders
		queue<string> forInfoExtract(queue<string> _strQueue,size_t spacePos){
			//Collect first line of for loop, threw into for-decoder
			ForWordSepSys forSepSys(_strQueue.front().substr(spacePos+1));
			_strQueue.pop();
			//Push the orders into for-decoder queue
			while(_strQueue.front().substr(0,3) != "end"){
				forSepSys.strQueue.push(_strQueue.front());
				_strQueue.pop();
			}
			//Looping
			for(int i=forSepSys.getStartVal()-1;i<forSepSys.getEndVal();i++){
				//For orders decode, with parameter(current loop-counter value)
				forSepSys.orderDecode(i);
			}
			return _strQueue;
		}
		//To process the given-value orders
		void givenValue(string _givenOrder){
			//Find the equal site
			size_t equalPos = _givenOrder.find('=');
			//Find if the variable is a float
			size_t floatPos = _givenOrder.find('.');
			//Find if the variable is a string
			size_t strPos = _givenOrder.find('"');
			//According to data type store the data
			if(floatPos != string::npos){
				//Store the float-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "float";
				info.value = _givenOrder.substr(equalPos+1);
				varMap.insert(pair<string,VariableInfo>(name,info));
			} else if(strPos != string::npos){
				//Store the string-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "string";
				info.value = _givenOrder.substr(equalPos+1);
				varMap.insert(pair<string,VariableInfo>(name,info));
			} else{
				//Store the int-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "int";
				info.value = _givenOrder.substr(equalPos+1);
				varMap.insert(pair<string,VariableInfo>(name,info));
			}
		}
		//Handle the plus order
		void plusValue(string _plusOrder){
			//Find the equal site
			size_t equalPos = _plusOrder.find('=');
			//Extract variables into PlusSeperation object
			string resultName = _plusOrder.substr(0,equalPos-0);
			PlusSeperation params;
			params.extractParams(_plusOrder.substr(equalPos+1));					
			//Check if they are 0:variables, 1:numbers, 2:floats, or 3:strings,
			queue<int> paramTypes = checkVarTypes(params);
			//Copy the params queue
			queue<string> paramsStr = params.getQueue();
			//Store the result value
			string resultValStr = "";
			//Declare a result value variable
			int resultInt = 0;
			float resultFloat = 0.0;
			//Record the result type
			int resultType = 0;
			string resultTypeStr = "string";
			//Sum the variables
			while(!paramTypes.empty()){
				if(paramTypes.front() == 0){
					//Find the variable type
					mi = varMap.find(paramsStr.front());
					string varType = (*mi).second.type; 
					//Convert to the type
					if(varType == "int"){
						resultInt = resultInt + str2int((*mi).second.value);
						resultType = 1;
					} else if(varType == "float"){
						resultFloat = resultFloat + str2float((*mi).second.value);
						resultType = 2;
					} else if(varType == "string"){
						resultValStr = resultValStr + (*mi).second.value;
						resultType = 3;
					}
				} else{
					switch(paramTypes.front()){
						case 1:{
							resultInt = resultInt + str2int(paramsStr.front());
							resultType = 1;
							break;
						}
						case 2:{
							resultFloat = resultFloat + str2float(paramsStr.front());
							resultType = 2;
							break;
						}
						case 3:{
							resultValStr = resultValStr + paramsStr.front();
							resultType = 3;
							break;
						}
						default:
							cout<<"Unsupported type!"<<endl;
					}
				}
				paramsStr.pop();
				paramTypes.pop();
			}
			//convert to string
			switch(resultType){
				case 1:{
					resultValStr = int2str(resultInt);
					resultTypeStr = "int";
					break;
				}
				case 2:{
					resultValStr = float2str(resultFloat);
					resultTypeStr = "float";
					break;
				}
			}
			//Store into variable table
			VariableInfo resultInfo;
			resultInfo.type = resultTypeStr;
			resultInfo.value = resultValStr;
			varMap.insert(pair<string,VariableInfo>(resultName,resultInfo));
		}
		//Check plus parameters' types
		queue<int> checkVarTypes(PlusSeperation _params){
			
			//Copy the queue
			queue<string> temp = _params.getQueue();
			//Store types into queue
			queue<int> types;
			//Check each variable type
			while(!temp.empty()){
				
				//Take the first character
				char word = temp.front()[0];
				//Find if the variable is a float
				size_t floatPos = temp.front().find('.');
				//Find if the variable is a string
				size_t strPos = temp.front().find('"');
				//Determine the type of the variable
				if(word - '0' >= 49 && word - '0' < 75){
					types.push(0);
				} else if(word - '0' >= 0 && word - '0' < 10 && floatPos == string::npos){
					types.push(1);
				} else if(floatPos != string::npos){
					types.push(2);
				} else if(strPos != string::npos){
					types.push(3);
				} else{}
				
				temp.pop();
			}
			
			return types;
		}
		FuncSeperation getFunc(){
			return func1;
		}
		queue<string> getOrderQueue(){
			return strQueue;
		}
		
};

//Convert string to integer
int str2int(string _str){
	istringstream is(_str);
	int val;
	is>>val;
	return val;
}

//Covert string to float
float str2float(string _str){
	stringstream fs(_str);
	float val;
	fs>>val;
	return val;
}

//Convert integer to string
string int2str(int i) {
	string s;
  	stringstream ss(s);
  	ss << i;
  	return ss.str();
}

//Convert integer to string
string float2str(float f) {
	string s;
  	stringstream ss(s);
  	ss << f;
  	return ss.str();
}

//See the variables' information, usage: seeVariables(*this); -> When called from WordSepSys member function
void seeVariables(WordSepSys sys){
	for(sys.mi = sys.varMap.begin();sys.mi != sys.varMap.end();sys.mi++){
		cout<<(*(sys.mi)).first<<" "<<(*(sys.mi)).second.type<<" "<<(*(sys.mi)).second.value<<endl;
	}
	cout<<endl;
}

//See content in queue, usage: seeQueue<int>( __queue__ );
template <typename T>
void seeQueue(queue<T> q){
	while(!q.empty()){
		cout<<q.front()<<" ";
		q.pop();
	}
	cout<<endl;
}

int main(){
	//string functionAddr = "C:/Users/user/Desktop/test.txt";
	string functionAddr = "C:/Users/Administrator/Desktop/test.txt"; 
	WordSepSys sepSys(functionAddr); //Build WordSepSys and convert into program
	
	cout<<"Function name: "<<sepSys.getFunc().getFuncName()<<endl;
	cout<<"Function input: ";
	seeQueue(sepSys.getFunc().getParams().getQueue());
	cout<<"Function output: "<<sepSys.getFunc().getOutputVarName()<<endl;
	
	return 0;
}
