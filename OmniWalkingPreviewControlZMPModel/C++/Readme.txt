It is C++ code for a ZMP-Based biped walking gate pattern generator by using the method proposed in [1]. This method uses preview control method to generate CoM trajectory given desired ZMP trajectories. Preview control is a very powrful method as you can achieve smooth CoM trajectories even if ZMP trajectory is not smooth.

To run the program, first compile the code with command "make". After that an executable binary "walkagent" will be created. Please open the main.cpp file to see the start point. You can set a desired direction for walking, and the program will generate appropriate footsteps, ZMP trajectories and CoM trajectory.

This package contains a foot print generator, ZMP generator and a CoM pattern generator. For more detail about the method please refer to [1].

[1]Kajita, Shuuji, et al. "Biped walking pattern generation by using preview control of zero-moment point." 
   Robotics and Automation, 2003. Proceedings. ICRA'03. IEEE International Conference on. Vol. 2. IEEE, 2003.

[2]Shafii, N., Abdolmaleki, A., Ferreira, R., Lau, N. and Reis, L.P., 2013. Omnidirectional Walking and Active Balance for Soccer Humanoid Robot.
   In Progress in Artificial Intelligence (pp. 283-294). Springer Berlin Heidelberg.
