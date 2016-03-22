This package contains matlab implementations and C++ implementations of 4 different biped center of mass(CoM) pattern generators for a given set of desired foot steps. These methods all are based on inverted pendulum model and ZMP stability criteria. These methods are proposed in [1],[2],[3],[4] and [5].

I have tested all but the method in [1], in simulation and on real robot (NaO) for omnidirectional walking. Please see following videos and paper [2]:

https://www.youtube.com/watch?v=z_0Udxk0VUg and https://www.youtube.com/watch?v=jHTba15b01M .

************* PACKAGE ROAD MAP ************************************
For implementation of [1], see folder "OmniWalkingFourierZMPModel",
For implementation of [2] and [3], see folder "OmniWalkingNonLinearZMPModel",
For implementation of [4], see folder "OmniWalkingPreviewControlZMPModel" and 
For implementation of [5], see folder "OmniWalkingSplineZMPModel".

***** In case please cite the paper [2] *****

[1] Erbatur, Kemalettin, and Okan Kurt. "Natural ZMP trajectories for biped robot reference generation."
    Industrial Electronics, IEEE Transactions on 56.3 (2009): 835-845.

[2] Abdolmaleki, Abbas, et al. "Omnidirectional Walking with a Compliant Inverted Pendulum Model." 
    Advances in Artificial Intelligence--IBERAMIA 2014. Springer International Publishing, 2014. 481-493.
   
[3] Kagami, Satoshi, et al. "A fast dynamically equilibrated walking trajectory generation method of humanoid robot." Autonomous Robots 12.1 (2002): 71-82.

[4] Kajita, Shuuji, et al. "Biped walking pattern generation by using preview control of zero-moment point." 
    Robotics and Automation, 2003. Proceedings. ICRA'03. IEEE International Conference on. Vol. 2. IEEE, 2003.

[5] Harada, Kensuke, et al. "An analytical method for real-time gait planning for humanoid robots." 
    International Journal of Humanoid Robotics 3.01 (2006): 1-19.

