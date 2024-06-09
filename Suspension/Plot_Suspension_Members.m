function [] = Plot_Suspension_Members(mounting_locations, suspension_members)
    %{
    Plot_Suspension_Members
    
    This function plots the locations of each suspension member.
    
    INPUTS:
        mounting_locations - 1x4 struct with all of the mounting locations
                             of the suspension memebrs for each wheel
        suspension_members - 1x6 cell of string arrays with the names of
                             each suspension memebr
    
    OUTPUTS:
        none

    
    Author: Alex Savic
    Date: 10/22/23
    %}

    % Preallocate
    x_coords = zeros(6, 2, 4);
    y_coords = zeros(6, 2, 4);
    z_coords = zeros(6, 2, 4);
    
    % Color Map to keep colors consistent
    color_map = [
        1 0 0;  % Red
        0 1 0;  % Green
        0 0 1;  % Blue
        1 0 1;  % Magenta
        0 1 1;  % Cyan
        1 0.5 0; % Orange 
    ];
    
    figure()
    hold on
    
    % Loop through all wheels
    for i = 1:4
        x_coords(:, :, i) = [mounting_locations(i).inboards(:, 1), mounting_locations(i).outboards(:, 1)];
        y_coords(:, :, i) = [mounting_locations(i).inboards(:, 2), mounting_locations(i).outboards(:, 2)];
        z_coords(:, :, i) = [mounting_locations(i).inboards(:, 3), mounting_locations(i).outboards(:, 3)];
        
        % Loop through all suspension members
        for j = 1:6
            color = color_map(j, :);
            plot3(x_coords(j, :, i), y_coords(j, :, i), z_coords(j, :, i), 'Color', color)
        end
    end
    
    
    xlabel("X Position (m)")
    ylabel("Y Position (m)")
    zlabel("Z Position (m)")
    title("Suspension Members")
    legend(suspension_members)
    view(3);
end

