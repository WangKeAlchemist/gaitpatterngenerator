/*
 * comGenerator.cpp
 *
 *      Author: Abbas
 */

#include "comGenerator.h"
#include <vector>

using namespace std;

comGenerator::comGenerator() {
	// TODO Auto-generated constructor stub
wn=sqrt(9.81/0.22);
Tc=sqrt(9.81/0.22);
}

Vector3f comGenerator::splineCoM(walkStep step,float t)
{
	float t0=0;
	float t1=step.stepTime*(step.DSP/2);
	float t2=step.stepTime-t1;
	float tf=step.stepTime;

	float comx;
	float comy;

	double cx1;
	double cx2;
	double cy1;
	double cy2;

	Vector3f supportFoot;

		if(step.SFisleft==1)
		{
			supportFoot=step.Lfoot;
		}
		else
			supportFoot=step.Rfoot;


		double supportX=supportFoot.x;
		double supportY=supportFoot.y;

		double torso0X=step.torso.x;
		double torso0Y=step.torso.y;

		double torso1X=step.nextTorso.x;
		double torso1Y=step.nextTorso.y;



		if(t>=t0 && t<t1)
		{

			cx1=0;
			cy1=0;

			cx2=(sinh(Tc*(t1 - tf))*(supportX - torso0X))/(Tc*t1*sinh(Tc*tf)) - (sinh(Tc*(t2 - tf))*(supportX - torso1X))/(Tc*sinh(Tc*tf)*(t2 - tf));
			cy2=(sinh(Tc*(t1 - tf))*(supportY - torso0Y))/(Tc*t1*sinh(Tc*tf)) - (sinh(Tc*(t2 - tf))*(supportY - torso1Y))/(Tc*sinh(Tc*tf)*(t2 - tf));

			 comx=torso0X+((supportX-torso0X)/(t1-t0))*(t-t0)+cx1*cosh(Tc*t)+cx2*sinh(Tc*t);
			 comy=torso0Y+((supportY-torso0Y)/(t1-t0))*(t-t0)+cy1*cosh(Tc*t)+cy2*sinh(Tc*t);


			 return Vector3f(comx,comy,0);

		}


		if(t>=t1 && t<t2)
		{
			cx1=((cosh(Tc*(2*t1 - tf)) - cosh(Tc*tf))*(supportX - torso0X))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
			cx2=((sinh(Tc*(2*t1 - tf)) + sinh(Tc*tf))*(supportX - torso0X))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(t1 + t2 - tf)) - sinh(Tc*(t1 - t2 + tf)))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf));

			cy1=((cosh(Tc*(2*t1 - tf)) - cosh(Tc*tf))*(supportY - torso0Y))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
			cy2=((sinh(Tc*(2*t1 - tf)) + sinh(Tc*tf))*(supportY - torso0Y))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(t1 + t2 - tf)) - sinh(Tc*(t1 - t2 + tf)))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf));

			comx=supportX+cx1*cosh(Tc*(t-t1))+cx2*sinh(Tc*(t-t1));
			comy=supportY+cy1*cosh(Tc*(t-t1))+cy2*sinh(Tc*(t-t1));

			return Vector3f(comx,comy,0);


		}

		if(t>= t2 && t < tf)
		{

			cx1=((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportX - torso0X))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(2*t2 - tf)) - cosh(Tc*tf))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
			cx2=((supportX - torso0X)*(sinh(Tc*(t1 + t2 - tf)) + sinh(Tc*(t1 - t2 + tf))))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(2*t2 - tf)) + sinh(Tc*tf))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf));

			cy1=((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportY - torso0Y))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(2*t2 - tf)) - cosh(Tc*tf))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
			cy2=((supportY - torso0Y)*(sinh(Tc*(t1 + t2 - tf)) + sinh(Tc*(t1 - t2 + tf))))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(2*t2 - tf)) + sinh(Tc*tf))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf));


		    comx=supportX+((torso1X-supportX)/(tf-t2))*(t-t2)+cx1*cosh(Tc*(t-t2))+cx2*sinh(Tc*(t-t2));
		    comy=supportY+((torso1Y-supportY)/(tf-t2))*(t-t2)+cy1*cosh(Tc*(t-t2))+cy2*sinh(Tc*(t-t2));

			return Vector3f(comx,comy,0);


		}

		return Vector3f(comx,comy,0);
}





comGenerator::~comGenerator() {
	// TODO Auto-generated destructor stub
}

