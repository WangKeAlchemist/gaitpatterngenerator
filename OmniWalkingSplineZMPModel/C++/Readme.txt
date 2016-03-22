It is C++ code for a "ZMP-Based biped walking gate pattern generator" by using the method proposed in [1]. This method models the desired ZMP trajectory with splines and subsequently the spline model is used to solve the linear inverted pendulum dynamic equation to drive CoM trajectory.  

To run the programm, excute the run.m file. In run.m file You can set a desired direction for walking, and the program will generate appropriate footsteps, ZMP trajectories and CoM trajectory.

To run the program, first compile the code with command "make". After that an executable binary "walkagent" will be created. Please open the main.cpp file to see the start point. You can set a desired direction for walking, and the program will generate appropriate footsteps, ZMP trajectories and CoM trajectory.

This package contains a foot print generator, ZMP generator and a CoM pattern generator. For more detail about the method please refer to [1].

[1]Harada, Kensuke, et al. "An analytical method for real-time gait planning for humanoid robots." International Journal of Humanoid Robotics 3.01 (2006): 1-19.
