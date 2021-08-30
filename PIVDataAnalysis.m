clear
clc
% area of one pixel
%area = 10;
% frame_number = 500; % HS0 Singing
% frame_number = 1070; % HS1 Clarinet
% frame_number = 1200; % HS5 Singing No Mask
frame_number = 10; % HS6, HS7
mean_array = [];
max_total = 0;
empty_num = 0;
for i = 1:frame_number 

    % import file
    % file_path = sprintf('D:\\MyProjects\\HS0SingingPIV\\Recording_Date=201001_Time=103029\\PIV_MPd(2x32x32_75%%ov)_01\\B%05d.vc7',i); % HS0 Singing
    % file_path = sprintf('D:\\MyProjects\\HS1ClarinetPIV\\HS1Test_25\\PIV_MPd(2x32x32_75%%ov)_01\\5x5 gaussian smoothing\\B%05d.vc7',i); % HS1 Clarinet
    % file_path = sprintf('D:\\MyProjects\\HS5Soprano\\Sing no mask\\Boundary\\5x5 gaussian smoothing\\B%05d.vc7',i); % HS5 Singing No Mask
    file_path = sprintf('D:\\MyProjects\\HS6Soprano\\sing no mask\\Boundary\\5x5 gaussian smoothing\\B%05d.vc7',i); % HS6 Soprano
    % file_path = sprintf('D:\\MyProjects\\HS7Baritone\\sing no mask\\Boundary\\5x5 gaussian smoothing\\B%05d.vc7',i); % HS7 Baritone
    file = readimx(file_path);
    % create vector data
    data = create2DVec(file.Frames{1});
    
    % find the indices of velocity < 0.1
    indices = find(data.U<0.1);
    % set indices = 0
    data.U(indices)=0;
    data.V(:, :) = 0;
    quiver( data.X, data.Y, data.U, data.V)
    % Find the non-zero values and position in the data
    [col, row, value] = find(data.U);
    % merge the position and value in one array
    total_data = [row, col, value];
    
    % group data according to rows
    g = findgroups(row);
    if isempty(g)
        empty_num = empty_num + 1;
        mean_array = [mean_array, 0];
        continue
    end
    % pick the maximum data for each group
    % row_max = splitapply(@max, total_data(:, 3), g);
    row_max = splitapply(@max_no_neg, total_data(:, 3), g);
    % find maximum velocity
    max_val = max(row_max);
    if max_val > max_total
       max_total = max_val; 
    end
    
    % calculate flow rate
    flowrate = sum(row_max*area);
    % mean velocity
    mean_velocity = mean(row_max);
    mean_array = [mean_array, mean_velocity];
    
end

boundary_velocity = mean(nonzeros(mean_array))
plot(mean_array)
disp(mean_array)
xlabel('Frame Number') 
ylabel('Mean Velocity (m/s)')