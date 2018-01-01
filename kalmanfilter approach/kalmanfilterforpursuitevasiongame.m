% Initial value of position = ip= 0;
% Initial value of velocity = iv =150m/s;
% variance of position error in output = Wp = (50m)^2
% variance of position error in output = Wv = (15m/s)^2
% Systems states are position and velocity with no process noise Why?
% Because evader model is moving with constant velocity. It is sensor
% that is not sure of its measurements. 
% sensor senses position and velocity 
% System : x(t+1) = x(t) + v(t);
%          v(t+1) = v(t);
%          y(t) = [1 0;0 1]*[x(t);v(t)] + [p)(t);v(t)];

clear all
T=200; %simulation time 
ip=0;
iv=150;
Wp= 20^2;
Wv= 2250;
s.x=[ip;iv];
s.A=[1 1;0 1];
s.B=[0;0];
s.u=0;
s.P=[Wp 0;0 Wv]; % This is jsut for initialization. Initially it is equal to output covariance matrix
% Later, in each step it gets updated
s.R=[Wp 0;0 Wv]; % This is output noise covariance matrix which is assumed constant for the entire run.
s.Q =[0 0;0 0];
s.H= [1 0;0 1];

% begin 
% % Generate random voltages and watch the filter operate.
%Mean process is same as system process
 tru=[0;150]+sqrt(s(1).P)*rand(2,1); % true states
 for t=1:T
    tru(end+1:end+2,1) =s(1).A*[tru((end-1),1);tru(end)];% These are actual states. We are inducing noise to get actual output. 
    %Here s.x is the best estimate possible taking into account all the measurements till that point
   s(end).z = (s(end).H)*tru(end-3:end-2,1) + sqrt(s(end).R)*randn(2,1); % Here we are using tru(end-3:end-2) because present states are stored there
   % create a measurement. ( This is actual measurement)
   % Note that when t=0, s.x is still the initial value. This along with
   % actual output is given to kalman filter.
   s(end+1)=kalmanf(s(end)); % perform a Kalman filter iteration
   % Now in the second structure, s.x  is updated with the best prediction
   % i.e., x(1) given one measurement
   % given one measurement. This is again used in the next iteration to
   % generate x(2) given one measurement from model. That is used along
   % with second measurement to generate x(2) given two measurements and
   % the outupt of kalman filter is x(2) given two measurements.
 end
 figure
 hold on
 grid on
 for i =1:T
 posm(:,i)= s(i).z(1);
 vecm(:,i)= s(i).z(2);
 end
 for i=1:T
 posteriorpos(:,i)= s(i+1).x(1);
 posteriorvec(:,i)= s(i+1).x(2);
 end
 for i =1:T
     xtru(i)=tru(1+2*(i-1));
     vtru(i)=tru(2*(i));
 end
 plot(posm,'r.')
 hold on
 plot(posteriorpos,'b-')
 plot(xtru,'g-')
 figure
 title('Evader x-coordinate')
 plot(vecm,'r.')
 hold on
 plot(posteriorvec,'b-');
  plot(vtru,'g-')
  hold off