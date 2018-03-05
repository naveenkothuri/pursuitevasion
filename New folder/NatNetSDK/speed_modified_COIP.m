function t2 = speed_modified_COIP( op,oe,ot,k1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    tic
    pe=oe-op;
    pt=ot-op;
    theta=atan2(pe(2),pe(1))-atan2(pt(2),pt(1));
    k0=(norm(pt))/(norm(pe));

    k2=k0*(1-(k1^2));
    a=k2*cos(theta);
    b=(k2*k2);
    k3=b-(2*a)+1;
    angle_phi2=asin(k1*sqrt((b-(a^2))/(k3*((k1*k1)-(2*k1*abs(a-1)/sqrt(k3))+1))));
    t2=toc;
end

