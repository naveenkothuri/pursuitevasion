pause(4)
mymotor_A = motor(myev3,'A');
mymotor_B = motor(myev3,'B')
a_speed=-50;
b_speed=-49;
mymotor_A.Speed = a_speed;
mymotor_B.Speed = b_speed;


mdl = 'ExampleMotive_control_communication';
load_system(mdl)

% simOut = sim(mdl);

start(mymotor_A)
start(mymotor_B)
pursuer_x=zeros(1,6);
pursuer_y=zeros(1,6);
evader_x=zeros(1,6);
evader_y=zeros(1,6);
  
  
for i=1:6
  set_param(mdl,'SimulationCommand','start')  
  mymotor_A.Speed = a_speed;
  mymotor_B.Speed = b_speed;
  pause(0.2)
  set_param(mdl,'SimulationCommand','stop')
%   a_speed=a_speed+5;
%   b_speed=b_speed+5;
  pursuer_x(i)=yout(end,1);
  pursuer_y(i)=yout(end,2);
  evader_x(i)=yout(end,3);
  evader_y(i)=yout(end,4);
end

stop(mymotor_A)
stop(mymotor_B)

