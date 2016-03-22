/*
 * stepGenerator.cpp
 *
 *      Author: Abbas
 */

#include "stepGenerator.h"
#include <vector>

stepGenerator* stepGenerator::uniqueInstance;


stepGenerator* stepGenerator::getInstance(){

	if( !uniqueInstance ){
	uniqueInstance = new stepGenerator();
    }

    return uniqueInstance;

}


stepGenerator* stepGenerator::getInstance(walkStep currentStepState){

	if( !uniqueInstance ){
	uniqueInstance = new stepGenerator(currentStepState);
    }

	else
		uniqueInstance->initializeStep(currentStepState);

    return uniqueInstance;

}

stepGenerator::stepGenerator() {
	// TODO Auto-generated constructor stub
	nStep=&TempnStep;
}

stepGenerator::stepGenerator(walkStep currentStepState) {
	// TODO Auto-generated constructor stub
	this->currentStepState=currentStepState;
	nStep=&TempnStep;
}

void stepGenerator::initializeStep(walkStep currentStepState)
{
	this->currentStepState=currentStepState;
}


void  stepGenerator::getNextSteps2(float vx,float vy,float vtheta,int nSteps,vector<walkStep>& v,float steptime,float DSP)
{

	walkStep NextStep=walkStep();

	for(int i=0;i<nSteps;++i)
	{

	NextStep=currentStepState;

	float stepx=vx;
	float stepy=vy;
	float steptheta=vtheta;
	Vector3f Scurrent;

	if(currentStepState.SFisleft==1)
	{
		Scurrent=currentStepState.Lfoot;
	}
	else
		Scurrent=currentStepState.Rfoot;

	Vector3f  MaxSwingRsupport = Vector3f( 0.2, max(-1*currentStepState.SFisleft*0.2,-1*currentStepState.SFisleft*0.11),0);
	Vector3f  MinSwingRsupport = Vector3f(-0.2, min(-1*currentStepState.SFisleft*0.2,-1*currentStepState.SFisleft*0.11),0);

	Vector3f MaxTorsoRsupport  = Vector3f(MaxSwingRsupport.x/2,MaxSwingRsupport.y/2,MaxSwingRsupport.z/2);
	Vector3f MinTorsoRsupport  = Vector3f(MinSwingRsupport.x/2,MinSwingRsupport.y/2,MinSwingRsupport.z/2);

	Vector3f MaxTorsoGsupport  =  globalPos( MaxTorsoRsupport , Scurrent );
	Vector3f MinTorsoGsupport  =  globalPos( MinTorsoRsupport , Scurrent );

	Vector3f  MaxTstep = relativePos (MaxTorsoGsupport,currentStepState.torso)  ;
	Vector3f  MinTstep = relativePos (MinTorsoGsupport,currentStepState.torso)  ;

	stepx = min( max( MinTstep.x, vx ), MaxTstep.x ) ;
	stepy = min( max( MinTstep.y, vy ), MaxTstep.y ) ;

	std::cout<<stepx<<stepx<<std::endl;
	std::cout<<stepy<<stepy<<std::endl;

	steptheta = vtheta;

	Vector3f torsoNext=globalPos(Vector3f(stepx,stepy,steptheta),currentStepState.torso);
	Vector3f lastPredictedPoint = globalPos(Vector3f(0,-1*currentStepState.SFisleft*0.055,0),Scurrent);
	Vector3f nTorsoRLPredPoint = relativePos(torsoNext,lastPredictedPoint);
	Vector3f nextPredictedPoint = globalPos(nTorsoRLPredPoint,torsoNext);
	Vector3f RelPosition=Vector3f(0,currentStepState.SFisleft*-0.055,0);
	Vector3f SNext=globalPos(RelPosition,nextPredictedPoint);


	if(currentStepState.SFisleft == LEFTFOOT)
	{

	NextStep.setFinalPos( torsoNext, currentStepState.Lfoot, SNext);
	NextStep.setStepTime(steptime);
	NextStep.setDSP(DSP);
	v.push_back(NextStep);
	currentStepState.setInitialPos(torsoNext,currentStepState.Lfoot,SNext);

	}
	else
	{
		NextStep.setFinalPos(torsoNext,SNext,currentStepState.Rfoot);
		NextStep.setStepTime(steptime);
		NextStep.setDSP(DSP);
		v.push_back(NextStep);

		currentStepState.setInitialPos(torsoNext,SNext,currentStepState.Rfoot);
	}

	currentStepState.setSupport(currentStepState.SFisleft*-1);

	}

}

