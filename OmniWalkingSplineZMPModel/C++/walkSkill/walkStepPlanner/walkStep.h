/*
 * walkStep.h
 *
 *      Author: Abbas
 */

#ifndef WALKSTEP_H_
#define WALKSTEP_H_

#include "Vector3f.h"

class walkStep {

public:

	walkStep();

	walkStep(Vector3f torso,Vector3f LFoot,Vector3f RFoot,Vector3f nextTorso,Vector3f nextLFoot,Vector3f nextRFoot,int isLeft,
				  float stepTime,float DSP);




	void set(Vector3f torso,Vector3f LFoot,Vector3f RFoot,Vector3f nextTorso,Vector3f nextLFoot,Vector3f nextRFoot,int isLeft,
			  float stepTime,float DSP);
	walkStep* get();

	void setInitialPos(Vector3f torso,Vector3f LFoot,Vector3f RFoot);

	void setFinalPos(Vector3f nextTorso,Vector3f nextLFoot,Vector3f nextRFoot);

	void setSupport(int isLeft);

	//void setStepTime(float stepTime,float DSP);

	void setTorso(Vector3f torso);

	void setStepTime(float stepTime);
	void setDSP(float DSP);

	Vector3f getTorso();
	float 	 getSTepTime();
	float   getDSP();


	int SFisleft; //support foot
	float stepTime;

	Vector3f torso;
	Vector3f Lfoot;        //Initial pose of left,right and toroso
	Vector3f Rfoot;

	Vector3f nextTorso;
	Vector3f nextLfoot;        //Final pose of left,right and toroso
	Vector3f nextRfoot;
	/////////////////////////////////////////////


	float 	 DSP;

	virtual ~walkStep();
};

#endif /* WALKSTEP_H_ */
