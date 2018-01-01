clear all
clc
%data has 100 points say. Here sampling rate is 0.1 i.e., glean 10 points
rng 'shuffle'
T=100;   % T is total no of data points available
d=10;
x=1:T;
f=7;                  %size of square will be (f-1)^2
res=1;     % resolution of the grid is 0.5 =1/res ,total no of points in a square is (f+(res-1)*(f-1)))^2
r=randn(T,1);
%load('r.mat')
y1=zeros(d,1);
x1=zeros(d,1);
y2=zeros((f+(res-1)*(f-1))*d,1);
x2=zeros((f+(res-1)*(f-1))*d,1);
for i=1:T
y(i)=3*x(i)+8*r(i)+1;
end
for i=1:d                            % sampling for the data., this depends on how fast we can gather data 
                                      % process data
    x1(i)=x((f-1)/2+(T/d)*(i-1));          % Here (f-1)/2 is point from which you want to start sampling
    y1(i)=y((f-1)/2+(T/d)*(i-1));
end
for i=1:d
    x4(i)=x1(i)-(f-1)/2;
    y4(i)=y1(i)-(f-1)/2;                  % size of square will be 7-by-7 i.e., -3 to 3
    for j=1:(f+(res-1)*(f-1))
        x2(j+(f+(res-1)*(f-1))*(i-1))= x4(i)+(j-1)/res;  % Resolution of sensor =2 as j=1,2,3,4,5,6,7
        y2(j+(f+(res-1)*(f-1))*(i-1))=y4(i)+(j-1)/res;
    end
end

C=cell(1,size(x1,1));
for i=1:d
    x3=x2((i-1)*(f+(res-1)*(f-1))+1:(f+(res-1)*(f-1))*i);
    for j=(i-1)*(f+(res-1)*(f-1))+1:(f+(res-1)*(f-1))*i
        y3=y2(j)*ones((f+(res-1)*(f-1)),1);
        plot(x3,y3,'*')
        if(j==(i-1)*(f+(res-1)*(f-1))+1)
            miny(i)=y2(j);
            maxy(i)=y2(j);
        end
        cell{i}=x3;
        if(miny(i)>y2(j))
        miny(i)=y2(j);
        end
         if(maxy(i)<y2(j))
        maxy(i)=y2(j);
        end
        hold on
    end
end
%{
for i=8:70
        coefficients = polyfit([x2(7), x2(7*ceil(i/7))], [y2(1), y2((7*ceil(i/7))-6)], 1);
        a1(ceil(i/7)-1) = coefficients (1);
        b1(ceil(i/7)-1) = coefficients (2);
end
for i=8:70
        coefficients = polyfit([x2(1), x2(7*ceil(i/7)-6)], [y2(7), y2(7*ceil(i/7))], 1);
        a2(ceil(i/7)-1) = coefficients (1);
        b2(ceil(i/7)-1) = coefficients (2);
end
Imax=find(a1 == max(a1(:)));
Imin=find(a2 == min(a2(:)));
%hold off
%figure

 plot(x2,(a1(Imax)*x2)+b1(Imax))
 hold on
 plot(x2,(a2(Imin)*x2)+b2(Imin))
 %}
t=1;
for i= 1:(f+(res-1)*(f-1))
    for j=1:(f+(res-1)*(f-1))
        for p=(f+(res-1)*(f-1))+1:2*(f+(res-1)*(f-1))           % each of first two squares will have f^2 points. Algorithm is draw (f^2)*(f^2) lines
                                    %between every two points and intersect %with consequent uncertainity regions and 
                                    %eliminate those lines which have no intersections 
            for q=(f+(res-1)*(f-1))+1:2*(f+(res-1)*(f-1))
        coefficients = polyfit([x2(i), x2(p)], [y2(j), y2(q)], 1);
        a1(t) = coefficients (1);
        b1(t) = coefficients (2);
        t=t+1;
            end
        end
    end
end
for k=3:d

   for j=1:size(a1,2)   
       c=cell{k};
       ym=a1(j)*c+b1(j);
       l=find(ym>miny(k)&ym<maxy(k));
       h=isempty(l);
       
       if(h)
           a1(j)=NaN;
           b1(j)=NaN;
       end
   end
              a1(isnan(a1)) = [];
           b1(isnan(b1)) = [];
end


for u=1:size(a1,2)
       plot(x2,(a1(u)*x2)+b1(u))
end

%% Given data we can have lines passing through them

% Now generate velocity values.

for i=1:d
    % ymin for a given block is (y1(i)-(f-1)/2) and max is (y1(i)+f+1)/2)
    ymin = y1(i)-(f-1)/2;
    ymax = y1(i)+(f+1)/2;
    c=cell{i};
    xmin = min(c);
    xmax = max(c);
    if (size(a1,2)>1)
    for t = 1:size(a1,2)
        clear h
      if (ymin<=(a1(t)*xmin+b1(t))&&(a1(t)*xmin+b1(t))<=ymax)
          px(t)=xmin;
          py(t)= (a1(t)*xmin+b1(t));
        h=0;
      elseif (xmin<=((ymin-b1(t))/a1(t))&&((ymin-b1(t))/a1(t))<=xmax)
          px(t)=((ymin-b1(t))/a1(t));
          py(t)=ymin;
        h=1;
      end
      if(ymin<=(a1(t)*xmax+b1(t))&&(a1(t)*xmax+b1(t))<=ymax)
          qx(t)=xmax; 
          qy(t)=(a1(t)*xmax+b1(t));
        
     h=0;
      elseif(xmin<=((ymax-b1(t))/a1(t))&&((ymax-b1(t))/a1(t))<=xmax)
          qy(t)=ymax;  
          qx(t) = ((ymax-b1(t))/a1(t));
        h=1; 
      end
      t
      h
      zx(i,t)=(px(t)+qx(t))/2;
      zy(i,t)=(px(t)+qx(t))/2;
    end
    end
end
for i=1:d-1
    for t=1:size(a1,2)
        X3= [zx(i+1,t),zy(i+1,t);zx(i,t),zy(i,t)];
        v(i,t) = pdist(X3,'euclidean')/d; 
    end
end
if(~isempty(a1))
figure
for i=1:16
subplot(4,4,i);
plot(1:d-1,v(:,i),'--')

end
end
 
