OE=[0 10 0];
OP=[0 0 0];
OT=[10 3 0];
% OT=[4 9 0];
% OT_e=[4 4 0];
% OI=[2.625,7.21,0];
OI=[4.6,8.5,0];
delta_time=0.05;
X_axis=[10 0 0];
ve=0.9;vp=1.8;
% time_length=5.35;
time_length=6.4;
array_length=ceil(time_length/delta_time);
p_x=zeros(1,array_length);
p_y=zeros(1,array_length);
e_x=zeros(1,array_length);
e_y=zeros(1,array_length);
evader_delay=0;
j=0;

for i=1:delta_time:time_length
    j=j+1;
    p_x(j)=OP(1);
    p_y(j)=OP(2);
    e_x(j)=OE(1);
    e_y(j)=OE(2);
    
%     t_x(i)=OT(1);
%     t_y(i)=OT(2);
    
    PE=OE-OP;
    PT=OT-OP;
    PC=(1/(1-(ve/vp)^2))*PE;
    R=(ve/vp)*norm(PC);
    CT=PT-PC;
    CI=R*CT/norm(CT);
    PI=PC+CI;
    phi_p=atan2d(norm(cross(PI,PC)),dot(PI,PC));
    
    phi_PE_x_axis = atan2d(norm(cross(X_axis,PE)),dot(X_axis,PE));
    phi_p_x_axis = phi_PE_x_axis - phi_p;
    OP = OP+[vp*delta_time*cosd(phi_p_x_axis) vp*delta_time*sind(phi_p_x_axis) 0];
    
    
    % E moves towards I (Target lying in P's dominance region)
%     OI=PI+OP;
    EI=OI-OE;
    phi_e=atan2d(norm(cross(X_axis,EI)),dot(X_axis,EI));

    % E moves towards T (Target lying in E's dominance region)
%   ET=OT-OE;
%   phi_e=atan2d(norm(cross(X_axis,ET)),dot(X_axis,ET));

    
        if((i>2)&&(i<6)&&(evader_delay))
            OE=OE;
        else
            OE = OE+[ve*delta_time*cosd(phi_e) -ve*delta_time*sind(phi_e) 0];
        end

%     OT = OT+ [0.7 0.7 0];
end

zero_index = find(p_x, 1, 'last');
p_x=p_x(1:zero_index);
p_y=p_y(1:zero_index);
e_x=e_x(1:zero_index);
e_y=e_y(1:zero_index);

% plot(p_x,p_y,'--')
plot(p_x,p_y)
axis([-1 7 -1 11])
grid on;
hold on;
% plot(e_x,e_y,'r--')
plot(e_x,e_y,'r')
% plot(OT(1),OT(2),'s','Markersize',14,'MarkerFaceColor','g');
% plot(OT_e(1),OT_e(2),'s','Markersize',14,'MarkerFaceColor','g');
% plot(0,10,'rs')
% plot(0,0,'b^')

% plot(t_x,t_y,'g*')
