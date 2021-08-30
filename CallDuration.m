CostPerMin = 0;
MinutesOfCall = 0;
DurationOfCall = 0;
while true
    fprintf('\nPlease select the time of day your call was made\n\n1. Day\n2. Evening\n3. Night\n\n')
    TimeOfCall = input('Input number corresponding to your selection: ');
    MinutesOfCall = input('How many minutes did your call spend? ');
    if MinutesOfCall == 0
        fprintf('\nYou have spent 0 minutes on this call.\n')
        Menu = 0;
    end
    switch(TimeOfCall)
        case(1)
            DurationOfCall = ceil(MinutesOfCall);
            if DurationOfCall <= 10
                CostPerMin = 0.10*DurationOfCall;
            elseif DurationOfCall >= 10 && DurationOfCall <= 30
                CostPerMin = 1 + (0.08*(DurationOfCall-10));
            elseif DurationOfCall >= 30
                CostPerMin = 2.60 + (0.06*(DurationOfCall-30));
            end
        case(2)
            DurationOfCall = ceil(MinutesOfCall);
            if DurationOfCall <= 10
                CostPerMin = 0.07*DurationOfCall;
            elseif DurationOfCall >= 10 && DurationOfCall <= 30
                CostPerMin = 0.70 + (0.05*(DurationOfCall-10));
            elseif DurationOfCall >= 30
                CostPerMin = 1.70 + (0.04*(DurationOfCall-30));
            end
        case(3)
            DurationOfCall = ceil(MinutesOfCall);
            if DurationOfCall <= 10
                CostPerMin = 0.04*DurationOfCall;
            elseif DurationOfCall >= 10 && DurationOfCall <= 30
                CostPerMin = 0.40 + (0.03*(DurationOfCall-10));
            elseif DurationOfCall >= 30
                CostPerMin = 1.00 + (0.02*(DurationOfCall-30));
           %elseif DurationOfCall >= 30
               %Additional = ceil(DurationOfCall/13);
               %if Additional > 0
                   %CostPerMin = 1.00 + (0.02*((DurationOfCall-30)*Additional));
               %elseif Additional < 0
                   %CostPerMin = 1.00 + (0.02*(DurationOfCall-30));
               %end     
            end
    end
    break
end
fprintf('Your total is $%0.2f\n', CostPerMin)