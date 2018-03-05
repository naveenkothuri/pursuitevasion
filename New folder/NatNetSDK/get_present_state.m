function [xpos,zpos,yaw]=get_present_state()
    
rto = get_param('Motivedisplay/Gainz','RuntimeObject'); 
zpos =rto.OutputPort(1).Data;
rto1= get_param('Motivedisplay/Gainx','RuntimeObject');
xpos=rto1.OutputPort(1).Data;
rto2= get_param('Motivedisplay/Gainyaw','RuntimeObject');
yaw=rto2.OutputPort(1).Data;

end