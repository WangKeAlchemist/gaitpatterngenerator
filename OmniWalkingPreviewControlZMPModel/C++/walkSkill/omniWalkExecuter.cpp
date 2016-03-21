/*
 * omniWalkExecuter.cpp
 *
 *  Created on: Sep 23, 2013
 *      Author: hamidreza
 */

#include "omniWalkExecuter.h"
#include "zmpGenerator.h"
#include <vector>
#include "comGenerator.h"
#include "stepGenerator.h"



omniWalkExecuter* omniWalkExecuter::uniqueInstance;


omniWalkExecuter* omniWalkExecuter::getInstance(){

	if( !uniqueInstance ){
	uniqueInstance = new omniWalkExecuter();
    }

    return uniqueInstance;

}

omniWalkExecuter* omniWalkExecuter::getInstance(float stepTime,float DSP,int supportFoot,float dt,float legExtention,float height){

	if( !uniqueInstance ){
	uniqueInstance = new omniWalkExecuter(stepTime,DSP,supportFoot,dt,legExtention,height);
    }
	else
		uniqueInstance->setWalkParam(stepTime,DSP,supportFoot,dt,legExtention,height);

    return uniqueInstance;

}



omniWalkExecuter::omniWalkExecuter() {
	// TODO Auto-generated constructor stub

	stepGen=stepGenerator::getInstance();

	currentSteps=walkStep();
	currentSteps.setInitialPos(Vector3f(0,0,0),Vector3f(0,0.055,0),Vector3f(0,-0.055,0));
	currentSteps.setFinalPos(Vector3f(0,0,0),Vector3f(0,0.055,0),Vector3f(0,-0.055,0));
	currentSteps.setSupport(1);
	stepGen->initializeStep(currentSteps);

	this->stepTime=0;
	this->DSP=0;
	this->supportFoot=1;
	this->dt=0;
	this->legExtention=0;
	this->height=0;

}

omniWalkExecuter::omniWalkExecuter(float stepTime,float DSP,int supportFoot,float dt,float legExtention,float height){


	stepGen=stepGenerator::getInstance();
	currentSteps=walkStep();
	currentSteps.setInitialPos(Vector3f(0,0,0),Vector3f(0,0.055,0),Vector3f(0,-0.055,0));
	currentSteps.setFinalPos(Vector3f(0,0,0),Vector3f(0,0.055,0),Vector3f(0,-0.055,0));
	this->stepTime=stepTime;
	this->DSP=DSP;
	this->supportFoot=supportFoot;
	this->dt=dt;
	this->legExtention=legExtention;
	this->height=height;
}

void omniWalkExecuter::setWalkParam(float stepTime,float DSP,int supportFoot,float dt,float legExtention,float height)
{
		stepGen=stepGenerator::getInstance();
		this->stepTime=stepTime;
		this->DSP=DSP;
		this->supportFoot=supportFoot;
		this->dt=dt;
		this->legExtention=legExtention;
		this->height=height;
}
void omniWalkExecuter::setCurrentSteps(Vector3f Torso,Vector3f LFoot,Vector3f RFoot)
{
	currentSteps.setInitialPos(Vector3f(0,0,0),Vector3f(0,0.055,0),Vector3f(0,0.-055,0));
	currentSteps.setFinalPos(Vector3f(0,0,0),Vector3f(0,0.055,0),Vector3f(0,0.-055,0));

}

void omniWalkExecuter::walk(float vx,float vy,float vtheta)
{
	nSteps=10;
	steps.clear();
	stepGen->initializeStep(currentSteps);
	stepTime=1;
	DSP=0.2;
	float dt=0.002;

	stepGen->getNextSteps(vx,vy,vtheta,nSteps,steps,stepTime,DSP);

	zmpGenerator zmpgen=zmpGenerator();
	comGenerator comgen=comGenerator(dt);

	vector<double> CoMx;
    vector<double> CoMy;

	Vector3f ZMP;
	vector<double> zmpx;
	vector <double> zmpy;

	vector <double> time;


	//float lastStepTime=0;

	float k=0;

	//Vector3f currentCOM;

	Vector3f splineCoM;


			//	currentCOM=steps[0].torso;
	for(int i=1;i<4;++i)
		for(float t=0;t<steps[i].stepTime;t=t+dt)

			{
				ZMP=zmpgen.splineZMP(steps[i],t);

				zmpx.push_back(ZMP.x);
				zmpy.push_back(ZMP.y);

				k = k+dt;
				time.push_back(k);

			}

				//Generate CoM Trajectory for one step
				comgen.computeCoM(steps[0].stepTime,dt,zmpx,zmpy,time,CoMx,CoMy);
			}

//}



omniWalkExecuter::~omniWalkExecuter() {
	// TODO Auto-generated destructor stub
}

