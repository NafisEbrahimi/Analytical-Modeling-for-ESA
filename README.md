Analytical Modeling and Optimization of Electronic Soft Actuator
===
## Introduction
The growing interest in soft robotics arises from their unique ability to perform tasks beyond the capabilities of rigid robots, with soft actuators playing a central role in this innovation. Among these, Electromagnetic Soft Actuators (ESAs) stand out for their fast response, simple control mechanisms, and compact design. Analytical and experimental studies indicate that smaller ESAs enhance the Force per unit Cross-Section Area (F/CSA) without compromising force efficiency. This work uses the Magnetic Vector Potential (MVP) to calculate the magnetic field of an ESA, which is then used to derive the actuator's generated force. A Mixed Integer Non-linear Programming (MINLP) optimization framework is introduced to maximize the ESA's F/CSA. Unlike prior methods that independently optimized parameters such as ESA length and permanent magnet diameter, this study jointly optimizes these parameters to achieve a more efficient and effective design. To validate the proposed framework, finite element-based COMSOL is used to simulate the magnetic field and generated force, ensuring consistency between the MVP-based calculations and the physical model. Additionally, simulation results demonstrate the effectiveness of the MINLP optimization in identifying the optimal design parameters for maximizing the F/CSA of the ESA. 

## Usage
In the "Magnetic_Field_Force_(Magnetic_Vector_Potential)" folder, Matlab code that calcualtes the force and magnetic field using Magnetic Vector Potential(MVP) methods are provided.
To run the code, first add "Utility_Functions" into your Matlab Path, see "include_path.png" for detailed instructions.
After that, run "plot_xx_yy.m" to observe field and force calculations discussed in the paper.

In the "Mixed_Integer_Non_Linear_Programming_MATLAB" folder, there are two m-files: one for the main program and another dedicated to auxiliary calculations. To obtain the optimization results, please run the main file. If you have any questions, feel free to reach out to us for further clarification.

## Citation
Please cite this paper in your publications if it helps your research:

LaTeX:

@inproceedings{zolfaghari2025integrated,
  title={Integrated Analytical Modeling and Numerical Simulation Framework for Design Optimization of Electromagnetic Soft Actuators},
  author={Zolfaghari, Hussein and Ebrahimi, Nafiseh and Ji, Yuan and Pitkow, Xaq and Davoodi, Mohammadreza},
  booktitle={Actuators},
  volume={14},
  number={3},
  pages={128},
  year={2025},
  organization={MDPI}
}


APA:  

Zolfaghari, H., Ebrahimi, N., Ji, Y., Pitkow, X., & Davoodi, M. (2025, March). Integrated Analytical Modeling and Numerical Simulation Framework for Design Optimization of Electromagnetic Soft Actuators. In Actuators (Vol. 14, No. 3, p. 128). MDPI.
