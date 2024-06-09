function [] = Save_Data(Applied_Forces_Table, Res_Forces_Table, Mounting_Locations_Table, filename)
     %{
    Save_Data
    
    This function saves the data of the simulation to a .csv file
    
    INPUTS:
        Applied_Forces_Table - 1x4 cell with all of the applied forces in
                               table format
        Res_Forces_Table - 1x4 cell with all of the resultant forces in
                           table format
        Mounting_Locations_Table - 52x3 table with all of the mounting
                                   locations for each suspension member of
                                   each wheel
        filename - string array represnting desired filename to save data
                   to
    
    OUTPUTS:
        none

    
    Author: Alex Savic
    Date: 10/22/23
    %}

    fid = fopen(filename, 'w');
    
    % Export the Mounting_Locations_Table data
    fprintf(fid, 'Mounting Locations\n');
    row_labels = Mounting_Locations_Table.Properties.RowNames;
    header = Mounting_Locations_Table.Properties.VariableNames;
    header_row = ['Row Labels', header];
    header_row = strjoin(header_row, ',');
    fprintf(fid, '%s\n', header_row);
    data = Mounting_Locations_Table{:,:};
    for row = 1:size(data, 1)
        row_label = row_labels{row};
        row_data = data(row, :);
        % Convert row_data to cell array of character vectors
        row_data = arrayfun(@(x) num2str(x), row_data, 'UniformOutput', false);
        row_data = cellstr(row_data);
        row_str = [row_label, row_data];
        row_str = strjoin(row_str, ',');
        fprintf(fid, '%s\n', row_str);
    end
    fprintf(fid, '\n'); 
    

    all_tables = [Applied_Forces_Table, Res_Forces_Table]; 
    
    table_headers = {'Applied Forces FL', 'Applied Forces FR', 'Applied Forces RL', 'Applied Forces RR', ...
                     'Resultant Forces FL', 'Resultant Forces FR', 'Resultant Forces RL', 'Resultant Forces RR'};
    
    % Loop through Applied_Forces_Table and Res_Forces_Table
    for i = 1:numel(all_tables)
        current_table = all_tables{i};
    
        % Write a separator to separate the tables
        fprintf(fid, table_headers{i});
        fprintf(fid, '\n');  % Add a newline to separate the header
        
        % Export the current table's header row
        header = current_table.Properties.VariableNames;
        header_row = ['Row Labels', header]; % Include "Row Labels" in the header
        header_row = strjoin(header_row, ','); % Join header names into a single string
        fprintf(fid, '%s\n', header_row);
        
        % Export the data in the current table to the CSV file
        data = current_table{:,:};
        row_labels = current_table.Properties.RowNames; % Get row labels
        data_str = cell(size(data, 1), size(data, 2) + 1); % Include an extra column for row labels
        for row = 1:size(data, 1)
            data_str{row, 1} = row_labels{row}; % Store row label in the first column
            for col = 2:size(data, 2) + 1
                data_str{row, col} = num2str(data(row, col - 1));
            end
        end
        
        % Loop through data rows and join with commas
        for row = 1:size(data_str, 1)
            fprintf(fid, '%s\n', strjoin(data_str(row, :), ','));
        end
        
        fprintf(fid, '\n');  % Add a newline between tables
    end
    
    fclose(fid);
end
