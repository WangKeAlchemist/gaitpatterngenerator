/*
 * zmpGenerator.h
 *
 *      Author: Abbas
 */
#include <vector>
#include "walkStep.h"
#include <Vector3f.h>

#ifndef ZMPGENERATOR_H_
#define ZMPGENERATOR_H_

class zmpGenerator {
public:
	zmpGenerator();
	Vector3f splineZMP(walkStep step,float t);
	void batchSplineZMP(walkStep step,std::vector<float>& zmpX,std::vector<float>& zmpY);
	virtual ~zmpGenerator();
};

#endif /* ZMPGENERATOR_H_ */
