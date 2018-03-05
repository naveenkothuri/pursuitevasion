function t1 = speed_COIP( op,oe,ot,k1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    a=(1/(1-(k1^2)));
    tic
    pe=oe-op;
    pt=ot-op;
    pc=a*pe;
    r=k1*norm(pc);
    ct=pt-pc;
    ci=(r/norm(ct))*ct;
    pi=pc+ci;
    pi=[pi 0];
    pc=[pc 0];
    angle_phi=atan2(norm(cross(pi,pc)),dot(pi,pc));
    t1=toc;
end

