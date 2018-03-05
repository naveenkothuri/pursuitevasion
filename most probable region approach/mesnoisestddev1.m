function sigma = mesnoisestddev1(prob,Ix,Iy)
%
%fun=@(x)((prob-(1/(2*pi*x(1)*x(2)*sqrt(1-x(5)^2)))*(exp(-((Ix-x(3)).^2./(2*x(1)^2))-((Iy-x(4)).^2./(2*x(2)^2)))))*transpose(prob-(1/(2*pi*x(1)*x(2)*sqrt(1-x(5)^2)))*(exp(-((Ix-x(3)).^2/(2*x(1)^2))-((Iy-x(4)).^2/(2*x(2)^2))))));

%d=(prob-(1/(2*pi*x(1)*x(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*x(1)^2))-((Ix-Ix(maxindex)).^2./(2*x(2)^2)))));
%fun1=@(x)(prob-(1/(2*pi*x(1)*x(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*x(1)^2))-((Iy-Iy(maxindex)).^2./(2*x(2)^2)))))
fun=@(x)((prob-(1/(2*pi*x(1)*x(2)*sqrt(1-x(5)^2)))*(exp((1/(2*(1-x(5)^2)))*((2*x(5)*(Ix-x(3)).*(Iy-x(4))/(x(1)*x(2)))-((Ix-x(3)).^2./(x(1)^2))-((Iy-x(4)).^2./(x(2)^2))))))*transpose(prob-(1/(2*pi*x(1)*x(2)*sqrt(1-x(5)^2)))*(exp((1/(2*(1-x(5)^2)))*((2*x(5)*(Ix-x(3)).*(Iy-x(4))/(x(1)*x(2)))-((Ix-x(3)).^2/(x(1)^2))-((Iy-x(4)).^2/(x(2)^2)))))));
x0=[1 10 Ix(11),Iy(11) 0.5];
A=[1 2 0 0 0];
B=1000;
Aeq=[];
beq=[];
sigma = fmincon(fun,x0,A,B,Aeq,beq);
%{
mux=sigma(3);muy=sigma(4);
ro=sigma(5);

x=min(Ix):max(Ix);
y=min(Iy):max(Iy);
[X,Y]=meshgrid(x,y);
p=(1/(2*pi*sigma(1)*sigma(2)*sqrt(1-ro^2)))*(exp((1/(2*(1-ro^2)))*((2*ro*(X-mux).*(Y-muy)/(sigma(1)*sigma(2)))-((X-mux).^2./(sigma(1)^2))-((Y-muy).^2./(sigma(2)^2)))));
surf(X,Y,p)

hold on
%probability=(1/(2*pi*sigma(1)*sigma(2)))*(exp(-((Ix-Ix(maxindex)).^2./(2*sigma(1)^2))-((Iy-Iy(maxindex)).^2./(2*sigma(2)^2))));
plot3(Ix,Iy,prob,'*')
%
fitprob=(1/(2*pi*sigma(1)*sigma(2)*sqrt(1-ro^2)))*(exp((1/(2*(1-ro^2)))*((2*ro*(Ix-mux).*(Iy-muy)/(sigma(1)*sigma(2)))-((Ix-mux).^2./(sigma(1)^2))-((Iy-muy).^2./(sigma(2)^2)))));
r=0;
for i=1:size(prob,1)
    r=r+(fitprob(i)-prob(i))^2;
end
r=sqrt(r/size(prob,1))
%}