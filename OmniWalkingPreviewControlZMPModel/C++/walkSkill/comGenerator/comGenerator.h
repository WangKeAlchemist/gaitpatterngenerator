/*
 * comGenerator.h

 *
 *  Created on: Sep 23, 2013
 *      Author: hamidreza
 */

#include <vector>
#include <Vector3f.h>
#include <walkStep.h>
#include <math.h>
#include "./eigen3/Eigen/Dense"
#include "./eigen3/Eigen/Core"
#include <fstream>

#ifndef COMGENERATOR_H_
#define COMGENERATOR_H_

using namespace std;

class comGenerator {
public:
	comGenerator(float dt);
	virtual ~comGenerator();
	
	bool load( const char* qtable_definition );
	void computeCoM(float stepTime, float dt, std::vector<double> zmpx,std::vector<double> zmpy,std::vector<double> time,vector<double> & CoMX,vector<double> & CoMY);
	void creatMatrices();

	double Tc;
	

	std::vector<double> comX;
	std::vector<double> comY;
	float zc;
 	float g ;
 	int NumOfStep;
 	float delt ;
 	
 	float initial;
 	float endd;
 	float theta;
 	
 	std::vector <double> totalTimeSequence;
 	std::vector <double> ZMPx;
 	std::vector <double> ZMPy;
	
	Eigen:: Matrix3d A;

	Eigen::Vector3d B;
	
	Eigen::RowVector3d C;

	Eigen::Matrix4d A1;
	Eigen::RowVector4d C1;

	double Qe;
	Eigen::Vector4d B1;

	Eigen::Matrix3d Qx;
	Eigen::Matrix4d Q;
	double R;
	Eigen::Matrix4d P;
	Eigen::RowVector4d G;
	double Ke;
	Eigen::RowVector3d Kx;
	Eigen::Vector3d Initialxkf;
	Eigen::Vector3d Initialxkl;
	Eigen::RowVectorXd N;
	Eigen::Matrix4d Ac;
	Eigen::RowVectorXd Gp;
	Eigen::Matrix4Xd X1;
	Eigen::Matrix3Xd xkf;
	Eigen::Matrix3Xd xkl;
	Eigen::RowVectorXd ukf;
	Eigen::RowVectorXd ukl;
	Eigen::RowVectorXd ykf;
	Eigen::RowVectorXd ykl;
	Eigen::RowVectorXd CoMf;
	Eigen::RowVectorXd CoMl;
	double ef;
	double el;
	
	EIGEN_MAKE_ALIGNED_OPERATOR_NEW
};

#endif /* COMGENERATOR_H_ */
