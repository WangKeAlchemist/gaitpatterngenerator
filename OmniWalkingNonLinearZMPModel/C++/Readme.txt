It is a matlab code for a "ZMP-Based biped walking gate pattern generator"  by using the method proposed in [1] and [2]. This method explicity consider the Z trajectory of the CoM and given the desired ZMP trajectory it can solve the  nonlinear dynamic equation of the CoM using resolution methods. Please see [1] for details.

To run the program, first compile the code with command "make". After that an executable binary "walkagent" will be created. Please open the main.cpp file to see the start point. You can set a desired direction for walking, and the program will generate appropriate footsteps, ZMP trajectories and CoM trajectory.

This package contains a foot print generator, ZMP generator and a CoM pattern generator. For more detail about the method please refer to [1] and [2].

[1] Abdolmaleki, Abbas, et al. "Omnidirectional Walking with a Compliant Inverted Pendulum Model." 
    Advances in Artificial Intelligence--IBERAMIA 2014. Springer International Publishing, 2014. 481-493.

[2] Kagami, Satoshi, et al. "A fast dynamically equilibrated walking trajectory generation method of humanoid robot." Autonomous Robots 12.1 (2002): 71-82.
