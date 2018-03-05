addpath('D:\NatNetSDK');

% Add NatNet .NET assembly so that Matlab can access its methods, delegates, etc.
% Note : The NatNetML.DLL assembly depends on NatNet.dll, so make sure they
% are both in the same folder and/or path if you move them.
dllPath = fullfile('D:','NatNetSDK','lib','x64','NatNetML.dll');
%assemblyInfo = NET.addAssembly(dllPath);


theClient = NatNetML.NatNetClientML(0); % Input = iConnectionType: 0 = Multicast, 1 = Unicast

% Connect to an OptiTrack server (e.g. Motive)
HostIP = char('127.0.0.1');
theClient.Initialize(HostIP, HostIP); % Flg = returnCode: 0 = Success
RigidBody_ID=1; %set acording to your need
i=1;
while(i<1000)
frameOfData = theClient.GetLastFrameOfData();
rigidBodyData = frameOfData.RigidBodies(RigidBody_ID);
xpos(i,1)=rigidBodyData.x*1000;
ypos(i,1)=rigidBodyData.y*1000;
zpos(i,1)=rigidBodyData.z*1000;
% angle
q = quaternion( rigidBodyData.qx,rigidBodyData.qy,rigidBodyData.qz,rigidBodyData.qw ); % extrnal file quaternion.m
qRot = quaternion( 0, 0, 0, 1);    % rotate pitch 180 to avoid 180/-180 flip for nicer graphing
q = mtimes(q, qRot);
angles = EulerAngles(q,'zyx');
yaw(i,1) = angles(2) * 180.0 / pi;
pitch(i,1) = -angles(1) * 180.0 / pi;  % must invert due to 180 flip above
roll(i,1) = -angles(3) * 180.0 / pi;  % must invert due to 180 flip above
pause(0.01);
i=i+1;
end
theClient.Uninitialize; % disconnect

