/*
 * comGenerator.cpp
 *
 *  Created on: Sep 23, 2013
 *      Author: hamidreza
 */

#include "comGenerator.h"
#include <vector>

using namespace std;

comGenerator::comGenerator() {
	// TODO Auto-generated constructor stub
wn=sqrt(9.81/0.22);
Tc=sqrt(9.81/0.22);
}

void comGenerator:: kagamiAlg(Vector3f torso,Vector3f nextTorso,std::vector<double> zmpx,std::vector<double> zmpy,int length,
			          double dt,std::vector<double>  z,std::vector<double>  ddz,vector<double> & CoMX,vector<double> & CoMY)
{
	a.clear();
	b.clear();
	c.clear();
	d.clear();
	x.clear();
	xy.clear();
	dy.clear();

	N=length;
	x.resize(N);
	xy.resize(N);

	double aCoff;
	double bCoff;
	double cCoff;
	double dCoff;

	for(int i=1;i<length;++i)
	{

		a.push_back((-1*z[i])/((dt*dt)*(-1*ddz[i]+9.81)));
	}


	for(int i=0;i<length-1;++i)
		{
			aCoff=(-1*z[i])/(pow(dt,2)*(-1*ddz[i]+9.81));
			c.push_back(aCoff);
		}

	for(int i=0;i<length;++i)
			{
				aCoff=(-1*z[i])/(pow(dt,2)*(-1*ddz[i]+9.81));
				bCoff=(1-2*aCoff);
				b.push_back(bCoff);
			}

	d=zmpx;
	dy=zmpy;

	solve_tridiagonal_in_place_destructive(torso.x,nextTorso.x,torso.y,nextTorso.y);
	CoMX=x;
	CoMY=xy;

}


void comGenerator::solve_tridiagonal_in_place_destructive(double com0,double com1,double com0y,double com1y) {
    /* unsigned integer of same size as pointer */
    size_t in;

    /*
     solves Ax = v where A is a tridiagonal matrix consisting of vectors a, b, c
     note that contents of input vector c will be modified, making this a one-time-use function
     x[] - initially contains the input vector v, and returns the solution x. indexed from [0, ..., N - 1]
     N — number of equations
     a[] - subdiagonal (means it is the diagonal below the main diagonal) -- indexed from [1, ..., N - 1]
     b[] - the main diagonal, indexed from [0, ..., N - 1]
     c[] - superdiagonal (means it is the diagonal above the main diagonal) -- indexed from [0, ..., N - 2]
     */
    int n=N;
    c[0]=0;
    d[0]=com0;
    dy[0]=com0y;

    for (int i = 1; i < n-1; i++) {
            double temp = b[i] - a[i-1] * c[i - 1];
            c[i] = c[i] /temp;
            d[i] = (d[i] - a[i-1] * d[i - 1]) / temp;
            dy[i] = (dy[i] - a[i-1] * dy[i - 1]) / temp;
        }

    d[n-1] = (d[n-1] - a[n-2] * d[n-2])/( b[n-1] - a[n-2] * c[n-2]);
    dy[n-1] = (dy[n-1] - a[n-2] * dy[n-2])/( b[n-1] - a[n-2] * c[n-2]);

    x[n-1]=com1;
    xy[n-1]=com1y;
    for (int i = n - 2; i >= 0;i-- )
    {
            x[i] = d[i] - c[i] * x[i + 1];
            xy[i] = dy[i] - c[i] * xy[i + 1];

    }

}


comGenerator::~comGenerator() {
	// TODO Auto-generated destructor stub
}

