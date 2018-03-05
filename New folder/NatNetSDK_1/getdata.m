function [xpos,ypos,zpos,yaw,pitch,roll] = getdata()
theClient = NatNetML.NatNetClientML(0); % Input = iConnectionType: 0 = Multicast, 1 = Unicast

% Connect to an OptiTrack server (e.g. Motive)
HostIP = char('127.0.0.1');
theClient.Initialize(HostIP, HostIP);
% Flg = returnCode: 0 = Success
RigidBody_ID=1; %set acording to your need
frameOfData = theClient.GetLastFrameOfData();
rigidBodyData = frameOfData.RigidBodies(RigidBody_ID);

% angle
q = quaternion( rigidBodyData.qx, rigidBodyData.qy, rigidBodyData.qz, rigidBodyData.qw ); % extrnal file quaternion.m
qRot = quaternion( 0, 0, 0, 1);    % rotate pitch 180 to avoid 180/-180 flip for nicer graphing
q = mtimes(q, qRot);
angles = EulerAngles(q,'zyx');
xpos=rigidBodyData.x;
ypos=rigidBodyData.y;
zpos=rigidBodyData.z;
yaw = angles(2) * 180.0 / pi;
pitch = -angles(1) * 180.0 / pi;  % must invert due to 180 flip above
roll = -angles(3) * 180.0 / pi;  % must invert due to 180 flip above
%theClient.Uninitialize % disconnect
java.lang.Thread.sleep(5);
end