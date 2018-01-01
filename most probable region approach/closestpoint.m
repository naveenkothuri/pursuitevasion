function I= closestpoint(solx,soly,xt,yt)
if(size(solx,1)==2)
X1 = [double(solx(1,1)),double(soly(1,1));xt,yt];
 d1 = pdist(X1,'euclidean');
X2 = [double(solx(2,1)),double(soly(2,1));xt,yt];
d2 = pdist(X2,'euclidean');
d=min(d1,d2);
if (d==d1)
    solxm=(solx(1,1));
    solym=(soly(1,1));
elseif(d==d2)
    solxm=(solx(2,1));
    solym=(soly(2,1));
end

elseif(size(solx,1)==1)
    solxm=solx;
    solym=soly;
end

I=[solxm;solym];