% Electric Racing
% Suspension Forces
% Author: Alex Savic
% Date: 10/22/23

% Purpose: This script calcualtes the forces acting on the suspension links
% of the car using A-arm suspension members.

% Notes: Units are SI unless otherwise noted

clear; close all; clc;
%% Defining Car Variables

output_filename = 'CurrentSuspensionResults.csv';
wheel_order = {'Front Left', 'Front Right', 'Rear Left', 'Rear Right'};

car_params.mass = 294;
car_params.weight_rear = .60;
car_params.wheelbase = 1.854;
car_params.track_width = 1.524;
car_params.COG = 0.3;

%% Mounting locations
% Forward is +x, driver left is +y, up is +z

%Front Left wheel (FL)
LCAF_inboard_FL = [-.2032, 0, 0];
LCAF_outboard_FL = [-.3556, .508, 0];
LCAR_inboard_FL = [-.4772, 0, 0];
LCAR_outboard_FL = [-.3556, .508, 0];

UCAF_inboard_FL = [-.2667, .0953, .254];
UCAF_outboard_FL = [-.3874, .4445, .254];
UCAR_inboard_FL = [-.5334, .0953, .254];
UCAR_outboard_FL = [-.3874, .4445, .254];

Tie_Rod_inboard_FL = [-.4318, 0, .0381];
Tie_Rod_outboard_FL = [-.4572, .5144, .0381];

Pull_Rod_inboard_FL = [-.3683, .2477, .2894];
Pull_Rod_outboard_FL = [-.3683, .3683, 0];

inboards_FL = [LCAF_inboard_FL; LCAR_inboard_FL; UCAF_inboard_FL; UCAR_inboard_FL; Tie_Rod_inboard_FL; Pull_Rod_inboard_FL];
outboards_FL = [LCAF_outboard_FL; LCAR_outboard_FL; UCAF_outboard_FL; UCAR_outboard_FL; Tie_Rod_outboard_FL; Pull_Rod_outboard_FL];

% Applied force on wheel is at center of contact patch
Applied_Force_location_FL = [-.4064, .5461, -.1397];

%Front Right wheel (FR)
LCAF_inboard_FR = [-.1778, -.4064, 0];
LCAF_outboard_FR = [-.2858, -.9144, 0];
LCAR_inboard_FR = [-.4445, -.4064, 0];
LCAR_outboard_FR = [-.2858, -.9144, 0];

UCAF_inboard_FR = [-.2223, -.4509, .235];
UCAF_outboard_FR = [-.2858, -.8144, .235];
UCAR_inboard_FR = [-.4826, -.4509, .2350];
UCAR_outboard_FR = [-.2858, -.8144, .235];

Tie_Rod_inboard_FR = [-.3937, -.381, .0445];
Tie_Rod_outboard_FR = [-.0381, -.889, .0445];

Pull_Rod_inboard_FR = [-.3366 -.5842, .2921];
Pull_Rod_outboard_FR = [-.3493, -.7430, -.0127];

inboards_FR = [LCAF_inboard_FR; LCAR_inboard_FR; UCAF_inboard_FR; UCAR_inboard_FR; Tie_Rod_inboard_FR; Pull_Rod_inboard_FR];
outboards_FR = [LCAF_outboard_FR; LCAR_outboard_FR; UCAF_outboard_FR; UCAR_outboard_FR; Tie_Rod_outboard_FR; Pull_Rod_outboard_FR];

Applied_Force_location_FR = [-.3620, -.9398, -.1651];

%Rear Left wheel (RL)
LCAF_inboard_RL = [-2.1209, 0.0625, 0];
LCAF_outboard_RL = [-2.2225, .4953, .0381];
LCAR_inboard_RL = [-2.375, .08255, 0];
LCAR_outboard_RL = [-2.2225, .4953, .0381];

UCAF_inboard_RL = [-2.159, .06985, .2286];
UCAF_outboard_RL = [-2.1717, 0.46335, .2413];
UCAR_inboard_RL = [-2.3622, .08255, .2286];
UCAR_outboard_RL = [-2.1717, 0.46335, .2413];

Tie_Rod_inboard_RL = [-2.2225, .0953, .1481];
Tie_Rod_outboard_RL = [-2.2225, .4953, .1381];

Pull_Rod_inboard_RL = [-2.1844, .127, .7239];
Pull_Rod_outboard_RL = [-2.1844, .3429, 0.228];

inboards_RL = [LCAF_inboard_RL; LCAR_inboard_RL; UCAF_inboard_RL; UCAR_inboard_RL; Tie_Rod_inboard_RL; Pull_Rod_inboard_RL];
outboards_RL = [LCAF_outboard_RL; LCAR_outboard_RL; UCAF_outboard_RL; UCAR_outboard_RL; Tie_Rod_outboard_RL; Pull_Rod_outboard_RL];

Applied_Force_location_RL = [-2.2352, 0.4953, -.209];

%Rear Right wheel (RR)
LCAF_inboard_RR = [-2.12, -.597, 0];
LCAF_outboard_RR = [-2.2225, -1.016, 0.05715];
LCAR_inboard_RR = [-2.38, -0.5969, 0];
LCAR_outboard_RR = [-2.2225, -1.016, 0.05715];

UCAF_inboard_RR = [-2.18, -.5969, 0.2286];
UCAF_outboard_RR = [-2.18, -.925, .228];
UCAR_inboard_RR = [-2.39, -.5969, .23];
UCAR_outboard_RR = [-2.18, -.925, .228];

Tie_Rod_inboard_RR = [-2.2225, -.6, 0.15715];
Tie_Rod_outboard_RR = [-2.2225, -1.0, 0.15715];

Pull_Rod_inboard_RR = [-2.197, -.673, .7239];
Pull_Rod_outboard_RR = [-2.1971, -.857, 0.228];

