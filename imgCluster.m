function [x, y] = imgCluster(img, k)
    % Gets the size of the image
    [row, col, xx] = size(img);
    % Shapes image data for fcm use
    big = row*col;
    data = reshape(img,big,3);
    [center, U] = fcm(data, k, 2.8);
    % Initializing reference array
    [ref] = big;
    % Nested loops to iterate through all of U to populate the reference
    % array
    for i = 1:(big)
        for p = 1:k
            if(U(p,i) == max(U(:,i)))
                ref(i) = p;
            end
        end
    end
    ref = reshape(ref,row,col);
    % Nested loops to iterate through the reference array k times and
    % populate a temporary array to be displayed
    tumArea = [];
    for m = 1:k
    temp = zeros(row,col,3);
        for n = 1:row
            for o = 1:col
                if(ref(n,o) == m)
                    temp(n,o,:) = img(n,o,:);
                end
            end
        end
        % Opens k windows with the image data from the temp array
        figure,imshow(temp, []);
        % Resizes the image to the correct size per pixel
        truesize();
        for f = 1:row
            for g = 1:col
                if(temp(row,col,1) > 0.0 && temp(row,col,2) > 0.0)
                    [tumArea] = [tumArea temp(row,col,:)];
                end
            end
        end
    end
    disp(tumArea);