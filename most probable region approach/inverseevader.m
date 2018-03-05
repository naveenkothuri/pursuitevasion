
function E = inverseevader(tx,ty,xI,yI,xp,yp,k)
        M=(ty-yI)/(tx-xI);
h=0;
%%
recm=double(sqrt(k^2*((xp-xI)^2+(yp-yI)^2)));

%{
bby2=(-((1+M^2)*xI+M*k^2*((yI-yp)-M*(xI-xp)))/(1+M^2));
c=(-((sqrt(k^2*((xp-xI)^2+(yp-yI)^2)))^2-((yI-yp)-M*(xI-xp))^2*k^4-2*M*xI*((yI-yp)-M*(xI-xp))*k^2-xI^2*(1+M^2))/(1+M^2));
Efx=(-(-((1+M^2)*xI+M*k^2*((yI-yp)-M*(xI-xp)))/(1+M^2))+sign(xI-tx)*sqrt((-((1+M^2)*xI+M*k^2*((yI-yp)-M*(xI-xp)))/(1+M^2))^2-(-((sqrt(k^2*((xp-xI)^2+(yp-yI)^2)))^2-((yI-yp)-M*(xI-xp))^2*k^4-2*M*xI*((yI-yp)-M*(xI-xp))*k^2-xI^2*(1+M^2))/(1+M^2))))
Efy=(M*(-(-((1+M^2)*xI+M*k^2*((yI-yp)-M*(xI-xp)))/(1+M^2))+sign(xI-tx)*sqrt((-((1+M^2)*xI+M*k^2*((yI-yp)-M*(xI-xp)))/(1+M^2))^2-(-((sqrt(k^2*((xp-xI)^2+(yp-yI)^2)))^2-((yI-yp)-M*(xI-xp))^2*k^4-2*M*xI*((yI-yp)-M*(xI-xp))*k^2-xI^2*(1+M^2))/(1+M^2))))+((yI)-M*(xI))*(1-k^2)+(yp-M*xp)*k^2)
%}
syms x y
[xe ye]=solve((x-xI)^2+(y-yI)^2==recm^2,(M*x-y)==-(((yp-ty)-M*(xp-tx))*k^2+ty-M*tx));%this is from reverse approach
ev=double([xe ye]);
E1=[ev(1,1);ev(1,2)];
E2=[ev(2,1);ev(2,2)];
I1=mapkal(tx,ty,E1(1),E1(2),xp,yp,k);
I2=mapkal(tx,ty,E2(1),E2(2),xp,yp,k);
if(abs(I1(1)-xI)<0.01)
    E=[E1(1);E1(2)];
    h=1;
end
if(abs(I2(1)-xI)<0.01)
    E=[E2(1);E2(2)];
    h=h+1;
end
syms x y 
X1 = [double(E1(1)),double(E1(2));tx,ty];
 d1 = pdist(X1,'euclidean');
X2 = [double(E2(1)),double(E2(2));tx,ty];
d2 = pdist(X2,'euclidean');
d=max(d1,d2);
if(h==1)
    E=E;
else
    if(d==d1)
        E=E1;
    else
        E=E2;
    end
end

end