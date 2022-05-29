clear all;

%-------------------------------------------
load('webcamsSceneReconstruction.mat');
cam = webcam("PureThermal (fw:v1.3.0)");   
cam.Resolution = '160x120';
%-------------------------------------------

new_String = strrep(cam.Resolution,'x',' ');
str_Array = split(new_String)';
res_Array = cellfun(@str2num,str_Array);
%---------------------------------------------
disp('Face the camera...');
waittime = 5;
interval = 1;
timepassed = 0;
while timepassed < waittime
    pause(interval)
    timepassed = timepassed + interval;
    disp(['Time passed:' num2str(timepassed)])
    video_Frame = snapshot(cam);
end
%---------------------------------------------
y = tempCalculate(video_Frame);
tracker = MultiObjectTrackerKLT;
video_Player = vision.VideoPlayer('Position',[200 100 res_Array ]);
face_Detector = vision.CascadeObjectDetector();
point_Tracker = vision.PointTracker('MaxBidirectionalError', 2);

run_loop = true;
number_of_Points = 0;


disp('Press Ctrl-C to exit...');
while run_loop
    
    video_Frame = snapshot(cam);
    gray_Frame = rgb2gray(video_Frame);
    
    if number_of_Points < 10 
        
        face_Rectangle = face_Detector.step(gray_Frame);
        
        if  ~isempty(face_Rectangle)
            points = detectMinEigenFeatures(gray_Frame, 'ROI', face_Rectangle(1, :));
            
            xy_Points = points.Location;
            number_of_Points = size(xy_Points, 1);
            release(point_Tracker);
            initialize(point_Tracker, xy_Points, gray_Frame);
            
            previous_Points = xy_Points;
            
            rectangle = bbox2points(face_Rectangle(1, :));
            face_Polygon = reshape(rectangle',1, []);

            camParam = stereoParams.CameraParameters1;
          
            video_Frame = undistortImage(video_Frame, camParam);
            face1 = face_Detector(video_Frame);

            %---Temperature scaling----------------------
            if mod(number_of_Points,53)==0
                y = tempCalculate(video_Frame);
            end
            %--------------------------------------------
            distanceAsString = sprintf('%0.2f%c F', y,char(176));
            video_Frame = insertObjectAnnotation(video_Frame,'rectangle',face1,distanceAsString,'FontSize',18);
            video_Frame = insertMarker(video_Frame, xy_Points, '+', 'Color',"green");
            
        end
    else
       
        [xy_Points, isFound] = step(point_Tracker, gray_Frame);
        new_Points = xy_Points(isFound, :);
        old_Points = previous_Points(isFound, :);
        number_of_Points = size(new_Points, 1);
        
        if number_of_Points >= 10
            [xform, old_Points, new_Points] =  estimateGeometricTransform(...
                old_Points, new_Points, 'similarity', 'MaxDistance',4);
            
            rectangle = transformPointsForward(xform, rectangle);
            
            face_Polygon = reshape(rectangle', 1, []);
            camParam = stereoParams.CameraParameters1;

            video_Frame = undistortImage(video_Frame,camParam);
            face1 = face_Detector(video_Frame);
            

            %---Temperature scaling----------------------
            if mod(number_of_Points,53)==0
                y = tempCalculate(video_Frame);
            end
            %--------------------------------------------
            
            distanceAsString = sprintf('%0.2f%c F', y,char(176));
            video_Frame = insertObjectAnnotation(video_Frame,'rectangle',face1,distanceAsString,'FontSize',18);
            video_Frame = insertMarker(video_Frame, xy_Points, '+', 'Color', 'green');
            
            previous_Points = new_Points;
            setPoints(point_Tracker, previous_Points);
            
        end
    end
    step(video_Player, video_Frame);
    run_loop = isOpen(video_Player);
        
end

release(video_Player);
release(point_Tracker);
release(face_Detector);
clear cam;