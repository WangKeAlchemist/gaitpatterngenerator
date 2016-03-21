/*
 * zmpGenerator.cpp
 *
 *  Created on: Sep 23, 2013
 *      Author: hamidreza
 */

#include "zmpGenerator.h"
#include <vector>
#include "Vector3f.h"


zmpGenerator::zmpGenerator() {
	// TODO Auto-generated constructor stub

}

Vector3f zmpGenerator::splineZMP(walkStep step,float t)
{

	float dsp=0.1;
	float stepTime=1;

	float t0=0;
	float t1=(step.DSP);
	float t2=t1+(step.stepTime-2*step.DSP);
	float tf=step.stepTime;
	float zmpx;
	float zmpy;
	Vector3f supportFoot;
	Vector3f nextSupportFoot;
	Vector3f preSupportFoot;

	if(step.SFisleft==1)
	{
		preSupportFoot = step.Rfoot;
		supportFoot=step.Lfoot;
		nextSupportFoot = step.nextRfoot;
	}
	else
	{
		preSupportFoot = step.Lfoot;
		supportFoot=step.Rfoot;
		nextSupportFoot = step.nextLfoot;
	}

	if(t>=t0 && t<t1)
	{
		zmpx=step.torso.x+((supportFoot.x-step.torso.x)/(t1-t0))*t;
		zmpy=step.torso.y+((supportFoot.y-step.torso.y)/(t1-t0))*t;

		return Vector3f(zmpx,zmpy,0);
	}

	if(t>=t1 && t<t2)
	{
		return supportFoot;
	}

	if(t>= t2 && t < tf)
	{
		zmpx=supportFoot.x+((step.nextTorso.x-supportFoot.x)/(tf-t2))*(t-t2);
		zmpy=supportFoot.y+((step.nextTorso.y-supportFoot.y)/(tf-t2))*(t-t2);


	    return Vector3f(zmpx,zmpy,0);
	}

}

zmpGenerator::~zmpGenerator() {
	// TODO Auto-generated destructor stub
}

