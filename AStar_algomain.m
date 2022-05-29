clear all 
close all

% Ex: 1
% map = false(10);
% map (1:5, 5:8) = true;
% start_coords = [1, 1];
% goal_coords = [10, 10];

% Ex: 2
% map = false(10);
% map (1:5, 6) = true;
% start_coords = [6, 2];
% goal_coords  = [8, 9];

% Ex: 3
% map = false(10);
% map (1:5, 5:8) = true;
% start_coords = [6, 2];
% goal_coords = [1, 10];

% Ex: 4
map = false(10, 5);
map (2:10, 1) = true;
map (1:2, 4:5) = true;
map (10, 2:3) = true;
% % assign start and goal node
start_coords = [9, 2];
goal_coords  = [3, 5];

% Ex: 5
% map = false(10, 5);
% map (2:10, 1) = true;
% map (1:2, 4:5) = true;
% map (10, 2:3) = true;
% % assign start and goal node
% start_coords = [5, 2];
% goal_coords  = [10, 5];

% Ex: 6
% map = false(10, 5);
% map (2:10, 1) = true;
% map (1:2, 4:5) = true;
% map (10, 2:3) = true;
% % assign start and goal node
% start_coords = [7, 3];
% goal_coords =  [7, 5];

% Ex: 7 No route check
% map = false(10, 5);
% map (:, 1) = true;
% map (1, 5) = true;
% map (10, 2:3) = true;
% map (4, 2:4)  = true;
% map (2:3, 3)  = true;
% start_coords  = [7, 4];                                             
% goal_coords   = [3, 2];

redrawMap   = true;
uniformGrid = false;

algorithm = 'A';

if algorithm == 'D'
    step = AStar_SearchAlgo_Function(map,start_coords,goal_coords, redrawMap, uniformGrid);
elseif algorithm == 'A'
    step = AStar_SearchAlgo_Function(map, start_coords,goal_coords, redrawMap, uniformGrid);
end
