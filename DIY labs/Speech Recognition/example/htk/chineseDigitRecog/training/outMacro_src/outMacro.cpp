#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "s:\work\cbmrcluster\mylib\objAll.h"

void outMacroTxt(char* hsKind, char* covKind, int nStates, int nStreams, int* sWidths, int* mixes, char* paraKind, int vecSize){
	int i,j,ID,stateID,streamID,mx,temp;
	printf("~o <VecSize> %d <%s><%s> <StreamInfo> %d ",vecSize, paraKind,covKind, nStreams);
	for(i=0;i<nStreams;i++)
		printf("%d ",sWidths[i]);
	printf("\n<BeginHMM>\n");

	printf("<NUMSTATES> %d\n", nStates+2);
	for(stateID=2;stateID<=nStates+1;stateID++){
		printf("<STATE> %d",stateID);
		printf("<NUMMIXES> ");//<NUMMIXES> x x x
		for(i=0;i<nStreams;i++)
			printf("%d ",mixes[i]);
		for(streamID=0;streamID<nStreams; streamID++){
			printf("\n<STREAM> %d\n",streamID+1);// <STREAM>
			float avgMixtureWeight=(float)1/mixes[streamID];
			for(int mixtureID=1;mixtureID<=mixes[streamID];mixtureID++){	// <MIXTURE>
				printf("<MIXTURE> %d %e\n",mixtureID, avgMixtureWeight);
				printf("<MEAN> %d\n",sWidths[streamID]);	// <MEAN> dimensionSize
				for(mx=0; mx<sWidths[streamID]; mx++)	printf("0.0 ");
				printf("\n<VARIANCE> %d\n", sWidths[streamID]);// <VARIANCE> dimensionSize
				for(mx=0; mx<sWidths[streamID]; mx++)	printf("1.0 ");
				printf("\n");
			}
		}
	}

	nStates+=2;
	printf("<TRANSP> %d\n", nStates); // <TRANSP> stateNum

	float **transmat = new float*[nStates];
	for (int i=0;i<nStates; i++)
		transmat[i]=new float[nStates];
	for(i=0; i<nStates;i++)
	{
		for(int j=0;j<nStates;j++)
		{
			if (i==j) 
				transmat[i][j]=0.6f;
			else if (j==i+1) 
				transmat[i][j]=0.4f;
			else
				transmat[i][j]=0.0f;
		}
	}
	transmat[0][0]=0.0f;
	transmat[nStates-1][nStates-1]=0.0f;
	transmat[0][1]=1.0f;
	

	for(int i=0; i<nStates; i++)
	{
		for(int j=0; j<nStates; j++)
			printf("%e ",transmat[i][j]);
		printf("\n");	
	}		
	printf("<ENDHMM>");
	for (int i=0;i<nStates; i++)
		delete transmat[i];
	delete transmat;

}

int main(int argc, char **argv) {
	if (argc!=7) {
		printf("Usage: this.exe hsKind covKind nStates mixes paraKind streamList\n");
		printf("hsKind : P(?)\n");
		printf("covKind : InvDiagC/DiagC/FullC\n");
		printf("nStates : 1(3,5)\n");
		printf("mixes, mixes for each stream: \"6 6 6\"(3 streams here)\n");
		printf("paraKind : MFCC_E_D_A_Z(case-by-case)\n");
		printf("streamList, feature dimension for each stream : \"13 13 13\"(also 3 streams here)\n");
		exit(-1);
	}

	char hsKind[2];//=P
	char covKind[10];//=D
	int nStates;//=3
	char paraKind[100];//=MFCC_E_D_A_Z

	sscanf(argv[1],"%s", &hsKind);
	sscanf(argv[2],"%s", &covKind);
	sscanf(argv[3],"%d", &nStates);
	sscanf(argv[5],"%s", &paraKind);

	//u must copy static argv[4] into a modifiable memory like tmpstr, if you use strtok();
	
	String strobj(1000);
	
  StringArray list_stream(100, 10, 10);
	int nStreams = strobj.split(argv[6], " ", &list_stream);

  StringArray list_mix(nStreams, 10, 10);
	int nMix = strobj.split(argv[4], " ", &list_mix);

    if (nStreams!=nMix)
    {
        printf("number of streams not the same as number of mixtures\n");
	    exit(1);
	}
	int* mixes = new int[nStreams];
	int* sWidths = new int[nStreams];//=13 13 13
	int vecSize = 0; 
	for (int i=0;i<nStreams;i++)
	{
		mixes[i] = atoi(list_mix.rowAt(i));
		sWidths[i]=atoi(list_stream.rowAt(i));
        vecSize += sWidths[i];
	}
	
	outMacroTxt(hsKind, covKind, nStates, nStreams, sWidths, mixes, paraKind, vecSize) ;
	delete mixes;
	delete sWidths;
    exit(0);    
}