void  stepGenerator::getNextSteps(float vx,float vy,float vtheta,int nSteps,vector<walkStep>& v,float steptime,float DSP)
{

	//TempnStep=currentStepState;

	walkStep NextStep=walkStep();

	for(int i=0;i<nSteps;++i)
	{

	NextStep=currentStepState;

	float stepx=vx;
	float stepy=vy;
	float steptheta=vtheta;
	Vector3f Scurrent;

	if(currentStepState.SFisleft==1)
	{
		Scurrent=currentStepState.Lfoot;
	}
	else
		Scurrent=currentStepState.Rfoot;

	Vector3f  MaxSwingRsupport = Vector3f( 0.2, max(-1*currentStepState.SFisleft*0.2,-1*currentStepState.SFisleft*0.11),0);
	Vector3f  MinSwingRsupport = Vector3f(-0.2, min(-1*currentStepState.SFisleft*0.2,-1*currentStepState.SFisleft*0.11),0);

	Vector3f MaxTorsoRsupport  = Vector3f(MaxSwingRsupport.x/2,MaxSwingRsupport.y/2,MaxSwingRsupport.z/2);
	Vector3f MinTorsoRsupport  = Vector3f(MinSwingRsupport.x/2,MinSwingRsupport.y/2,MinSwingRsupport.z/2);

	Vector3f MaxTorsoGsupport  =  globalPos( MaxTorsoRsupport , Scurrent );
	Vector3f MinTorsoGsupport  =  globalPos( MinTorsoRsupport , Scurrent );

	Vector3f  MaxTstep = relativePos (MaxTorsoGsupport,currentStepState.torso)  ;
	Vector3f  MinTstep = relativePos (MinTorsoGsupport,currentStepState.torso)  ;

	stepx = min( max( MinTstep.x, vx ), MaxTstep.x ) ;
	stepy = min( max( MinTstep.y, vy ), MaxTstep.y ) ;

	steptheta=vtheta;

	Vector3f torsoNext=globalPos(Vector3f(stepx,stepy,steptheta),currentStepState.torso);

	Vector3f predictedCoM=globalPos(Vector3f(1.5*stepx,1.5*stepy,2*steptheta),currentStepState.torso);
	Vector3f RelPosition=Vector3f(0,currentStepState.SFisleft*-0.055,0);

	Vector3f SNext=globalPos(RelPosition,predictedCoM);
	if(currentStepState.SFisleft==LEFTFOOT)
	{
	NextStep.setFinalPos(torsoNext,currentStepState.Lfoot,SNext);
	NextStep.setStepTime(steptime);
	NextStep.setDSP(DSP);
	v.push_back(NextStep);
	currentStepState.setInitialPos(torsoNext,currentStepState.Lfoot,SNext);
	}

	else
	{
		NextStep.setFinalPos(torsoNext,SNext,currentStepState.Rfoot);
		NextStep.setStepTime(steptime);
		NextStep.setDSP(DSP);
		v.push_back(NextStep);

		currentStepState.setInitialPos(torsoNext,SNext,currentStepState.Rfoot);

	}


	currentStepState.setSupport(currentStepState.SFisleft*-1);
	}


}



Vector3f stepGenerator::globalPos(Vector3f relativePos,Vector3f Pos)
{
	double ca = Cos(Pos.z);
	double sa = Sin(Pos.z);
    Vector3f globalPos;
    globalPos=Pos+Vector3f(ca*relativePos.x - sa*relativePos.y ,sa*relativePos.x + ca*relativePos.y, relativePos.z);
    return globalPos;
}



Vector3f stepGenerator::relativePos(Vector3f globalPos,Vector3f Pos)
{
	double ca = Cos(Pos.z);
		double sa = Sin(Pos.z);
		Vector3f dp;
	dp = globalPos - Pos;
	Vector3f relativePos;
	relativePos=Vector3f(ca*dp.x + sa*dp.y ,-1*sa*dp.x + ca*dp.y, normalizeAngle(dp.z)); //TODO: dp.z must get reduced to [-PI PI]
	return relativePos;

}




stepGenerator::~stepGenerator() {
	// TODO Auto-generated destructor stub
}

