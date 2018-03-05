function NatNetsFunction(block)
% Level-2 MATLAB file S-Function for unit delay demo.
%   Copyright 1990-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $
 
  setup(block);
 
%endfunction
 
function setup(block)
 
  block.NumDialogPrms  = 1;
 
  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 1;
 
  %% Setup functional port properties to dynamically
  %% inherited.
  %block.SetPreCompInpPortInfoToInherited;
  %block.SetPreCompOutPortInfoToInherited;
 
  block.InputPort(1).Dimensions        = 1;
  block.InputPort(1).DirectFeedthrough = false;
 
  block.OutputPort(1).Dimensions       = 6;  % (6  Before) one Object: (x,y,z, yaw, pitch, roll)
  %block.OutputPort(1).Dimensions       = 3;
 
  %% Set block sample time to [0.01 0]
  block.SampleTimes = [0.01 0];
 %%%%%%%%%%%%%%%%%%%%%%%%%% Changed from 0.01 to 0.02 %%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';
 
  %% Register methods
  block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
  block.RegBlockMethod('InitializeConditions',    @InitConditions); 
  block.RegBlockMethod('Outputs',                 @Output); 
  block.RegBlockMethod('Update',                  @Update);
  block.RegBlockMethod('Terminate',               @Terminate);
 
 
%endfunction
 
function DoPostPropSetup(block)
 
  %% Setup Dwork
  block.NumDworks = 1;
  block.Dwork(1).Name = 'x0';
  block.Dwork(1).Dimensions      = 1;
  block.Dwork(1).DatatypeID      = 0;
  block.Dwork(1).Complexity      = 'Real';
  block.Dwork(1).UsedAsDiscState = true;
 
%endfunction
 
function InitConditions(block)
 
  %% Initialize Dwork
  block.Dwork(1).Data = block.DialogPrm(1).Data;
 
 display('NatNet Sample Begin')
    global theClient;
    global frameRate;
    lastFrameTime = -1.0;
    lastFrameID = -1.0;
    usePollingLoop = false;         % approach 1 : poll for mocap data in a tight loop using GetLastFrameOfData
    usePollingTimer = false;        % approach 2 : poll using a Matlab timer callback ( better for UI based apps )
    useFrameReadyEvent = true;      % approach 3 : use event callback from NatNet (no polling)
  %  useUI = true;
 
  %  persistent arr;
    % Open figure
  %  if(useUI)
  %      hFigure = figure('Name','OptiTrack NatNet Matlab Sample','NumberTitle','off');
  %  end
 
   % try
        % Add NatNet .NET assembly so that Matlab can access its methods, delegates, etc.
        % Note : The NatNetML.DLL assembly depends on NatNet.dll, so make sure they
        % are both in the same folder and/or path if you move them.
        display('[NatNet] Creating Client.')
        % TODO : update the path to your NatNetML.DLL file here :
	%%%%%%%%%%%%%%%%% CHANGED HERE %%%%%%%%%%%%%%%%%%%
        %dllPath = fullfile('c:','NatNetSDK2.5','Samples','bin','NatNetML.dll');
        dllPath = fullfile('D:','NatNetSDK','lib','x64','NatNetML.dll');
        %dllPath = fullfile('c:','NaturalPoint Trackd Module','naturalpointtracker.dll');
        dllPath = 'D:\NatNetSDK\lib\x64\NatNetML.dll';
        assemblyInfo = NET.addAssembly(dllPath);
 
        % Create an instance of a NatNet client
        theClient = NatNetML.NatNetClientML(0); % Input = iConnectionType: 0 = Multicast, 1 = Unicast
        version = theClient.NatNetVersion();
        fprintf( '[NatNet] Client Version : %d.%d.%d.%d\n', version(1), version(2), version(3), version(4) );
 
        % Connect to an OptiTrack server (e.g. Motive)
        display('[NatNet] Connecting to OptiTrack Server.')
        hst = java.net.InetAddress.getLocalHost;
        
        
        %%%%%%%%%%%%%%%%% CHANGED HERE %%%%%%%%%%%%%%%%%%%
        %HostIP = char(hst.getHostAddress);
        HostIP = char('127.0.0.1');
        %HostIP = char('0.0.0.0');%Get IP
        flg = theClient.Initialize(HostIP, HostIP); % Flg = returnCode: 0 = Success
        if (flg == 0)
            display('[NatNet] Initialization Succeeded')
        else
            display('[NatNet] Initialization Failed')
        end
       
        % print out a list of the active tracking Models in Motive
        GetDataDescriptions(theClient)
       
        % Test - send command/request to Motive
        [byteArray, retCode] = theClient.SendMessageAndWait('FrameRate');
        if(retCode ==0)
            byteArray = uint8(byteArray);
            frameRate = typecast(byteArray,'single');
        end
    %catch
 
