op=[2 3];
oe=[7 7];
ot=[3 5];
e=1;p=2;
t1 = zeros(1,100);


for i=1:100
    tic
    pe=oe-op;
    pt=ot-op;
    pc=(1/(1-((e^2)/(p^2))))*pe;
    r=(e/p)*norm(pc);
    ct=pt-pc;
    ci=(r/norm(ct))*ct;
    pi=pc+ci;
    pi=[pi 0];
    pc=[pc 0];
    angle_phi=atan2(norm(cross(pi,pc)),dot(pi,pc));
    t1(i)=toc;
    
    op=op+[0.1 0.1];
    oe=oe+[0.1 0.1];
end

