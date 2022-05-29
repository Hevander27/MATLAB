function Step = DFS_SearchAlgo_Function(input_map, start_coords, goal_coords, drawMapEveryTime)
% Run DFS algorithm on grid
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

map = zeros(nrows, ncols);

map(~input_map) = 1;
map(input_map)  = 2;

start_node = sub2ind(size(map), start_coords(1), start_coords(2));
goal_node = sub2ind(size(map), goal_coords(1), goal_coords(2));

map(start_node) =  5;
map(goal_node) = 6;

distanceFromStart = 0;

Step = 0;

Visited_Frontier = [start_node];

stack = CStack(start_node);


while true

    map(start_node) = 5;
    map(goal_node)  = 6;

    if (drawMapEveryTime)
        pause(0.1);
        image(1.5, 1.5, map);
        grid on; axis image;
        drawnow;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Get the frontier node (tope of the stack) - Note do not remove it
    Frontier_node = stack.top();
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % if frontier node is goal we're done
    if (Frontier_node == goal_node)
        break;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% start from here %%
    % Update map showing frontier in red
    map(Frontier_node) = 3;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Explore the frontier neighbors
    
    % compute row, column coordinates or the Frontier_node node
    [i , j] = ind2sub(size(input_map), Frontier_node);
    
    % set a pointer to the next element to be added whicis Step + 1
    % Visist each neighbor of the Frontier_node and update the map
    % If n neighbor is valid for exploration wit either visit before or
    % exit
    for n = 1 : 4
        % 1 visit each enighbor of the Frontier_node node
        if n == 1 % Up
            row = i - 1; col = j;
        elseif n == 2 % Right
            row = i ; col = j + 1;
        elseif n == 3 % Left
            row = i ; col = j - 1;
        else % Down
            row = i + 1 ; col = j;
        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % check neighbor is inside the map
        if (row < 1 || row > size(map,1)) 
            if n < 4
                continue
            else  % n = 4 and all options are not valid so pop and break
                stack.pop();
                break
            end
        elseif (col < 1 || col > size(map,2))
            if n < 4
                continue;
            else
                stack.pop();
                break
            end
        end

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % skip if barrier
        
        % For easy handling
        neighbor = sub2ind(size(map), row, col);
        if (input_map(neighbor)) % equivilant to if (map == 2) then continue
            if n < 4
                continue
            else % n = 4 and all options are not valid so pop and break
                stack.pop();
                break
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % check if not visited before
        
        % check if neighnor is in Visited_Frontier
        % if yes skip neighbor
        if (any(Visited_Frontier == neighbor))
            if n < 4
                continue
            else
                stack.pop();
                break
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % All tests are passed so this neighbor is a good neighbor
        % Update add it to ht earray and update its related info
        Step = Step + 1;
        % add ID to array 
        stack.push(neighbor) ;
        % add its distance from start
        Visited_Frontier = [Visited_Frontier neighbor];
        % add its exploration step
        
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % we need to break once we push a new neighbor in the stack
        break;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % just life BFS we need to know if we can explore further or we are
    % done. Checking if there are other nodes to explore or not
    if (stack.isempty())
        break;
    end
end


end