inboards_RR = [LCAF_inboard_RR; LCAR_inboard_RR; UCAF_inboard_RR; UCAR_inboard_RR; Tie_Rod_inboard_RR; Pull_Rod_inboard_RR];
outboards_RR = [LCAF_outboard_RR; LCAR_outboard_RR; UCAF_outboard_RR; UCAR_outboard_RR; Tie_Rod_outboard_RR; Pull_Rod_outboard_RR];

Applied_Force_location_RR = [-2.222, -1.04, -.209];

% Assembling mounting location structs
mounting_locations(1).inboards = inboards_FL;
mounting_locations(1).outboards = outboards_FL;
mounting_locations(1).applied_force_location = Applied_Force_location_FL;

mounting_locations(2).inboards = inboards_FR;
mounting_locations(2).outboards = outboards_FR;
mounting_locations(2).applied_force_location = Applied_Force_location_FR;

mounting_locations(3).inboards = inboards_RL;
mounting_locations(3).outboards = outboards_RL;
mounting_locations(3).applied_force_location = Applied_Force_location_RL;

mounting_locations(4).inboards = inboards_RR;
mounting_locations(4).outboards = outboards_RR;
mounting_locations(4).applied_force_location = Applied_Force_location_RR;

inorder_mounting_locations = [LCAF_inboard_FL; LCAF_outboard_FL; LCAR_inboard_FL; LCAR_outboard_FL; UCAF_inboard_FL; UCAF_outboard_FL; UCAR_inboard_FL; UCAR_outboard_FL; Tie_Rod_inboard_FL; Tie_Rod_outboard_FL; Pull_Rod_inboard_FL; Pull_Rod_outboard_FL; Applied_Force_location_FL; ...
                              LCAF_inboard_FR; LCAF_outboard_FR; LCAR_inboard_FR; LCAR_outboard_FR; UCAF_inboard_FR; UCAF_outboard_FR; UCAR_inboard_FR; UCAR_outboard_FR; Tie_Rod_inboard_FR; Tie_Rod_outboard_FR; Pull_Rod_inboard_FR; Pull_Rod_outboard_FR; Applied_Force_location_FR; ... 
                              LCAF_inboard_RL; LCAF_outboard_RL; LCAR_inboard_RL; LCAR_outboard_RL; UCAF_inboard_RL; UCAF_outboard_RL; UCAR_inboard_RL; UCAR_outboard_RL; Tie_Rod_inboard_RL; Tie_Rod_outboard_RL; Pull_Rod_inboard_RL; Pull_Rod_outboard_RL; Applied_Force_location_RL; ...
                              LCAF_inboard_RR; LCAF_outboard_RR; LCAR_inboard_RR; LCAR_outboard_RR; UCAF_inboard_RR; UCAF_outboard_RR; UCAR_inboard_RR; UCAR_outboard_RR; Tie_Rod_inboard_RR; Tie_Rod_outboard_RR; Pull_Rod_inboard_RR; Pull_Rod_outboard_RR; Applied_Force_location_RR];

%% Calculate Forces

[Applied_Forces, Res_Forces, Loading_Conditions] = Suspension_Force_Calculator(mounting_locations, car_params);

%% Table Data
mounting_locations_positions = {'FL LCAF Inboard', 'FL LCAF Outboard', 'FL LCAR Inboard', 'FL LCAR Outboard', 'FL UCAF Inboard', 'FL UCAF Outboard', 'FL UCAR Inboard', 'FL UCAR Outboard', 'FL Tie Rod Inboard', 'FL Tie Rod Outboard', 'FL Push/Pull Rod Inboard', 'FL Push/Pull Rod Outboard', 'FL Applied Force', ...
                                    'FR LCAF Inboard', 'FR LCAF Outboard', 'FR LCAR Inboard', 'FR LCAR Outboard', 'FR UCAF Inboard', 'FR UCAF Outboard', 'FR UCAR Inboard', 'FR UCAR Outboard', 'FR Tie Rod Inboard', 'FR Tie Rod Outboard', 'FR Push/Pull Rod Inboard', 'FR Push/Pull Rod Outboard', 'FR Applied Force', ...
                                    'RL LCAF Inboard', 'RL LCAF Outboard', 'RL LCAR Inboard', 'RL LCAR Outboard', 'RL UCAF Inboard', 'RL UCAF Outboard', 'RL UCAR Inboard', 'RL UCAR Outboard', 'RL Tie Rod Inboard', 'RL Tie Rod Outboard', 'RL Push/Pull Rod Inboard', 'RL Push/Pull Rod Outboard', 'RL Applied Force', ...
                                    'RR LCAF Inboard', 'RR LCAF Outboard', 'RR LCAR Inboard', 'RR LCAR Outboard', 'RR UCAF Inboard', 'RR UCAF Outboard', 'RR UCAR Inboard', 'RR UCAR Outboard', 'RR Tie Rod Inboard', 'RR Tie Rod Outboard', 'RR Push/Pull Rod Inboard', 'RR Push/Pull Rod Outboard', 'RR Applied Force'};
    
forces_order = {'Fx', 'Fy', 'Fz'};
suspension_members = {'LCAF', 'LCAR', 'UCAF', 'UCAR', 'Tie Rod / Driveshaft', 'Push / Pull Rod'};
[Applied_Forces_Table, Res_Forces_Table, Mounting_Locations_Table] = Table_Data(Applied_Forces, Res_Forces, inorder_mounting_locations, forces_order, Loading_Conditions, suspension_members);

%% Save Data

Save_Data(Applied_Forces_Table, Res_Forces_Table, Mounting_Locations_Table, output_filename);

%% Create Suspension Plots

Plot_Suspension_Members(mounting_locations, suspension_members);

