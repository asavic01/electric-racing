function [Applied_Forces_Table, Res_Forces_Table, Mounting_Locations_Table] = Table_Data(Applied_Forces, Res_Forces, inorder_mounting_locations,forces_order, Loading_Conditions, suspension_members)
    %{
    Table_Data
    
    This function takes arrays of data and turns them into table format
    
    INPUTS:
        Applied_Forces - 4x1 cell of matrices with all of the applied
                        forces on the wheels
        Res_Forces - 4x1 cell of matrices with all of the resultant forces
                     on each suspension member
        inorder_mounting_locations - array of all mounting locations
        forces_order - cell vector of order of forces
        Loading_Conditions - cell vector of all loading conditions
        suspension_members - cell vector with all suspension members names
    
    OUTPUTS:
        Applied_Forces_Table - table with all the applied forces
        ResForces_Table - table with all the resultant forces
        Mounting_Locations_Table - table with all the mounting locations

    
    Author: Alex Savic
    Date: 10/22/23
    %}
    
    mounting_locations_positions = {'FL LCAF Inboard', 'FL LCAF Outboard', 'FL LCAR Inboard', 'FL LCAR Outboard', 'FL UCAF Inboard', 'FL UCAF Outboard', 'FL UCAR Inboard', 'FL UCAR Outboard', 'FL Tie Rod Inboard', 'FL Tie Rod Outboard', 'FL Push/Pull Rod Inboard', 'FL Push/Pull Rod Outboard', 'FL Applied Force', ...
                                    'FR LCAF Inboard', 'FR LCAF Outboard', 'FR LCAR Inboard', 'FR LCAR Outboard', 'FR UCAF Inboard', 'FR UCAF Outboard', 'FR UCAR Inboard', 'FR UCAR Outboard', 'FR Tie Rod Inboard', 'FR Tie Rod Outboard', 'FR Push/Pull Rod Inboard', 'FR Push/Pull Rod Outboard', 'FR Applied Force', ...
                                    'RL LCAF Inboard', 'RL LCAF Outboard', 'RL LCAR Inboard', 'RL LCAR Outboard', 'RL UCAF Inboard', 'RL UCAF Outboard', 'RL UCAR Inboard', 'RL UCAR Outboard', 'RL Tie Rod Inboard', 'RL Tie Rod Outboard', 'RL Push/Pull Rod Inboard', 'RL Push/Pull Rod Outboard', 'RL Applied Force', ...
                                    'RR LCAF Inboard', 'RR LCAF Outboard', 'RR LCAR Inboard', 'RR LCAR Outboard', 'RR UCAF Inboard', 'RR UCAF Outboard', 'RR UCAR Inboard', 'RR UCAR Outboard', 'RR Tie Rod Inboard', 'RR Tie Rod Outboard', 'RR Push/Pull Rod Inboard', 'RR Push/Pull Rod Outboard', 'RR Applied Force'};
    
    Mounting_Locations_Table = array2table(inorder_mounting_locations, 'VariableNames', {'x', 'y', 'z'}, ...
                                                'RowNames', mounting_locations_positions);
   
    Applied_Forces_table_FL = array2table(Applied_Forces(:, :, 1), 'VariableNames', forces_order, ...
                                                'RowNames', Loading_Conditions);
    Applied_Forces_table_FR = array2table(Applied_Forces(:, :, 2), 'VariableNames', forces_order, ...
                                                'RowNames', Loading_Conditions);
    Applied_Forces_table_RL = array2table(Applied_Forces(:, :, 3), 'VariableNames', forces_order, ...
                                                'RowNames', Loading_Conditions);
    Applied_Forces_table_RR = array2table(Applied_Forces(:, :, 4), 'VariableNames', forces_order, ...
                                                'RowNames', Loading_Conditions);
    
    Res_Forces_table_FL = array2table(Res_Forces(:, :, 1), 'VariableNames', suspension_members, ...
                                                'RowNames', Loading_Conditions);
    Res_Forces_table_FR = array2table(Res_Forces(:, :, 2), 'VariableNames', suspension_members, ...
                                                'RowNames', Loading_Conditions);
    Res_Forces_table_RL = array2table(Res_Forces(:, :, 3), 'VariableNames', suspension_members, ...
                                                'RowNames', Loading_Conditions);
    Res_Forces_table_RR = array2table(Res_Forces(:, :, 4), 'VariableNames', suspension_members, ...
                                                'RowNames', Loading_Conditions);
    
    
    Applied_Forces_Table = {Applied_Forces_table_FL, Applied_Forces_table_FR, Applied_Forces_table_RL, Applied_Forces_table_RR};
    Res_Forces_Table = {Res_Forces_table_FL, Res_Forces_table_FR, Res_Forces_table_RL, Res_Forces_table_RR};
    

end


