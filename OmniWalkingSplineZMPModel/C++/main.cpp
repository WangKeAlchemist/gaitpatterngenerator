#include<iostream>
#include<cmath>
#include <stdio.h>
#include "omniWalkExecuter.h"

using namespace std;

int main(){

omniWalkExecuter *omniWalk=new omniWalkExecuter();

omniWalk->walk(0.2,0.2,0); // walk(Vx , Vy, Vtheta)

return 0;
}
