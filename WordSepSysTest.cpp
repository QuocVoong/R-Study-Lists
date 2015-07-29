#include<iostream>
#include<sstream>
#include<fstream>
#include<queue>
#include<map>
#include<vector>
#include<utility>
#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<algorithm>
#include<stack>

#define SIZE 100

using namespace std;

string coutVal;

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

//Extract plus parameters from parameter string into queue
class MultSeperation{
	private:
		//Store the parameter strings
		queue<string> paramQueue;
	public:
		//Extract the parameter strings
		void extractParams(string _params){
			
			if(!_params.empty()){
				
				size_t pos = _params.find('*', 0);
				size_t temp = 0;
				paramQueue.push(_params.substr(0,pos-temp));
				while(pos != string::npos){
					temp = pos+1;
					pos = _params.find('*',pos+1);
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

//For word separation system object to process the loop
class ForWordSepSys{
	private:
		//Loop number in the for-map
		int number;
		//Last loop number in the for-map
		int lastNum;
		//Counter variable name
		string counterName;
		//Counter start value
		string startVal;
		//Counter and value
		string endVal;
		//Store order information, command(string), I(queue<string>), O(queue<string>)
		queue<pair<string,pair<queue<string>,queue<string> > > > orderStrQueue;
		//Store the modified global variables information, name(string), type and value(VariableInfo)
		map<string,VariableInfo> modifiedGlobalVars;
	public:
		//Store the local variable
		map<string,VariableInfo> varMap;
		map<string,VariableInfo>::iterator mi;
		//Store the loop information
		void storeLoopInfo(string _counterName,string _startVal,string _endVal,int _number,int _lastNum){
			counterName = _counterName;
			startVal = _startVal;
			endVal = _endVal;
			number = _number;
			lastNum = _lastNum;
			cout<<number<<" from "<<lastNum<<", counter "<<counterName<<", start value "<<startVal<<", end value "<<endVal<<endl;
			//Make sure every loop has just its own orders
			if(!orderStrQueue.empty()){
				while(!orderStrQueue.empty()){
					orderStrQueue.pop();
				}
			}
			//Make sure every loop has just its own global variables
			if(!modifiedGlobalVars.empty()){
				for(map<string,VariableInfo>::iterator clearMI=modifiedGlobalVars.begin();clearMI!=modifiedGlobalVars.end();clearMI++){
					modifiedGlobalVars.erase((*clearMI).first);
				}
				cout<<" Global variable map is clear. "<<endl;
			}
			//Make sure every loop has just its own variable map
			if(!varMap.empty()){
				for(map<string,VariableInfo>::iterator clearMI=varMap.begin();clearMI!=varMap.end();clearMI++){
					varMap.erase((*clearMI).first);
				}
				cout<<" Variable map is clear. "<<endl;
			}
		}
		//Start loop processing
		map<int,ForWordSepSys> startLoop(map<int,ForWordSepSys> _forObjectMap){
			
			cout<<"\nLoop "<<number<<" start."<<endl;
			//Copy the for-object map
			map<int,ForWordSepSys> forObjectMap = _forObjectMap;
			
			cout<<"Loop "<<number<<"'s orders:"<<endl;
			map<int,ForWordSepSys>::iterator orderMI = forObjectMap.find(number);
			queue<pair<string,pair<queue<string>,queue<string> > > > _orderQueue = (*orderMI).second.getOrderStrQueue();
			while(!_orderQueue.empty()){
				cout<<"order is "<<_orderQueue.front().first<<endl;
				_orderQueue.pop();
			}
			
			//Store start and end value
			pair<string,VariableInfo> startValVar;
			startValVar.first = "startVal";
			startValVar.second.type = "int";
			pair<string,VariableInfo> endValVar;
			endValVar.first = "endVal";
			endValVar.second.type = "int";
			//Pair to store counter variable information
			pair<string,VariableInfo> counterVar;
			counterVar.first = counterName;
			counterVar.second.type = "int";
			//Check if start value is global input variable
			if(startVal[0] - '0'<49){
				counterVar.second.value = startVal;
				//Declare start value
				startValVar.second.value = startVal;
			} else{
				mi = modifiedGlobalVars.find(startVal);
				counterVar.second.value = (*mi).second.value;
				//Declare start value
				startValVar.second.value = (*mi).second.value;
			}
			//Check if end value is global input variable
			if(endVal[0] - '0'<49){
				//Declare start value
				endValVar.second.value = endVal;
			} else{
				mi = modifiedGlobalVars.find(endVal);
				//Declare start value
				endValVar.second.value = (*mi).second.value;
			}
			//Declare counter
			varMap.insert(counterVar);
			//Declare start value
			varMap.insert(startValVar);
			//Declare end value
			varMap.insert(endValVar);
			//For loop start
			for(int i=str2int(startValVar.second.value);i<=str2int(endValVar.second.value);i++){
				cout<<"\nLoop "<<number<<"'s loop "<<i<<":"<<endl;
				//Decode and process the order
				forObjectMap = orderDecode(forObjectMap);
				//Update counter value
				mi = varMap.find(counterName);
				//Loop if not violating the conditions
				if(str2int((*mi).second.value)<=str2int(endValVar.second.value)){
					pair<string,VariableInfo> newCounter;
					newCounter.first = (*mi).first;
					newCounter.second.type = (*mi).second.type;
					newCounter.second.value = int2str(str2int((*mi).second.value)+1);
					varMap.erase(counterName);
					varMap.insert(newCounter);
				}
				cout<<"\nLoop "<<number<<"'s loop "<<i<<" result:"<<endl;
				for(map<string,VariableInfo>::iterator f_mi=varMap.begin();f_mi!=varMap.end();f_mi++){
					cout<<(*f_mi).first<<" "<<(*f_mi).second.type<<" "<<(*f_mi).second.value<<endl;
				}
				system("pause");
			}
			//Check for global modified global variables
			if(number == 1){
				map<int,ForWordSepSys>::iterator forObjectMapMI = forObjectMap.find(0);
				map<string,VariableInfo>::iterator globalVarMapMI;
				map<string,VariableInfo>::iterator forVarMapMI;
				map<string,VariableInfo>::iterator modifiedVarMapMI;
				for(forVarMapMI = varMap.begin();forVarMapMI != varMap.end();forVarMapMI++){
					globalVarMapMI = (*forObjectMapMI).second.varMap.find((*forVarMapMI).first);
					modifiedVarMapMI = modifiedGlobalVars.find((*forVarMapMI).first);
					if(globalVarMapMI!=(*forObjectMapMI).second.varMap.end() && modifiedVarMapMI==modifiedGlobalVars.end()){
						modifiedGlobalVars.insert(*forVarMapMI);
					}
				}
			}
			cout<<"\nLoop "<<number<<" is going to push itself into for-object map."<<endl;
			//Push self(*this) to the map
			pair<int,ForWordSepSys> selfForObject;
			selfForObject.first = number;
			selfForObject.second = *this;
			forObjectMap.erase(number);
			forObjectMap.insert(selfForObject);
			cout<<"Loop "<<number<<" finish pushing."<<endl;
			return forObjectMap;
		}
		//Extract the I/O variable names(pair<queue<string>,queue<string> >) and command types(string)
		void popAndExtractOrderInfo(string _order){
			//Extract the variable
			size_t pos = _order.find_first_of(' ');
			string command = _order.substr(0,pos-0);
			//Store the variable names(I/O)
			pair<queue<string>,queue<string> > varNames;
			int commandType = 0;
			if(command == "for") commandType = 1;
			else if(command == "if") commandType = 2;
			else if(command == "end") commandType = 3;
			else{
				commandType = 0;
			}
			if(commandType == 0){
				//Diferentiate plus or given value
				size_t plusPos = _order.find('+');
				if(plusPos != string::npos){
					//To extract the plus-value variables and store into queue
					size_t equalPos = _order.find('=');
					varNames.second.push(_order.substr(0,equalPos-0));
					PlusSeperation plusParams;
					plusParams.extractParams(_order.substr(equalPos+1));
					varNames.first = plusParams.getQueue();
				} else{
					//To extract the given-value variables
					size_t equalPos = _order.find('=');
					//Store input variable
					varNames.first.push(_order.substr(equalPos+1));
					//Store output variable
					varNames.second.push(_order.substr(0,equalPos-0));
				}
			}
			pair<string,pair<queue<string>,queue<string> > > resultPair(command,varNames);
			//Store order information into order queue
			orderStrQueue.push(resultPair);
		}
		//Called to mark the value-changed site
		void pushTakeValueFromLast(int _nextNum){
			//Store the variable names(I/O)
			pair<queue<string>,queue<string> > varNames;
			//To extract the take-value orders, ex: takeValFrom 1
			string command = "takeValFromLast";
			varNames.first.push(int2str(_nextNum));
			varNames.second.push("None");
			pair<string,pair<queue<string>,queue<string> > > resultPair(command,varNames);
			//Store order information into order queue
			orderStrQueue.push(resultPair);
		}
		//load the global variable information into for object
		void loadGlobalValues(map<string,VariableInfo> _globalVars){
			//Insert global variables
			for (map<string,VariableInfo>::iterator g_mi=_globalVars.begin(); g_mi!=_globalVars.end(); g_mi++){
				//find if repeat loading variable
				mi = varMap.find((*g_mi).first);
				if(mi == varMap.end()){
					modifiedGlobalVars.insert((*g_mi));
					varMap.insert((*g_mi));
				} else if(mi != varMap.end()){
					modifiedGlobalVars.erase((*g_mi).first);
					varMap.erase((*g_mi).first);
					modifiedGlobalVars.insert((*g_mi));
					varMap.insert((*g_mi));
				}
			}
		}
		//Decode and process the order
		map<int,ForWordSepSys> orderDecode(map<int,ForWordSepSys> _forObjectMap){
			map<int,ForWordSepSys> forObjectMap = _forObjectMap;
			//forMI points to the next for loop
			map<int,ForWordSepSys>::iterator forMI;
			queue<pair<string,pair<queue<string>,queue<string> > > > orders = orderStrQueue;
			cout<<"Loop "<<number<<"'s orders are decoding..."<<endl;
			while(!orders.empty()){
				cout<<"Order is "<<orders.front().first<<endl;
				//Check if it is plus order
				size_t equalPos = orders.front().first.find('=');
				size_t plusPos = orders.front().first.find('+');
				if(plusPos != string::npos){
					plusValue(orders.front().second.first,orders.front().second.second);
				} else if(plusPos == string::npos && equalPos != string::npos){
					givenValue(orders.front().second.first,orders.front().second.second);
				} else if(orders.front().first == "takeValFromLast" && equalPos == string::npos){
				
					//Input variables to the varMap
					//forMI points to the next for loop
					forMI = forObjectMap.find(str2int(orders.front().second.first.front()));
					//Store the next loop's orders
					queue<pair<string,pair<queue<string>,queue<string> > > > forInfoQueue = (*forMI).second.getOrderStrQueue();
					pair<string,pair<queue<string>,queue<string> > > forInfoPair;
					//Look for all next loop's orders to find the inputs, and than sends this loop's values back
					while(!forInfoQueue.empty()){
						forInfoPair = forInfoQueue.front();
					
						//Temporary vector to store variables
						vector<string> forVarVector;
						vector<string>::iterator vi;
						//Check the input variable
						queue<string> inputVarNames = forInfoPair.second.first;
						size_t multPos;
						//If the variable is existed before, find and insert it into globalInputs
						while(!inputVarNames.empty()){
							multPos = inputVarNames.front().find('*');
							mi = varMap.find(inputVarNames.front());
							if(mi != varMap.end() && multPos == string::npos){
								forVarVector.push_back(inputVarNames.front());
							} else if(mi != varMap.end() && multPos != string::npos){
								//Decode if there are multiply
								MultSeperation multParams;
								multParams.extractParams(inputVarNames.front());
								queue<string> multVarsQueue = multParams.getQueue();
								while(!multVarsQueue.empty()){
									mi = varMap.find(multVarsQueue.front());
									if(mi != varMap.end()){
										forVarVector.push_back(multVarsQueue.front());
									}
									multVarsQueue.pop();
								}
							} else{
								//Find all for-objects from the newest one, store var as variable name+" "+for-object number
								for(int j=number-1;j>=0;j--){
									map<int,ForWordSepSys>::iterator otherwiseMI = forObjectMap.find(j);
									mi = (*otherwiseMI).second.varMap.find(inputVarNames.front());
									if(mi != (*otherwiseMI).second.varMap.end()){
										forVarVector.push_back(inputVarNames.front()+" "+int2str(j));
										break;
									}
								}
							}
							inputVarNames.pop();
						}
						
						//Store the global variables into for-object
						map<string,VariableInfo> globalVars;
						for(vi = forVarVector.begin();vi != forVarVector.end();vi++){
							mi = varMap.find((*vi));
							if(mi != varMap.end())
								globalVars.insert((*mi));
							else{
								//If the variable isn't in this scope
								size_t spacePos = (*vi).find(' ');
								map<int,ForWordSepSys>::iterator otherScopeMI = forObjectMap.find(str2int((*vi).substr(spacePos+1)));
								map<string,VariableInfo>::iterator otherScopeVarMI = (*otherScopeMI).second.varMap.find((*vi).substr(0,spacePos));
								globalVars.insert((*otherScopeVarMI));
								cout<<(*otherScopeVarMI).first<<" is found in loop "<<(*vi).substr(spacePos+1);
								cout<<" with type: "<<(*otherScopeVarMI).second.type<<", value: "<<(*otherScopeVarMI).second.value<<endl;
							}
						}
						//Store the information of the next loop
						pair<int,ForWordSepSys> tempForObject;
						forMI = forObjectMap.find(str2int(orders.front().second.first.front()));
						tempForObject.second = (*forMI).second;
						tempForObject.first = str2int(orders.front().second.first.front());
						forObjectMap.erase(str2int(orders.front().second.first.front()));
						tempForObject.second.loadGlobalValues(globalVars);
						forObjectMap.insert(tempForObject);
						
						forInfoQueue.pop();
					}
					//Update the forObjectMap
					forMI = forObjectMap.find((*forMI).second.getNum());
					cout<<"Now loop "<<(*forMI).second.getNum()<<" has global values:"<<endl;
					map<string,VariableInfo> tempGlobVars = (*forMI).second.getModifiedGlobalVars();
					for(map<string,VariableInfo>::iterator globMI=tempGlobVars.begin();globMI!=tempGlobVars.end();globMI++){
						cout<<(*globMI).first<<" "<<(*globMI).second.type<<" "<<(*globMI).second.value<<endl;
					}
					system("pause");
					//Start the next loop
					cout<<"Loop "<<(*forMI).second.getNum()<<" will start loop and get back to loop "<<number<<endl;
					//Temporarily store the next loop number
					int tempNextLoopNum = (*forMI).second.getNum();
					forObjectMap = (*forMI).second.startLoop(forObjectMap);
					forMI = forObjectMap.find(tempNextLoopNum);
					cout<<"Loop "<<(*forMI).second.getNum()<<" ended loop and get back to loop "<<number<<endl;
					//Update the varMap
					forMI = forObjectMap.find((*forMI).second.getNum());
					map<string,VariableInfo> tempVars = (*forMI).second.getModifiedGlobalVars();
					cout<<"Loop "<<(*forMI).second.getNum()<<" send modified variables to loop "<<number<<endl;
					string varName;
					pair<string,VariableInfo> tempVar;
					for(map<string,VariableInfo>::iterator varNameMI=tempVars.begin();varNameMI!=tempVars.end();varNameMI++){
						varName = (*varNameMI).first;
						varMap.erase(varName);
						tempVar = (*varNameMI);
						varMap.insert(tempVar);
					}
				} else{
					printf("Unsupported command.\n");
				}
				orders.pop();
			}
			return forObjectMap;
		}
		//Given value
		void givenValue(queue<string> _inputVars,queue<string> _outputVars){
			//Store result variable information
			pair<string,VariableInfo> output;
			output.first = _outputVars.front();
			size_t multPos = _inputVars.front().find('*');
			size_t floatPos = _inputVars.front().find('.');
			size_t stringPos = _inputVars.front().find('"');
			if(multPos == string::npos && floatPos == string::npos && stringPos == string::npos){
				output.second.type = "int";
				output.second.value = _inputVars.front();
			} else if(multPos == string::npos && floatPos != string::npos && stringPos == string::npos){
				output.second.type = "float";
				output.second.value = _inputVars.front();
			} else if(multPos == string::npos && floatPos == string::npos && stringPos != string::npos){
				output.second.type = "string";
				output.second.value = _inputVars.front();
			} else if(multPos != string::npos && floatPos == string::npos && stringPos == string::npos && _inputVars.front()[0] - '0'<49 && _inputVars.front()[0] - '0'>=0){
				output.second.type = "int";
				MultSeperation params;
				params.extractParams(_inputVars.front());
				queue<string> multInt = params.getQueue();
				string outputVal = "1";
				while(!multInt.empty()){
					//Check if input is variable
					if(multInt.front()[0] - '0'>=49){
						mi = varMap.find(multInt.front());
						outputVal = int2str(str2int(outputVal) * str2int((*mi).second.value));
					} else{
						outputVal = int2str(str2int(outputVal) * str2int(multInt.front()));
					}
					multInt.pop();
				}
				output.second.value = outputVal;
			} else if(multPos != string::npos && floatPos != string::npos && stringPos == string::npos && _inputVars.front()[0] - '0'<49 && _inputVars.front()[0] - '0'>0){
				output.second.type = "float";
				MultSeperation params;
				params.extractParams(_inputVars.front());
				queue<string> multFloat = params.getQueue();
				string outputVal = "1";
				while(!multFloat.empty()){
					if(multFloat.front()[0] - '0'>=49){
						mi = varMap.find(multFloat.front());
						outputVal = float2str(str2float(outputVal) * str2float((*mi).second.value));
					} else{
						outputVal = float2str(str2float(outputVal) * str2float(multFloat.front()));
					}
					multFloat.pop();
				}
				output.second.value = outputVal;
			} else if(multPos != string::npos && floatPos == string::npos && stringPos == string::npos && _inputVars.front()[0] - '0'>=49){
				MultSeperation params;
				params.extractParams(_inputVars.front());
				queue<string> multVars = params.getQueue();
				string outputVal = "1";
				if((*mi).second.type == "int"){
					output.second.type = "int";
					while(!multVars.empty()){
						mi = varMap.find(multVars.front());
						outputVal = int2str(str2int(outputVal) * str2int((*mi).second.value));
						multVars.pop();
					}
				} else if((*mi).second.type == "float"){
					output.second.type = "float";
					while(!multVars.empty()){
						mi = varMap.find(multVars.front());
						outputVal = float2str(str2float(outputVal) * str2float((*mi).second.value));
						multVars.pop();
					}
				}
			}
			//Check if output variable existed before
			map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
			if(repeatMI == varMap.end()){
				varMap.insert(output);
			} else{
				varMap.erase(_outputVars.front());
				varMap.insert(output);
			}
		}
		//Plus value
		void plusValue(queue<string> _inputVars,queue<string> _outputVars){
			string outputVal = "0";
			queue<string> inputs = _inputVars;
			//Add all inputs
			while(!inputs.empty()){
				//Check if it exist in variable list, if not, find its type
				mi = varMap.find(inputs.front());
				//Find the string
				size_t stringPos = inputs.front().find('"');
				//Find the float
				size_t floatPos = inputs.front().find('.');
				//Find the multifying sign
				size_t multPos = inputs.front().find('*');
				//If input name is not variable name, note: 'a'-'0' = 49, 'z'-'0' = 75, '"'-'0' = -14
				if(mi == varMap.end() && inputs.front()[0] - '0'<49){
					//Find the type and add together
					if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && floatPos == string::npos && multPos == string::npos){
						//Add integer together
						outputVal = int2str(str2int(outputVal)+str2int(inputs.front()));
						//Made input pair and insert into varMap
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					} else if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && multPos == string::npos && floatPos != string::npos){
						//Add float together
						outputVal = float2str(str2float(outputVal)+str2float(inputs.front()));
						//Made output and add into varMap
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					} else if(stringPos != string::npos){
						//Add strings togeter
						outputVal = outputVal + inputs.front();
						//Made output and insert into varMap
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "string";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					} else if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && multPos != string::npos && floatPos == string::npos){
						MultSeperation multParams;
						multParams.extractParams(inputs.front());
						queue<string> multValQueue = multParams.getQueue();
						string multVal = "1";
						while(!multValQueue.empty()){
							//Check if it is variable
							if(multValQueue.front()[0] - '0'<49){
								multVal = int2str(str2int(multVal) * str2int(multValQueue.front()));
							} else{
								mi = varMap.find(multValQueue.front());
								multVal = int2str(str2int(multVal) * str2int((*mi).second.value));
							}
							multValQueue.pop();
						}
						outputVal = int2str(str2int(outputVal) + str2int(multVal));
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					} else if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && multPos != string::npos && floatPos != string::npos){
						MultSeperation multParams;
						multParams.extractParams(inputs.front());
						queue<string> multValQueue = multParams.getQueue();
						string multVal = "1.0";
						while(!multValQueue.empty()){
							//Check if it is variable
							if(multValQueue.front()[0] - '0'<49){
								multVal = float2str(str2float(multVal) * str2float(multValQueue.front()));
							} else{
								mi = varMap.find(multValQueue.front());
								multVal = float2str(str2float(multVal) * str2float((*mi).second.value));
							}
							multValQueue.pop();
						}
						outputVal = float2str(str2float(outputVal) + str2float(multVal));
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					}
				} else if(mi != varMap.end() && inputs.front()[0] - '0'>=49){
					//Store the plus inputs
					map<string,VariableInfo>::iterator plusMI;
					plusMI = varMap.find(inputs.front());
					if((*plusMI).second.type == "int"){
						outputVal = int2str(str2int(outputVal)+str2int((*plusMI).second.value));
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					} else if((*plusMI).second.type == "float"){
						outputVal = float2str(str2float(outputVal)+str2float((*plusMI).second.value));
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					} else if((*plusMI).second.type == "string"){
						outputVal = outputVal + (*plusMI).second.value;
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "string";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					}	
				} else if(mi == varMap.end() && inputs.front()[0] - '0'>=49){
					//Decode Var*Var to multiply inputs;
					MultSeperation multParams;
					multParams.extractParams(inputs.front());
					queue<string> multValQueue = multParams.getQueue();
					map<string,VariableInfo>::iterator multMI = varMap.find(multValQueue.front());
					if((*multMI).second.type == "int"){
						string multVal = "1";
						while(!multValQueue.empty()){
							//Store the next multiply element
							multMI = varMap.find(multValQueue.front());
							multVal = int2str(str2int(multVal) * str2int((*multMI).second.value));
							multValQueue.pop();
						}
						outputVal = int2str(str2int(outputVal) + str2int(multVal));
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					} else if((*multMI).second.type == "float"){
						string multVal = "1.0";
						while(!multValQueue.empty()){
							//Store the next multiply element
							multMI = varMap.find(multValQueue.front());
							multVal = float2str(str2float(multVal) * str2float((*multMI).second.value));
							multValQueue.pop();
						}
						outputVal = float2str(str2float(outputVal) + str2float(multVal));
						pair<string,VariableInfo> output;
						output.first = _outputVars.front();
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(_outputVars.front());
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(_outputVars.front());
							varMap.insert(output);
						}
					}
				} else{
					printf("Nothing\n");
				}
				inputs.pop();
			}
		}
		//Return the modified global variables
		map<string,VariableInfo> getModifiedGlobalVars(){
			string varName;
			pair<string,VariableInfo> tempVar;
			for(map<string,VariableInfo>::iterator varNameMI=modifiedGlobalVars.begin();varNameMI!=modifiedGlobalVars.end();varNameMI++){
				varName = (*varNameMI).first;
				modifiedGlobalVars.erase(varName);
				mi = varMap.find(varName);
				tempVar = (*mi);
				modifiedGlobalVars.insert(tempVar);
			}
			return modifiedGlobalVars;
		}
		//Get the number
		int getNum(){
			return number;
		}
		//Get the order information, command(string), I(queue<string>), O(queue<string>)
		queue<pair<string,pair<queue<string>,queue<string> > > > getOrderStrQueue(){
			return orderStrQueue;
		}
};

