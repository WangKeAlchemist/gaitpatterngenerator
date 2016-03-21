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

#ifndef COMGENERATOR_H_
#define COMGENERATOR_H_

using namespace std;

class comGenerator {
public:
	comGenerator();
	virtual ~comGenerator();
	void solve_tridiagonal_in_place_destructive(double com0,double com1,double com0y,double com1y);
	//function [comx comy]= satoshiAlg(T0x,T0y,T1x,T1y,ZMPx,ZMPy,n,delta,zchange,dzchange)

	void kagamiAlg(Vector3f torso,Vector3f nextTorso,std::vector<double> zmpx,std::vector<double> zmpy,int length,
	          double dt,std::vector<double>  z,std::vector<double>  ddz,vector<double> & CoMX,vector<double> & CoMY);

	double ux;
	double uy;
	double wn;
	double Tc;



	std::vector<double> a;
	std::vector<double> b;
	std::vector<double> c;
	std::vector<double> d;
	std::vector<double> x;
	std::vector<double> dy;
	std::vector<double> xy;

	std::vector<double> comX;
	std::vector<double> comY;

	int N;



};

#endif /* COMGENERATOR_H_ */
