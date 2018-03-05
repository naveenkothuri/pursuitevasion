function setup()
% acknowledgment required to the fine work done by Natural Point to provide
% API and samples how to handle NatNet.
% also a big help was provieded by Glen Lichtwark with his Tracking Tools
% (Optitrack) file exchange
% http://www.mathworks.com/matlabcentral/fileexchange/26449-tracking-tools--optitrack-

% it's recommanda to run it on matlab 2013
% you have to install NatNet SDK on your machine
% https://www.naturalpoint.com/optitrack/products/natnet-sdk/

% also Motive/Arena need to be running and the NatNet sever also set to
% local loop-back (127.0.0.1) if the code and Motive/Arena running on the
% same machine.

% and final thing you need to set rigid body in Motive/Arena

% this code was tested on Win7 64bit machine with Matlab 64bit and Motive

% addpath need to point to quaternion.m from matlab sample in NatNet SDK folder

addpath('C:\Users\Srihari\Desktop\Project\NatNetSDK - Copy\Samples\Matlab')

% Add NatNet .NET assembly so that Matlab can access its methods, delegates, etc.
% Note : The NatNetML.DLL assembly depends on NatNet.dll, so make sure they
% are both in the same folder and/or path if you move them.
 dllPath = 'C:\Users\Srihari\Desktop\Project\NatNetSDK - Copy\lib\x64\NatNetML.dll';
assemblyInfo = NET.addAssembly(dllPath);


theClient = NatNetML.NatNetClientML(0); % Input = iConnectionType: 0 = Multicast, 1 = Unicast

% Connect to an OptiTrack server (e.g. Motive)
HostIP = char('127.0.0.1');
theClient.Initialize(HostIP, HostIP);
% Flg = returnCode: 0 = Success
RigidBody_ID=1; %set acording to your need
end

function [xpos,ypos,zpos,yaw,pitch,roll] = getdata()
frameOfData = theClient.GetLastFrameOfData();
rigidBodyData = frameOfData.RigidBodies(RigidBody_ID);

% angle
q = quaternion( rigidBodyData.qx, rigidBodyData.qy, rigidBodyData.qz, rigidBodyData.qw ); % extrnal file quaternion.m
qRot = quaternion( 0, 0, 0, 1);    % rotate pitch 180 to avoid 180/-180 flip for nicer graphing
q = mtimes(q, qRot);
angles = EulerAngles(q,'zyx');
xpos=rigidBodyData.x
ypos=rigidBodyData.y
zpos=rigidBodyData.z


yaw = angles(2) * 180.0 / pi
pitch = -angles(1) * 180.0 / pi  % must invert due to 180 flip above
roll = -angles(3) * 180.0 / pi  % must invert due to 180 flip above
%theClient.Uninitialize % disconnect
end

setup()
getdata()