//Word separation system - Read the file and call other functions to convert orders into program
class WordSepSys{
	private:
		//Store the orders
		queue<string> strQueue;
		//Store the functions
		FuncSeperation func1;
		//Store all for-objects
		map<int,ForWordSepSys> forObjectMap;
	public:
		map<int,ForWordSepSys>::iterator forMI;
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
			
			//Store the for object number
			int number = 1;
			//Decode the order line-by-line
			while(!_stringQueue.empty()){
				
				//Extract the command type, 1:for, 2:if, 3:end
				size_t pos = _stringQueue.front().find_first_of(' ');
				string command = _stringQueue.front().substr(0,pos-0);
				int commandType = 0;
				if(command == "for") commandType = 1;
				else if(command == "if") commandType = 2;
				else if(command == "end") commandType = 3;
				else{
					commandType = 0;
				}
				//Do different behaviors according to command type
				switch(commandType){
					
					//Do for command
					case 1:{
						printf("for ");
						
						//Temporary construct a non-existing for-object to store the global varMap, represent the WordSepSys object, and insert to for-object map
						ForWordSepSys tempGlobLoop;
						tempGlobLoop.storeLoopInfo("None","0","0",0,-1);
						tempGlobLoop.varMap = varMap;
						forObjectMap.insert(make_pair(0,tempGlobLoop));
						//The stack to temporarily store the for-object
						stack<ForWordSepSys> forStack;
						//Decode first for order
						size_t equalPos = _stringQueue.front().find('=');
						size_t colonPos = _stringQueue.front().find(':');
						//Restore counter name
						string forCounterName = _stringQueue.front().substr(pos+1,equalPos-pos-1);
						//Restore start and end
						string forStartVal = _stringQueue.front().substr(equalPos+1,colonPos-equalPos-1);
						string forEndVal = _stringQueue.front().substr(colonPos+1);
						ForWordSepSys otherLoop;
						otherLoop.storeLoopInfo(forCounterName,forStartVal,forEndVal,number,0);
						number = number + 1;
						_stringQueue.pop();
						//Determine whether to continue decode the orders
						bool isContinue = 1;
						//Determine which for-object should be make
						bool keepMakingFor = 1;
						//Determine current order should pop into which for-object
						int popOrderToFor = 2;
						//Construct all for objects, give them the orders and push into forStack
						while(isContinue){
							
							size_t spacePos = _stringQueue.front().find_first_of(' ');
							string inForCommand = _stringQueue.front().substr(0,spacePos-0);
							if(inForCommand == "end"){
								cout<<"End"<<endl<<endl;
								isContinue = 0;
								break;
							} else if(inForCommand == "for"){
								otherLoop.pushTakeValueFromLast(number);
								forStack.push(otherLoop);
								//To determine whether to make new for-object
								keepMakingFor = 1;
								popOrderToFor = popOrderToFor + 1;
								//Make new for-object
								while(keepMakingFor){
									printf("\nfor ");
									
									//Decode other for order
									equalPos = _stringQueue.front().find('=');
									colonPos = _stringQueue.front().find(':');
									//Restore counter name
									forCounterName = _stringQueue.front().substr(pos+1,equalPos-pos-1);
									//Restore start and end
									forStartVal = _stringQueue.front().substr(equalPos+1,colonPos-equalPos-1);
									forEndVal = _stringQueue.front().substr(colonPos+1);
									otherLoop.storeLoopInfo(forCounterName,forStartVal,forEndVal,number,forStack.top().getNum());
									_stringQueue.pop();
									//Pop the orders to new for-object
									while(popOrderToFor > 1){
										size_t spacePos = _stringQueue.front().find_first_of(' ');
										string inForCommand = _stringQueue.front().substr(0,spacePos-0);
										if(inForCommand == "end"){
											if(otherLoop.getNum() > 1){
												cout<<"End"<<endl<<endl;
												//Store the for-object number and information into forObjectMap
												pair<int ,ForWordSepSys> tempForObject(otherLoop.getNum(),otherLoop);
												forObjectMap.insert(tempForObject);
											}
											//Update flags
											keepMakingFor = 0;
											popOrderToFor = popOrderToFor - 1;
											//Throw to map
											//Update the otherLoop
											if(!forStack.empty() && otherLoop.getNum() > 1){
												otherLoop = forStack.top();
											} else{
												keepMakingFor = 0;
												popOrderToFor = 0;
												break;
											}
											if(!forStack.empty() && otherLoop.getNum() > 1){
												forStack.pop();
											}
											_stringQueue.pop();
										} else if(inForCommand == "for"){
											otherLoop.pushTakeValueFromLast(number+1);
											forStack.push(otherLoop);
											keepMakingFor = 1;
											popOrderToFor = popOrderToFor + 1;
											break;
										} else{
											//Pop an order into for-object, for-object should store the needed and will-be-modified variable names
											cout<<"Order is popped to for-object "<<otherLoop.getNum()<<endl;
											otherLoop.popAndExtractOrderInfo(_stringQueue.front());
											_stringQueue.pop();
										}
									}
									//Update next for-object number
									number = number + 1;
								}
							} else{
								//Pop an order into for-object, for-object should store the needed and will-be-modified variable names
								otherLoop.popAndExtractOrderInfo(_stringQueue.front());
								cout<<"Order is popped to for-object 1"<<endl;
								_stringQueue.pop();
							}
						}
						//Store the for-object number and information into forObjectMap
						pair<int,ForWordSepSys> tempForObject(otherLoop.getNum(),otherLoop);
						forObjectMap.insert(tempForObject);
						
						//Load the global input into first loop
						forMI = forObjectMap.find(1);
						queue<pair<string,pair<queue<string>,queue<string> > > > forInfoQueue = (*forMI).second.getOrderStrQueue();
						pair<string,pair<queue<string>,queue<string> > > forInfoPair;
						
						while(!forInfoQueue.empty()){
							forInfoPair = forInfoQueue.front();
							if(forInfoPair.first == "takeValFromLast")
								break;
							//Temporary vector to store variables
							vector<string> forVarVector;
							vector<string>::iterator vi;
							//Check the input variable
							queue<string> inputVarNames = forInfoPair.second.first;
							size_t multPos;
							//If the variable is existed before, find and insert it into globalInputs
							while(!inputVarNames.empty()){
								multPos = inputVarNames.front().find('*');
								mi = varMap.find(inputVarNames.front());
								if(mi != varMap.end() && multPos == string::npos){
									forVarVector.push_back(inputVarNames.front());
								} else if(multPos != string::npos){
									//Decode if there are multiply
									MultSeperation multParams;
									multParams.extractParams(inputVarNames.front());
									queue<string> multVarsQueue = multParams.getQueue();
									while(!multVarsQueue.empty()){
										mi = varMap.find(multVarsQueue.front());
										if(mi != varMap.end()){
											forVarVector.push_back(multVarsQueue.front());
										}
										multVarsQueue.pop();
									}
								}
								inputVarNames.pop();
							}
						
							//Store the global variables into for-object
							map<string,VariableInfo> globalVars;
							for(vi = forVarVector.begin();vi != forVarVector.end();vi++){
								mi = varMap.find((*vi));
								globalVars.insert((*mi));
							}
							forMI = forObjectMap.find(1);
							tempForObject.second = (*forMI).second;
							tempForObject.first = 1;
							forObjectMap.erase(1);
							tempForObject.second.loadGlobalValues(globalVars);
							forObjectMap.insert(tempForObject);
							
							forInfoQueue.pop();
						}
						//Start the loop
						forMI = forObjectMap.find(1);
						forObjectMap = (*forMI).second.startLoop(forObjectMap);
						//Update the varMap
						forMI = forObjectMap.find(1);
						map<string,VariableInfo> tempVars = (*forMI).second.getModifiedGlobalVars();
						string varName;
						pair<string,VariableInfo> tempVar;
						for(map<string,VariableInfo>::iterator varNameMI=tempVars.begin();varNameMI!=tempVars.end();varNameMI++){
							varName = (*varNameMI).first;
							varMap.erase(varName);
							tempVar = (*varNameMI);
							varMap.insert(tempVar);
						}
												
						break;
					}
					//Do if command
					case 2:{
						printf("if\n");
						break;
					}
					//Skip end command
					case 3:{
						printf("end\n");
						break;
					}
					//Do other command
					default:
						//Diferentiate plus or given value
						size_t plusPos = _stringQueue.front().find('+');
						if(plusPos != string::npos){
							//To process the plus-value orders
							plusValue(_stringQueue.front());
						} else{
							//To process the given-value orders
							givenValue(_stringQueue.front());
						}
					
				}
				
				_stringQueue.pop();
				
			}
			cout<<"\nTotal results:"<<endl;
			seeVariables(*this);
			for(map<int,ForWordSepSys>::iterator for_mi=forObjectMap.begin();for_mi!=forObjectMap.end();for_mi++){
				cout<<"Loop "<<(*for_mi).first<<" done."<<endl;
			}
			cout<<endl;
			
		}
		//To process the given-value orders
		void givenValue(string _givenOrder){
			//Find the equal site
			size_t equalPos = _givenOrder.find('=');
			//Find the multiply site
			size_t multPos = _givenOrder.find('*');
			//Find if the variable is a float
			size_t floatPos = _givenOrder.find('.');
			//Find if the variable is a string
			size_t strPos = _givenOrder.find('"');
			//According to data type store the data
			if(floatPos != string::npos && multPos == string::npos){
				//Store the float-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "float";
				info.value = _givenOrder.substr(equalPos+1);
				//Check if existed before
				mi = varMap.find(name);
				if(mi == varMap.end()){
					varMap.insert(pair<string,VariableInfo>(name,info));
				} else{
					varMap.erase(name);
					varMap.insert(pair<string,VariableInfo>(name,info));
				}
			} else if(strPos != string::npos && multPos == string::npos){
				//Store the string-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "string";
				info.value = _givenOrder.substr(equalPos+1);
				//Check if existed before
				mi = varMap.find(name);
				if(mi == varMap.end()){
					varMap.insert(pair<string,VariableInfo>(name,info));
				} else{
					varMap.erase(name);
					varMap.insert(pair<string,VariableInfo>(name,info));
				}
			} else if(floatPos == string::npos && strPos == string::npos && multPos == string::npos){
				//Store the int-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "int";
				info.value = _givenOrder.substr(equalPos+1);
				//Check if existed before
				mi = varMap.find(name);
				if(mi == varMap.end()){
					varMap.insert(pair<string,VariableInfo>(name,info));
				} else{
					varMap.erase(name);
					varMap.insert(pair<string,VariableInfo>(name,info));
				}
			} else if(floatPos != string::npos && multPos != string::npos){
				MultSeperation multParams;
				multParams.extractParams(_givenOrder.substr(equalPos+1));
				queue<string> floatQueue = multParams.getQueue();
				string outputVal = "1";
				while(!floatQueue.empty()){
					if(floatQueue.front()[0] - '0'<49 && floatQueue.front()[0] - '0'>0){
						outputVal = float2str(str2float(outputVal) * str2float(floatQueue.front()));
					} else if(floatQueue.front()[0] - '0'>=49){
						mi = varMap.find(floatQueue.front());
						outputVal = float2str(str2float(outputVal) * str2float((*mi).second.value));
					}
					floatQueue.pop();
				}
				//Store the float-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "float";
				info.value = outputVal;
				//Check if existed before
				mi = varMap.find(name);
				if(mi == varMap.end()){
					varMap.insert(pair<string,VariableInfo>(name,info));
				} else{
					varMap.erase(name);
					varMap.insert(pair<string,VariableInfo>(name,info));
				}
			} else if(floatPos == string::npos && strPos == string::npos && multPos != string::npos && _givenOrder.substr(equalPos+1)[0] - '0'<49 && _givenOrder.substr(equalPos+1)[0] - '0'>=0){
				MultSeperation multParams;
				multParams.extractParams(_givenOrder.substr(equalPos+1));
				queue<string> intQueue = multParams.getQueue();
				string outputVal = "1.0";
				while(!intQueue.empty()){
					if(intQueue.front()[0] - '0'<49 && intQueue.front()[0] - '0'>0){
						outputVal = int2str(str2int(outputVal) * str2int(intQueue.front()));
					} else if(intQueue.front()[0] - '0'>=49){
						mi = varMap.find(intQueue.front());
						outputVal = int2str(str2int(outputVal) * str2int((*mi).second.value));
					}
					intQueue.pop();
				}
				//Store the float-type variable
				string name = _givenOrder.substr(0,equalPos-0);
				VariableInfo info;
				info.type = "int";
				info.value = outputVal;
				//Check if existed before
				mi = varMap.find(name);
				if(mi == varMap.end()){
					varMap.insert(pair<string,VariableInfo>(name,info));
				} else{
					varMap.erase(name);
					varMap.insert(pair<string,VariableInfo>(name,info));
				}
			} else if(floatPos == string::npos && strPos == string::npos && multPos != string::npos && _givenOrder.substr(equalPos+1)[0] - '0'>=49){
				MultSeperation multParams;
				multParams.extractParams(_givenOrder.substr(equalPos+1));
				queue<string> varQueue = multParams.getQueue();
				string outputVal = "1";
				VariableInfo info;
				while(!varQueue.empty()){
					mi = varMap.find(varQueue.front());
					if((*mi).second.type == "int"){
						outputVal = int2str(str2int(outputVal) * str2int((*mi).second.value));
						info.type = "int";
					} else if((*mi).second.type == "float"){
						outputVal = float2str(str2float(outputVal) * str2float((*mi).second.value));
						info.type = "float";
					}
					varQueue.pop();
				}
				//Store the variable
				string name = _givenOrder.substr(0,equalPos-0);
				info.value = outputVal;
				//Check if existed before
				mi = varMap.find(name);
				if(mi == varMap.end()){
					varMap.insert(pair<string,VariableInfo>(name,info));
				} else{
					varMap.erase(name);
					varMap.insert(pair<string,VariableInfo>(name,info));
				}
			}
		}
		//Handle the plus order
		void plusValue(string _plusOrder){
			//Extract input and output
			size_t equalPos = _plusOrder.find('=');
			PlusSeperation plusParams;
			plusParams.extractParams(_plusOrder.substr(equalPos+1));
			queue<string> inputs = plusParams.getQueue();
			string outputName = _plusOrder.substr(0,equalPos - 0);
			string outputVal = "0";
			//Add all inputs
			while(!inputs.empty()){
				//Check if it exist in variable list, if not, find its type
				mi = varMap.find(inputs.front());
				//Find the string
				size_t stringPos = inputs.front().find('"');
				//Find the float
				size_t floatPos = inputs.front().find('.');
				//Find the multifying sign
				size_t multPos = inputs.front().find('*');
				//If input name is not variable name, note: 'a'-'0' = 49, 'z'-'0' = 75, '"'-'0' = -14
				if(mi == varMap.end() && inputs.front()[0] - '0'<49){
					//Find the type and add together
					if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && floatPos == string::npos && multPos == string::npos){
						//Add integer together
						outputVal = int2str(str2int(outputVal)+str2int(inputs.front()));
						//Made input pair and insert into varMap
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					} else if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && multPos == string::npos && floatPos != string::npos){
						//Add float together
						outputVal = float2str(str2float(outputVal)+str2float(inputs.front()));
						//Made output and add into varMap
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					} else if(stringPos != string::npos){
						//Add strings togeter
						outputVal = outputVal + inputs.front();
						//Made output and insert into varMap
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "string";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					} else if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && multPos != string::npos && floatPos == string::npos){
						MultSeperation multParams;
						multParams.extractParams(inputs.front());
						queue<string> multValQueue = multParams.getQueue();
						string multVal = "1";
						while(!multValQueue.empty()){
							//Check if it is variable
							if(multValQueue.front()[0] - '0'<49){
								multVal = int2str(str2int(multVal) * str2int(multValQueue.front()));
							} else{
								mi = varMap.find(multValQueue.front());
								multVal = int2str(str2int(multVal) * str2int((*mi).second.value));
							}
							multValQueue.pop();
						}
						outputVal = int2str(str2int(outputVal) + str2int(multVal));
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					} else if(inputs.front()[0] - '0'<49 && inputs.front()[0] - '0'>=0 && multPos != string::npos && floatPos != string::npos){
						MultSeperation multParams;
						multParams.extractParams(inputs.front());
						queue<string> multValQueue = multParams.getQueue();
						string multVal = "1.0";
						while(!multValQueue.empty()){
							//Check if it is variable
							if(multValQueue.front()[0] - '0'<49){
								multVal = float2str(str2float(multVal) * str2float(multValQueue.front()));
							} else{
								mi = varMap.find(multValQueue.front());
								multVal = float2str(str2float(multVal) * str2float((*mi).second.value));
							}
							multValQueue.pop();
						}
						outputVal = float2str(str2float(outputVal) + str2float(multVal));
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					}
				} else if(mi != varMap.end() && inputs.front()[0] - '0'>=49){
					//Store the plus inputs
					map<string,VariableInfo>::iterator plusMI;
					plusMI = varMap.find(inputs.front());
					if((*plusMI).second.type == "int"){
						outputVal = int2str(str2int(outputVal)+str2int((*plusMI).second.value));
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					} else if((*plusMI).second.type == "float"){
						outputVal = float2str(str2float(outputVal)+str2float((*plusMI).second.value));
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					} else if((*plusMI).second.type == "string"){
						outputVal = outputVal + (*plusMI).second.value;
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "string";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					}	
				} else if(mi == varMap.end() && inputs.front()[0] - '0'>=49){
					//Decode Var*Var to multiply inputs;
					MultSeperation multParams;
					multParams.extractParams(inputs.front());
					queue<string> multValQueue = multParams.getQueue();
					map<string,VariableInfo>::iterator multMI = varMap.find(multValQueue.front());
					if((*multMI).second.type == "int"){
						string multVal = "1";
						while(!multValQueue.empty()){
							//Store the next multiply element
							multMI = varMap.find(multValQueue.front());
							multVal = int2str(str2int(multVal) * str2int((*multMI).second.value));
							multValQueue.pop();
						}
						outputVal = int2str(str2int(outputVal) + str2int(multVal));
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "int";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					} else if((*multMI).second.type == "float"){
						string multVal = "1.0";
						while(!multValQueue.empty()){
							//Store the next multiply element
							multMI = varMap.find(multValQueue.front());
							multVal = float2str(str2float(multVal) * str2float((*multMI).second.value));
							multValQueue.pop();
						}
						outputVal = float2str(str2float(outputVal) + str2float(multVal));
						pair<string,VariableInfo> output;
						output.first = outputName;
						output.second.type = "float";
						output.second.value = outputVal;
						//Check if output variable existed before
						map<string,VariableInfo>::iterator repeatMI = varMap.find(outputName);
						if(repeatMI == varMap.end()){
							varMap.insert(output);
						} else{
							varMap.erase(outputName);
							varMap.insert(output);
						}
					}
				} else{
					printf("Nothing\n");
				}
				inputs.pop();
			}
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

//See content in queue, usage: seeQueue<T>( __queue__ );
template <typename T>
void seeQueue(queue<T> _q){
	queue<T> q = _q;
	while(!q.empty()){
		cout<<q.front()<<" ";
		q.pop();
	}
	cout<<endl;
}

int main(){
	string functionAddr = "C:/Users/user/Desktop/test.txt";
	//string functionAddr = "C:/Users/Administrator/Desktop/test.txt"; 
	WordSepSys sepSys(functionAddr); //Build WordSepSys and convert into program
	
	cout<<"Function name: "<<sepSys.getFunc().getFuncName()<<endl;
	cout<<"Function input: ";
	seeQueue(sepSys.getFunc().getParams().getQueue());
	cout<<"Function output: "<<sepSys.getFunc().getOutputVarName()<<endl;
	
	system("pause");
	return 0;
}
