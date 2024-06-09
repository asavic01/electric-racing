function [All_Applied_Forces, All_Resultant_Forces, Loading_Conditions] = Suspension_Force_Calculator(mounting_locations, car_params)
    %{
    Suspension_Force_Calculator
    
    This function calculates the forces acting on 6 members of a suspension
    system based on their mounting locations and specific load case. 
    
    INPUTS:
        mounting_locations - 4x1 struct, each containing a 6x3 matrix of the 
                             inboard locations of suspension members, 6x3 
                             matrix of the outboard suspension members, and the
                             location of the applied force for Front Left
                             wheel, FR wheel, RL wheel, and RR wheel
        car_params - Struct containing information on the car
    
    OUTPUTS:
        All_Resultant_Forces - 9x6x4 matrix containing the resultant forces
                               of each suspension member for all 4 wheels
                               under different loadings
        All_Applied_Forces - 9x3x4 matrix containing all of the applied forces
                             on each wheel for different loading conditions
            
    Inboard/Outboard Array Structure:
            x   y   z
    LCAF
    LCAR
    UCAF
    UCAR
    Tie Rod / Driveshaft
    Push / Pull Rod
    
    Author: Alex Savic
    Date: 10/22/23
    %}
    
    %% Extracting Data
    
    mass = car_params.mass;
    weight_rear = car_params.weight_rear;
    wheelbase = car_params.wheelbase;
    track_width = car_params.track_width;
    center_of_gravity = car_params.COG;
    
    weight_disribution = [((1 - weight_rear) / 2); ((1 - weight_rear) / 2); (weight_rear / 2); (weight_rear / 2)];
    
    g = 9.81;
    %% G Forces
    
    % G force for different load cases (lon_G, lat_G)
    % Note: G force acceleration follows sign convention:
    % Forward, driver left, and up is (+)
    %{
    max speed
    max acc
    max braking
    max reverse braking
    max turn left
    max turn right
    combined left
    combined right
    max bump
    %}
    Loading_Conditions = {'Max Speed', 'Max Acc.', 'Max Braking', 'Max Reverse Braking', 'Max Turn Left', 'Max Turn Right', 'Combined Left', 'Combined Right', 'Max Bump'};
    
    G_Forces = [0, 0;
                2, 0;
                -1.9, 0;
                1.75, 0;
                0, 2.5;
                0, -2.5;
                0.5, 2;
                0.5, -2;
                0, 0];
    
    % Signs representing if weight is transferred to or away from wheel
    WT_signs_FL = [1, 1;
                  -1, 1;
                   1, 1;
                  -1, 1;
                   1, -1;
                   1, 1;
                   -1, -1;
                   -1, 1
                   1, 1];
    
    WT_signs_FR = [1, 1;
                  -1, 1;
                   1, 1;
                  -1, 1;
                   1, 1;
                   1, -1;
                   -1, 1;
                   -1, -1
                   1, 1];
    
    WT_signs_RL = [1, 1;
                   1, 1;
                  -1, 1;
                   1, 1;
                   1, -1;
                   1, 1;
                   1, -1;
                   1, 1
                   1, 1];
    
    WT_signs_RR = [1, 1;
                   1, 1;
                  -1, 1;
                   1, 1;
                   1, 1;
                   1, -1;
                   1, 1;
                   1, -1
                   1, 1];
    
    WT_signs = cat(3, WT_signs_FL, WT_signs_FR, WT_signs_RL, WT_signs_RR);
    
        
    %% Weight Transfer
    
    lon_WT = mass*abs(G_Forces(:, 1))*g*center_of_gravity / wheelbase;
    lat_WT = mass*abs(G_Forces(:, 2))*g*center_of_gravity / track_width;
    
    %% Determing Forces
    
    All_Resultant_Forces = zeros(length(G_Forces), 6, 4);
    All_Applied_Forces = zeros(length(G_Forces), 3, 4);
    forces = zeros(3);
    Moment_Center = [0, 0, 0];
    
    
    % Loop through each wheel
    for i = 1:size(weight_disribution)
        %% Applied Forces 
    
        % Note: Fx, Fy, Fz are column vectors of length(load_cases_Gs)
        % Fz applied on specific wheel
        Fz = ((mass*g) + ((lon_WT .* WT_signs(:, 1, i)) + (lat_WT .* WT_signs(:, 2, i)))) * weight_disribution(i);
        Fz_percent = Fz / (mass * g);
    
        % Fz for going over a bump with 5Gs
        Fz(end) = (mass*g * weight_disribution(i)) * 5;
    
        % Fx on the wheel (depends on percent of Fz on the wheel)
        Fx_car = mass * G_Forces(:, 1) * g;
        Fx = Fx_car .* Fz_percent;
        
        % Fy on the wheel (depends on percent of Fz on the wheel)
        Fy_car = mass * G_Forces(:, 2) * g;
        Fy = Fy_car .* Fz_percent;
        
        %% Unit Vectors
    
        mounting_distance = mounting_locations(i).outboards - mounting_locations(i).inboards;
        unit_vectors = mounting_distance ./ vecnorm(mounting_distance, 2, 2);
    
        %% Moment Arms
    
        Moment_Arms = mounting_locations(i).inboards - Moment_Center;
        Applied_Force_Moment_Arm = mounting_locations(i).applied_force_location - Moment_Center;
    
        All_Applied_Forces(:, :, i) = [Fx, Fy, Fz];
        
        %% Calculating Resultant Forces
    
        for j = 1:length(Fx)
            forces(1,1) = Fx(j);
            forces(2,2) = Fy(j);
            forces(3,3) = Fz(j);
        
            % Moment From Applied Forces
            Applied_Moments = [cross(Applied_Force_Moment_Arm, forces(1, :)); ...
                               cross(Applied_Force_Moment_Arm, forces(2, :)); ...
                               cross(Applied_Force_Moment_Arm, forces(3, :))];
        
            % Solving for Forces
            A = [unit_vectors' ; cross(Moment_Arms, unit_vectors)'];
            B = [-sum(forces(1, :)); -sum(forces(2, :)); -sum(forces(3, :)); -sum(Applied_Moments(:,1)); -sum(Applied_Moments(:,2)); -sum(Applied_Moments(:,3))];
            Resultant_Forces = A \ B;
            
            All_Resultant_Forces(j, :, i) = Resultant_Forces;
        end
    end
    
end