op=[2 3];
oe=[7 7];
ot=[3 5];
e=1;p=2;
k1=e/p;
t1 = zeros(1,100);
t2 = zeros(1,100);

for i=1:100
    tic
    speed_first_algo;
    t1(i)=toc;
    
    tic
    speed_second_algo;
    t2(i)=toc;
    
    op=op+[0.1 0.1];
    oe=oe+[0.1 0.1];
end

plot(t1)
hold
plot(t2,'r')


