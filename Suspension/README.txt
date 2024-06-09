Electric Racing
Suspension Calculator
README


Author: Alex Savic
Date:   10/22/23


Files:
- Suspension_Forces.m
- Suspension_Force_Calculator.m
- Table_Data.m
- Save_Data.m
- Plot_Suspension_Members.m


Instructions to Use:
- Open up the folder containing the above files in MATLAB.
- In the Suspension_Forces.m script, change the mounting locations of each suspension member of each wheel to the desired position. 
- Update the car parameters as necessary.
- Run the script


How To Change Desired Forces:
- Enter the Suspension_Force_Calculator.m function and change the G forces array to match the desired longitudinal and lateral acceleration. 


Updates To Be Made:
- Applied Fx and Fy calculations for each wheel are based on a major assumption they only depend on the Fz of each wheel. This can be fleshed out more to account for different forces/parameters of the car.
- Calculate forces on the upright
- Calculate forces on the rockers
- Eliminate the nested for loop in the Suspension Force Calculator to utilize matrix math more and make the program more efficient
- Make Save_Data.m function cleaner
- Make Table_Data.m function more abstract


Notes:
- All units are in SI (N, m, kg, etc.)
- All mounting locations should be relative to the origin of the car (ie: each wheel should not have its own coordinate system)
- (+) Position and acceleration is forward, driver left, and up. Other directions are (-)
- (+) Weight transfer is when the weight of the car is shifted onto that specific wheel. If weight is shifted away then weight transfer is (-)


Abbreviations:
- LCAF/LCAR: Lower Control Arm Front/Rear
- UCAF/UCAF: Upper Control Arm Front/Rear


