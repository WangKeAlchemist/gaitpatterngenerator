/*
 * stepGenerator.h
 *
 *      Author: Abbas
 */


#ifndef STEPGENERATOR_H_
#define STEPGENERATOR_H_

#include "walkStep.h"
#include <vector>


#define PI 3.14159265


#define 	RIGHTFOOT 	-1
#define 	LEFTFOOT 	1

using namespace std;


class stepGenerator {
public:
	static	stepGenerator* getInstance();
	static	stepGenerator* getInstance(walkStep currentStepState);
	static stepGenerator* uniqueInstance;
	stepGenerator();
	stepGenerator(walkStep currentStepState);
	void initializeStep(walkStep currentStepState);
	Vector3f relativePos(Vector3f globalPos,Vector3f Pos);
	Vector3f globalPos(Vector3f relativePos,Vector3f Pos);
	void getNextSteps(float vx,float vy,float vtheta,int nSteps,vector<walkStep>& v,float steptime,float DSP);
	void getNextSteps2(float vx,float vy,float vtheta,int nSteps,vector<walkStep>& v,float steptime,float DSP);

	walkStep currentStepState;
	walkStep TempnStep;
	walkStep* nStep;


	virtual ~stepGenerator();

};

#endif /* STEPGENERATOR_H_ */
