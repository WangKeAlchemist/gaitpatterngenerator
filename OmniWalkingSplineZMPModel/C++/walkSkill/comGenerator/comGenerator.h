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

	Vector3f splineCoM(walkStep step,float t);

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
