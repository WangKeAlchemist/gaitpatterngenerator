/*
 * comGenerator.cpp
 *
 *  Created on: Sep 23, 2013
 *      Author: hamidreza
 */

#include "comGenerator.h"
#include <vector>

using namespace std;

comGenerator::comGenerator(float dt) {
	// TODO Auto-generated constructor stub
//wn=sqrt(9.81/0.22);
delt = dt;

}

bool comGenerator::load( const char* qtable_definition )
{
    std::ifstream in( qtable_definition );
    if (!in) {
		
    	std::cout<<"Can not load file : " << qtable_definition << " for reading!";
        return false;
    }

    std::string line;
    do {
        getline(in, line);
    } while ( line[0] == 'P');

    long double digit;
	char c;
	
	for(int i=0;i<4;++i)
	{
	
		std::stringstream ss(line);
		for(int k=0; k<4;k++)
		{
			ss>>digit;
			P(i,k)=digit;
			if(k<=2)
				ss>>c;
		}

		getline(in, line);
		if(line[0] == 'G')
			break;

	}
	
	getline(in, line);
	std::stringstream ss(line);
	for(int k=0; k<4;k++)
	{
		ss>>digit;
		G(k)=digit;
		if(k<=2)
		ss>>c;
	}

	 in.close();

	 return true;

}

void comGenerator::creatMatrices()
{
		load("matrices.txt");
		Initialxkf <<0,0,0;
		Initialxkl <<0,0,0;
		A << 1,delt,(delt*delt)/2,0,1,delt,0,0,1;
		int stepSize=1 ; //(SSP+2*DSP+delt*0.0001)/delt;
		std::cout<<"A:"<<A<<"\n";

		B << (delt*delt*delt)/6,(delt*delt)/2,delt;
		std::cout<<"B:"<<B<<"\n";
		
		C << 1,0,-1*zc/g;
		
		A1.row(0) << 1,C*A;
		A1.block(1,0,1,3).setZero();
		A1.bottomRightCorner(3,3)=A;
			
		B1 <<C*B,B;
		C1 << 1,0,0,0;
		
		Qe=1;
		Qx.setZero();
		Q <<1,0,0,0,Eigen::MatrixXd::Zero(3,4);
			
		R=1e-10;			
		Ke=G(0);
		Kx=G.tail<3>();
		
					
		int size=(1/delt)+1;
		N.resize(size);
		N=Eigen::RowVectorXd::LinSpaced(size, 0, 1);
		
		Ac=A1 - (B1*G);
		std::cout<<"\n Ac:"<<Ac<<"\n";
		Gp.resize(size);
		Gp=Eigen::RowVectorXd::Zero(size);
		
		X1=Eigen::Matrix4Xd::Zero(4,size);
					
		Gp(0)=-1*Ke;
		
			
		X1.col(0)=-1*(Ac.transpose())*P*(Eigen::Vector4d (1,0,0,0));
		std::cout<<" X1:"<<X1<<"\n";
	
		Eigen:: RowVectorXd temp1(1);
		temp1(0)=R+B1.transpose()*P*B1;
			
		for(int i=1; i<size;i++)
		{
			Gp(i)=temp1.inverse()*B1.transpose()*X1.col(i-1);
			X1.col(i)=Ac.transpose()*X1.col(i-1);
		}
		std::cout<<"\n Gp:"<<Gp<<"\n";
		std::cout<<"\n X1:"<<X1<<"\n";

		ef=0;
		el=0;
}

void comGenerator::computeCoM(float stepTime, float dt, std::vector<double> zmpx,std::vector<double> zmpy,std::vector<double> time,vector<double> & CoMX,vector<double> & CoMY)
{

	CoMX.clear();
	CoMY.clear();

	ZMPx = zmpx;
	ZMPy = zmpy;

	totalTimeSequence = time;

	Eigen::Map <Eigen::RowVectorXd> x (totalTimeSequence.data(),totalTimeSequence.size());
	Eigen::Map <Eigen::RowVectorXd> ydf (ZMPx.data(),ZMPx.size());
	Eigen::Map <Eigen::RowVectorXd> ydl (ZMPy.data(),ZMPy.size());

	int stepSize = (stepTime+delt*0.0001)/delt;
	double prevf;
	double prevl;
	
	xkf.setZero(3,stepSize+2);
	xkl.setZero(3,stepSize+2);
	ukf.setZero(stepSize+2);
	ukl.setZero(stepSize+2);
	ykf.setZero(stepSize+1);
	ykl.setZero(stepSize+1);
	CoMf.setZero(stepSize+1);
	CoMl.setZero(stepSize+1);
	
	xkf.col(0)=Initialxkf;
	xkl.col(0)=Initialxkl;
	xkf(0,0)=0;
	xkl(0,0)=0;

	for(int k=1;k<=stepSize+1;++k)
		{
			if((k+N.cols())<x.cols())
			{
				CoMf(k-1)=xkf(0,k-1);
				CoMl(k-1) = xkl(0,k-1);
				CoMX.push_back(CoMf(k-1));
				CoMY.push_back(CoMl(k-1));


				ykf(k-1) = C*xkf.col(k-1);
				ykl(k-1) = C*xkl.col(k-1);

				ef = ef + ykf(k-1) - ydf(k-1);
				el = el + ykl(k-1) - ydl(k-1);

				prevf = 0;
				prevl = 0;
				for(int i=1 ; i<=N.cols();++i)
				{
					if(k+N.cols()<x.cols())
					{
						prevf = prevf + 1*Gp(i-1)*ydf(k+i-1);
						prevl = prevl + 1*Gp(i-1)*ydl(k+i-1);
					}

				}
			}
			else
			{
				if(k>1)
				{
					ykf(k-1) = ykf(k-2);
					ykl(k-1) = ykl(k-2);
					CoMf(k-1) = xkf(0,k-2);
					CoMl(k-1) = xkl(0,k-2);
					CoMX.push_back(CoMf(k-1));
					CoMY.push_back(CoMl(k-1));
				}
			}


			

			ukf(k-1) = -1*Ke*ef - Kx*xkf.col(k-1)-prevf;
			ukl(k-1) = -1*Ke*el - Kx*xkl.col(k-1)-prevl;

			xkf.col(k)=A*xkf.col(k-1)+B*ukf(k-1);
			xkl.col(k)=A*xkl.col(k-1)+B*ukl(k-1);

		}

	Initialxkf=xkf.col(stepSize);
	Initialxkl=xkl.col(stepSize);

}


comGenerator::~comGenerator() {
	// TODO Auto-generated destructor stub
}

