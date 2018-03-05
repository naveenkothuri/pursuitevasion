function sigma = mesnoisestddev(prob,Ix,Iy,maxindex)
%

%d=(prob-(1/(2*pi*x(1)*x(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*x(1)^2))-((Ix-Ix(maxindex)).^2./(2*x(2)^2)))));
%fun1=@(x)(prob-(1/(2*pi*x(1)*x(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*x(1)^2))-((Iy-Iy(maxindex)).^2./(2*x(2)^2)))))
fun=@(x)((prob-(1/(2*pi*x(1)*x(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*x(1)^2))-((Iy-Iy(maxindex)).^2./(2*x(2)^2)))))*transpose(prob-(1/(2*pi*x(1)*x(2)))*(exp(-((Ix-Ix(maxindex)).^2/(2*x(1)^2))-((Iy-Iy(maxindex)).^2/(2*x(2)^2))))));
x0=[1 10];
A=[1 2];
B=1000;
Aeq=[];
beq=[];
sigma = fmincon(fun,x0,A,B,Aeq,beq);
%{
x=min(Ix):max(Ix);
y=min(Iy):max(Iy);
[X,Y]=meshgrid(x,y);
p=(1/(2*pi*sigma(1)*sigma(2)))*(exp(-((X-Ix(maxindex)).^2./(2*sigma(1)^2))-((Y-Iy(maxindex)).^2./(2*sigma(2)^2))));
surf(X,Y,p)


hold on
%probability=(1/(2*pi*sigma(1)*sigma(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*sigma(1)^2))-((Iy-Iy(maxindex)).^2./(2*sigma(2)^2))));
plot3(Ix,Iy,prob,'*')
fitprob=(1/(2*pi*sigma(1)*sigma(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*sigma(1)^2))-((Iy-Iy(maxindex)).^2./(2*sigma(2)^2))));
r=0;
for i=1:size(prob,1)
    r=r+(fitprob(i)-prob(i))^2;
end
r=sqrt(r/size(prob,1))
%}