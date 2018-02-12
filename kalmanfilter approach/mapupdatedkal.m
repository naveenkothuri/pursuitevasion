
function I= mapupdated(solx,soly,xp,yp,vp,delT)
for i=1:1
    %k=e/p;

%% for the movement of pursuer and evader 
coefficients = polyfit([double(solx), xp], [double(soly), yp], 1);
a2 = coefficients (1);
b2 = coefficients (2);
if((xp~=solx))
    xp=xp+sign(solx-xp)*delT*vp*cos(atan(a2)); %corresponding to distance moved by evader
yp=(a2)*(xp)+b2; %I think this is wrong as xp gets updated in above step, : this comment was made on 3/1/18 when the file "maingame.m" was created.
end
end
I=[xp;yp];
%{
end
end
%}