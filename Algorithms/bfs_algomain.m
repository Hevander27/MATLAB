clear all
close all

% % Ex: 1
% input_map = false(10);
% input_map (1:5, 5:8);
% start_coords = [6, 2];
% goal_coords = [1, 1]; 

% % Ex: 2
% input_map = false(10);
% input_map (1:5, 5:8);
% start_coords = [6, 2];
% goal_coords = [1, 1]; 

% % Ex: 3
% % create = 10x5 map filled with zeros (free cells)
input_map = false(10,5);
% % mark obstacles
input_map (2:10, 1) = true;
input_map (1:2, 4:5) = true;
input_map (10, 2:3) = true;

% % Ex: 4 (NO ROUTE)
% % create = 10x5 map filled with zeros (free cells)
% input_map = false(10,5);
%  % mark obstacles
% input_map (2:10, 1) = true;
% input_map (1:2, 4:5) = true;
% input_map (10, 2:3) = true;
% obstacle that blocks start from goal
% input_map (4, 2:5) = true;
% input_map (4, 4) = false;



start_coords = [7, 3];
%goal_coords = [2, 3];
goal_coords   = [10, 5];


drawMapEveryTime = true;

Step = BFS_SearchAlgo_Function(input_map, start_coords, goal_coords, drawMapEveryTime); 
