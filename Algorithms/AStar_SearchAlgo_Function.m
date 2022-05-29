function Step = AStar_SearchAlgo_Function(input_map,start_coords, goal_coords, drawMapEveryTime, uniformGrid)
% Dijkstra's algorithm on a grid - Inputs and OutPuts
% Inputs :
%   input_map : a logical array where the freespace cells are false or 0
%   and the obstacles are true or 1
%   start_coords and goal_coords : Coordinates of the start and end call
%   repsectively, the first entry is the row and the second the column.
% Outputs :  
%   route : An array containing the linear indices of the cells along the
%   shortest route from start to goal or an empty array if there is no
%   route. This is a single dimensional vector
%   Step: Remembr to also return  the total number of nodes expanded during
%   your search.
%

%  setting up a color map to visualize expansion
%  1) setting up colormap
%  1 - white - free cell
%  2 - black - obstacle
%  3 - red - explored frontiers
%  4 - blue - future frontiers
%  5 - green - start
%  6 - yellow - goal
cmap = [1 1 1;... % white
        0 0 0;... % black
        1 0 0;... % red
        0 0 1;... % blue
        0 1 0;... % green
        1 1 0;... % yellow
        0.5 0.5 0.5]; % grey

colormap(cmap)

[nrows, ncols] = size(input_map);

% map - table that keeps track of the start of each grid cell
map = zeros(nrows, ncols);

map(~input_map) = 1; % Mark free cells with white
map(input_map)  = 2; % Mark obstacles cells with black

% Generate linear indices of start and gaol nodes
% sub2ind = (col_index-1) * col size + row_index = (9-1)*10+8 = 88
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
goal_node = sub2ind(size(map), goal_coords(1), goal_coords(2));

map(start_node) =  5;   % mark start node with green
map(goal_node) = 6;     % mark goal node with yellow


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Cost array
Cost = ones(size(input_map));
% skip this part if cost is uniform
if (~uniformGrid)
    if start_coords(1) > goal_coords(1)
        Cost(start_coords(1)-1, start_coords(2)) = 1000;
    elseif start_coords(1) < goal_coords(1)
        Cost(start_coords(1)+1, start_coords(2)) = 1000;
    elseif start_coords(2) > goal_coords(2)
        Cost(start_coords, start_coords(2)-1)    = 1000;
    elseif start_coords(2) < goal_coords(2)
        Cost(start_coords, start_coords(2)+1)    = 1000;
    end

    Cost(goal_coords(1), goal_coords(2)) = 1;


end
% skip this part if cost is uniform
if (~uniformGrid)
    Cost(input_map) = Inf;
    % setting cells zlose to obstacles with high cost of 10
    High_Cost = 100;
    for node = 1 : numel(input_map)
        % check for obstacle cells
        % if true then it is an obstacle so set its neighbor at High_Cost
        if (input_map(node))
            [row, col] = ind2sub(size(map), node);
            for n = 1: 4
                switch n
                    case n == 1
                        neighbor_row = row -1 ; neighbor_col = col;
                    case n == 2
                        neighbor_row = row +1 ; neighbor_col = col;
                    case n == 3
                        neighbor_row = row; neighbor_col = col - 1;
                    otherwise
                        neighbor_row = row; neighbor_col = col + 1;
                end

                % check that neighbor is inside the map
                if (neighbor_row < 1 || neighbor_row > size(input_map,1))
                    continue
                elseif (neighbor_col < 1 || size(input_map,2))
                    continue
                end

                neighbor = sub2ind(size(map), neighbor_row, neighbor_col);
        
                % skip if barrior or goal_node OR start_node
                if (input_map(neighbor) ==1)
                    continue;
                end

                if (neighbor == start_node)
                    continue
                end

                if (neighbor == goal_node)
                    contiune
                end

                Cost(neighbor) = High_Cost;

            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this section creates a customed cost in the map. Obstacles neighbor nodes
% take cost of 100. One of the Start node neighbor cell will be assigned a 
% cost of 1000 based on the location of the start node relative to goal
% node

% Cost array
H_func = zeros(size(input_map));
% skip this part if cost is uniform
for node = 1 : numel(input_map) 
    [node_coords(1), node_coords(2)] = ind2sub(size(H_func), node);
    H_func(node) = abs(goal_coords(1)-node_coords(1)) + abs(goal_coords(2)-node_coords(2));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize distance arrau as Inf in each cell
F_node = Inf(nrows, ncols);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate F(start_node)
% Cost of start node is just its H_Func value
F_node(start_node) = H_func(start_node) + Cost(start_node); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for each grid cell this array hold the index ofits paarent
parent = zeros(nrows, ncols);

distanceFromStart(start_node) = 0;

% Keep track of number of node expanded
Step = 0;

% MAIN LOOP
while true
    map(start_node) = 5;
    map(goal_node) = 6;

    % make drawMapEveryTime = true if you wanto see how the 
    % nodes are expanded on the grid
    if (drawMapEveryTime)
        pause(0.1);
        image(1.5, 1.5, map);
        grid on; axis image;
        drawnow;
    end
    % Find the node with the minimum distance
    % min is the value of min distance
    % current index of the first min value (in case there are more than one min)
    [min_F current_Frontier_ID] = min(F_node(:));
    % is inf True for infinite elements, isinf(X) returns an array that
    % contains 1's where elements of X are +Inf or -Inf and 0's where they
    % are not; Example isinf([pi NaN Inf -Inf]) is [0 0 1 1]

    if ((current_Frontier_ID == goal_node) || isinf(min_F))
        break
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % update map 
    map(current_Frontier_ID) = 3; % mark current node as visited (red means visited)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% we need a way so that the current frontier will not be picked from the 
% array to explire in the future. Since we get new frontier that has
% minimum distance to start mode so one way to mark the current frontier
% not to be picked again is by marking its location with Infj
    F_node(current_Frontier_ID) = Inf; % remove this node from furhter consideration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute row, column coordinates of current node
    [i, j] = ind2sub(size(F_node), current_Frontier_ID);
    % *********************************************************************
    % MY CODE HERE
    % Visit each neighbor of the current node and update the map, distance
    % and the parent tables approprately
    for n = 1 : 4
        % 1 visit each enighbor of the Frontier_node node
        switch n
            case 1 % Up
                row = i - 1; col = j;
            case 2 % Right
                row = i ; col = j + 1;
            case 3 % Left
                row = i ; col = j - 1;
            otherwise % Down
                row = i + 1 ; col = j;
        end
        
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % skip neighbor is inside the map
        if (row < 1 || row > size(map,1)) 
            continue
        elseif (col < 1 || col > size(map,2))
            continue
        end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % skip if the neighbor is a candidate frontier
        % for easy handling get ID of neighbor coord
        neighbor = sub2ind(size(map), row, col);
       
        % check if a previous frontier visited this enighbor before
        if (map(neighbor) > 1 && map(neighbor) ~= 6)
            continue
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % skip if barrier
        if (input_map(neighbor == 1))
            continue
        end
        
        % min_dist is frontier cost
        F_node(neighbor) = Cost(current_Frontier_ID) + Cost(neighbor) + H_func(neighbor);
        
        parent(neighbor) = current_Frontier_ID;
        Step = Step + 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % update the map color
        if (map(neighbor) ~= 6) % goal should be always yellow
             map(neighbor) = 4; % mark neighbor with blue (to be visited)    
        end
        % nodes are expanded on the grid
        if (drawMapEveryTime)
            image(1.50, 1.50, map);
            grid on; axis image;
            drawnow;
        end
    end
end

end
