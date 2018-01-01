syms x y z
%{
xp=1;
yp=5;
xt=4;
yt=3;

%}
th=0;
funds=@(x,y,z)(sqrt((sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1)))^2+((((sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1)))*(((x-0.5*((y-yt)/(x-xt))*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))-x)*(-sin(z))+((y+0.5*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))-y)*cos(z)))/(sqrt(((sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1)))^2-((x-0.5*((y-yt)/(x-xt))*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2-x^2)-((y+0.5*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2-y^2)+2*(((x-0.5*((y-yt)/(x-xt))*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))+(sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1)))*cos(z))*((x-0.5*((y-yt)/(x-xt))*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))-x)+((y+0.5*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))+(sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1)))*sin(z))*((y+0.5*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))-y)))/(((x - xp)^2 + (y - yp)^2)))))^2)));
jacobian([(x-0.5*((y-yt)/(x-xt))*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))+sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1))*cos(z),(y+0.5*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))+sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1))*sin(z),sqrt(((x-(x-0.5*((y-yt)/(x-xt))*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))-sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1))*cos(z))^2+(y-(y+0.5*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))-sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1))*sin(z))^2)/((x-xp)^2+(y-yp)^2))],[x,y,z])
%for the example where xp=1,yp=5,xt=0,yt=1;
%xcm=(x-0.5*((y-yt)/(x-xt))*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)));
%ycm=(y+0.5*((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)));
%Rm=(sqrt(0.25*(((x-xp)^2+(y-yp)^2)/(yp-yt-((y-yt)/(x-xt))*(xp-xt)))^2*(((y-yt)/(x-xt))^2+1)));
fun11=@(x,y,z)((cos(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((2*x - 2*xp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + 1);
fun12=@(x,y,z)((cos(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((x - xp)^2 + (y - yp)^2)/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + ((2*y - 2*yp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2));
fun13=@(x,y,z)(-sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2));
fun21=@(x,y,z)((sin(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) - (x - xp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt)*(y - yt))/((x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2));
fun22=@(x,y,z)((sin(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) - (y - yp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) + (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt))/((x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + 1);
fun23=@(x,y,z)(cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2));
fun31=@(x,y,z)(((2*(((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))*((x - xp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - (sin(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt)*(y - yt))/((x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)) + 2*(cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))*((cos(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((2*x - 2*xp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)))/((x - xp)^2 + (y - yp)^2) - ((2*x - 2*xp)*((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2))/((x - xp)^2 + (y - yp)^2)^2)/(2*(((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2)/((x - xp)^2 + (y - yp)^2))^(1/2)));
fun32=@(x,y,z)(-((2*(((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))*((sin(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) - (y - yp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) + (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt))/((x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)) - 2*(cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))*((cos(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((x - xp)^2 + (y - yp)^2)/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + ((2*y - 2*yp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)))/((x - xp)^2 + (y - yp)^2) + ((2*y - 2*yp)*((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2))/((x - xp)^2 + (y - yp)^2)^2)/(2*(((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2)/((x - xp)^2 + (y - yp)^2))^(1/2)));
fun33=@(x,y,z)(-(2*cos(z)*(((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + 2*sin(z)*(cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))/(2*(((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2)/((x - xp)^2 + (y - yp)^2))^(1/2)*((x - xp)^2 + (y - yp)^2)));
A=[fun11(I(1),I(2),th) fun12(I(1),I(2),th) fun13(I(1),I(2),th);
   fun21(I(1),I(2),th) fun22(I(1),I(2),th) fun23(I(1),I(2),th);
   fun31(I(1),I(2),th) fun32(I(1),I(2),th) fun33(I(1),I(2),th)] %#ok<NOPTS
A1=[((cos(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((2*x - 2*xp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + 1) ((cos(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((x - xp)^2 + (y - yp)^2)/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + ((2*y - 2*yp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)) (-sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2));
   ((sin(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) - (x - xp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt)*(y - yt))/((x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)) ((sin(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) - (y - yp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) + (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt))/((x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + 1) (cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) ;
   (((2*(((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))*((x - xp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - (sin(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt)*(y - yt))/((x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)) + 2*(cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))*((cos(z)*(((2*x - 2*xp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*(y - yt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((2*x - 2*xp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt)^2)/(2*(x - xt)^3*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)))/((x - xp)^2 + (y - yp)^2) - ((2*x - 2*xp)*((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2))/((x - xp)^2 + (y - yp)^2)^2)/(2*(((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2)/((x - xp)^2 + (y - yp)^2))^(1/2))) (-((2*(((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))*((sin(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) - (y - yp)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) + (((x - xp)^2/2 + (y - yp)^2/2)*(xp - xt))/((x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)) - 2*(cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))*((cos(z)*(((2*y - 2*yt)*((x - xp)^2 + (y - yp)^2)^2)/(4*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) + ((2*y - 2*yp)*((x - xp)^2 + (y - yp)^2)*((y - yt)^2/(x - xt)^2 + 1))/(2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2) - (((x - xp)^2 + (y - yp)^2)^2*(xp - xt)*((y - yt)^2/(x - xt)^2 + 1))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^3)))/(2*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2)) + ((x - xp)^2 + (y - yp)^2)/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) + ((2*y - 2*yp)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))) - (((x - xp)^2 + (y - yp)^2)*(xp - xt)*(y - yt))/(2*(x - xt)^2*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2)))/((x - xp)^2 + (y - yp)^2) + ((2*y - 2*yp)*((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2))/((x - xp)^2 + (y - yp)^2)^2)/(2*(((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2)/((x - xp)^2 + (y - yp)^2))^(1/2))) (-(2*cos(z)*(((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + 2*sin(z)*(cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))/(2*(((cos(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2) + (((x - xp)^2 + (y - yp)^2)*(y - yt))/(2*(x - xt)*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))))^2 + (((x - xp)^2/2 + (y - yp)^2/2)/(yt - yp + ((xp - xt)*(y - yt))/(x - xt)) - sin(z)*((((x - xp)^2 + (y - yp)^2)^2*((y - yt)^2/(x - xt)^2 + 1))/(4*(yt - yp + ((xp - xt)*(y - yt))/(x - xt))^2))^(1/2))^2)/((x - xp)^2 + (y - yp)^2))^(1/2)*((x - xp)^2 + (y - yp)^2)))]

abs(det(A))
funds(1,2,th)