/*
 * walkStep.cpp
 *
 *  Created on: Sep 23, 2013
 *      Author: hamidreza
 */

#include "walkStep.h"

walkStep::walkStep() {
	// TODO Auto-generated constructor stub

}

walkStep::walkStep(Vector3f torso,Vector3f LFoot,Vector3f RFoot,Vector3f nextTorso,Vector3f nextLFoot,Vector3f nextRFoot,int isLeft,
		  float stepTime,float DSP)

{
	this->torso=torso;
	this->Lfoot=LFoot;
	this->Rfoot=RFoot;

	this->nextTorso=nextTorso;
	this->Lfoot=nextLFoot;
	this->Rfoot=nextRFoot;

	this->SFisleft=isLeft;

	this->stepTime=stepTime;
	this->DSP=DSP;
}



void walkStep::set(Vector3f torso,Vector3f LFoot,Vector3f RFoot,Vector3f nextTorso,Vector3f nextLFoot,Vector3f nextRFoot,int isLeft,
		  float stepTime,float DSP){

			this->torso=torso;
			this->Lfoot=LFoot;
			this->Rfoot=RFoot;

			this->nextTorso=nextTorso;
			this->Lfoot=nextLFoot;
			this->Rfoot=nextRFoot;

			this->SFisleft=isLeft;

			this->stepTime=stepTime;
			this->DSP=DSP;}

walkStep* walkStep::get(){return this;}

void walkStep::setInitialPos(Vector3f torso,Vector3f LFoot,Vector3f RFoot){

	this->torso=torso;
		this->Lfoot=LFoot;
		this->Rfoot=RFoot;
}

void walkStep::setFinalPos(Vector3f nextTorso,Vector3f nextLFoot,Vector3f nextRFoot){

	this->nextTorso=nextTorso;
		this->nextLfoot=nextLFoot;
		this->nextRfoot=nextRFoot;
}

void walkStep::setSupport(int isLeft){

	this->SFisleft=isLeft;
}



float walkStep::getDSP()
{
	return this->DSP;
}

Vector3f walkStep::getTorso()
{
	return this->torso;
}



float walkStep::getSTepTime()
{
	return this->stepTime;
}




void walkStep::setTorso(Vector3f torso)
{
	this->torso=torso;

}


void walkStep::setStepTime(float stepTime)
{
	this->stepTime=stepTime;
}


void walkStep::setDSP(float DSP)
{
	this->DSP=DSP;
}



walkStep::~walkStep() {
	// TODO Auto-generated destructor stub
}