%endfunction
 
    function Output(block)
       
        %block.OutputPort(1).Data = block.Dwork(1).Data;
        global theClient;
        java.lang.Thread.sleep(5);
        
        data = theClient.GetLastFrameOfData();
        D=ProcessFrame(data);
        %block.OutputPort(1).Data=double([D.x1;D.y1;D.z1]);
       % block.OutputPort(2).Data=double([D.x2;D.y2;D.z2]);
        block.OutputPort(1).Data=double([D.x1;D.y1;D.z1;D.angleX;D.angleY;D.angleZ]);
        %frameTime = data.fLatency;
        %frameID = data.iFrame;
        %                     if(frameTime ~= lastFrameTime)
        %                         fprintf('FrameTime: %0.3f\tFrameID: %5d\n',frameTime, frameID);
        %                         lastFrameTime = frameTime;
        %                         lastFrameID = frameID;
        %                     else
        %                         display('Duplicate frame');
        %                     end
       
 
%endfunction
 
        function Update(block)
           
            block.Dwork(1).Data = block.InputPort(1).Data;
 
 function Terminate(block)
      global theClient;
      theClient.Uninitialize();
     display('NatNet Sample End')
   
 
%endfunction
 
      function [D] = ProcessFrame( frameOfData )
         
          rigidBody1Data = frameOfData.RigidBodies(1);
          %rigidBody2Data = frameOfData.RigidBodies(2);
          % Position
         
          % Test : Marker Y Position Data
          %angleY = data.LabeledMarkers(1).y;
         
          % Test : Rigid Body Y Position Data
          D.x1= rigidBody1Data.x; %*1000
          D.y1= rigidBody1Data.y;
          D.z1= rigidBody1Data.z;
          %disp(D.x1)
         
         % D.x2= rigidBody2Data.x; %*1000
          % D.y2= rigidBody2Data.y;
          % D.z2= rigidBody2Data.z;
          % disp(D.x2)
         
          % Test : Rigid Body 'Yaw'
          % Note : Motive display euler's is X (Pitch), Y (Yaw), Z (Roll), Right-Handed (RHS), Relative Axes
          % so we decode eulers heres to match that.
         
          %Angles
%           
           q = quaternion( rigidBody1Data.qy,rigidBody1Data.qx, rigidBody1Data.qz, rigidBody1Data.qw );
           %q2 = quaternion( rigidBody2Data.qy,rigidBody1Data.qx, rigidBody1Data.qz, rigidBody1Data.qw );
           qRot = quaternion( 0, 0, 0, 1);     % rotate pitch 180 to avoid 180/-180 flip for nicer graphing
           q = mtimes(q, qRot);
           angles = EulerAngles(q,'zyx');
           D.angleX = -angles(1) * 180.0 / pi;   % must invert due to 180 flip above
           D.angleY = angles(2) * 180.0 / pi;
           D.angleZ = -angles(3) * 180.0 / pi;   % must invert due to 180 flip above
      %end function
      