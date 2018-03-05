function initialise_optitrack()
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

addpath('E:\academics\thesis\NatNetSDK_1')

% Add NatNet .NET assembly so that Matlab can access its methods, delegates, etc.
% Note : The NatNetML.DLL assembly depends on NatNet.dll, so make sure they
% are both in the same folder and/or path if you move them.
 dllPath = 'E:\academics\thesis\NatNetSDK_1\lib\x64\NatNetML.dll';
assemblyInfo = NET.addAssembly(dllPath);



end