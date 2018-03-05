pursuer_initial=[0 0];
evader2_intial=[10 0];
pursuer_theta=60;
v=1;
pursuer_velocity=v;
evader2_velocity=v;

pursuer_position_x=zeros(100,1);
pursuer_position_y=zeros(100,1);

target_position_x=5; target_position_y=6;

evader2_position_x=zeros(100,1);
evader2_position_y=zeros(100,1);

evader2_position_x(1)= 15;

delta_t=0.1;
i=2;
for t=0.1:delta_t:10
    pursuer_position_x(i)=pursuer_position_x(i-1)+(pursuer_velocity*delta_t*cosd(pursuer_theta));
    pursuer_position_y(i)=pursuer_position_y(i-1)+(pursuer_velocity*delta_t*sind(pursuer_theta));
    
    a=2*(pursuer_position_x(i-1)-evader2_position_x(i-1));
    b=2*(pursuer_position_y(i-1)-evader2_position_y(i-1));
    c=(evader2_position_x(i-1))^2 + (evader2_position_y(i-1))^2 - (pursuer_position_x(i-1))^2 - (pursuer_position_y(i-1))^2;
    d=(a^2)+(b^2);
    dy=((target_position_y*a^2)-(a*b*target_position_x)-(b*c)-(evader2_position_y(i-1)*d));
    dx=((target_position_x*b^2)-(a*b*target_position_y)-(a*c)-(evader2_position_x(i-1)*d));
    evader2_theta=atan2d(dy,dx);
    
    evader2_position_x(i)=evader2_position_x(i-1)+(evader2_velocity*delta_t*cosd(evader2_theta));
    evader2_position_y(i)=evader2_position_y(i-1)+(evader2_velocity*delta_t*sind(evader2_theta));
    i=i+1;
    
end

plot(pursuer_position_x,pursuer_position_y)
hold
plot(evader2_position_x,evader2_position_y,'r')
plot(target_position_x,target_position_y,'kx')
axis([0 20 0 10]);
grid on;