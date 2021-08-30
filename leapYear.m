x= input('enter:');
index= x<1582;
x(index);
b= 400;
c= 4;
d= 100;
msg= ['Error(Year must be greater than 1582)'];
msg1=['Leap year'];
msg2=['Not a leap year'];
if x<1582 
    disp(msg);
elseif rem(x,b)*(x/b)==0&&rem(x,d)*(x/d)==0
    disp(msg1);
elseif rem(x,c)*(x/c)==0 &&rem(x,d)*(x/d)~=0
        disp(msg1);
end
if rem(x,b)*(x/b)~=0&&rem(x,d)*(x/d)==0
    disp(msg2);
elseif rem(x,b)*(x/b)~=0&&rem(x,d)*(x/d)~=0&&rem(x,c)*(x/c)~=0
    disp(msg2);
end




   

    



