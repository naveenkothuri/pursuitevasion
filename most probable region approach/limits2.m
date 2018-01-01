function T = limits2(a,b,c)
N=800;
z=zeros(N,1);
zc=z;
%{
if(a<0)
    a=a+2*pi;
end
if(b<=0)
    b=b+2*pi;
end
for i=1:size(c,2)
    if(c(i)<0)
     c(i)=c(i)+2*pi;
    end
end
%}
p=round(a*(N/2)/pi);
q=round(b*(N/2)/pi);
if(p>q)
    q=q+N;
end
for i=p:q
     if(i<=0)
      z(i+N)=1;
     elseif(i>N)
        z(i-N)=1;
     else
         z(i)=1;
    end
end
T=1;
for i=1:2:size(c,2)

pc=round(c(i)*(N/2)/pi);
qc=round(c(i+1)*(N/2)/pi);
if(pc>qc)
qc=qc+N;
end
zc=zeros(N,1);
for j=pc:qc
    if(j<=0)
      zc(j+N)=1;
    elseif(j>N)
        zc(j-N)=1;
    
    else
        zc(j)=1;
    end
end
T1(1)=0;
T2(1)=0;
zsum=0;
zsum=z+zc;
    if(zsum(1)==2)
      T1(end+1)=1;
    end  
for k=2:size(zsum,1)
    if(((zsum(k)-zsum(k-1))==2)||((((zsum(k)-zsum(k-1))==1))&&zsum(k)==2))
        T1(end+1)=k;
    end
    if(((zsum(k-1)-zsum(k))==2)||((((zsum(k-1)-zsum(k))==1))&&zsum(k-1)==2))
        T2(end+1)=k;
    end
end
if(zsum(N)==2)
    T2(end+1)=N;
end
T1=T1(2:end);
T2=T2(2:end);
for l=1:size(T1,2)
    T=[T T1(l) T2(l)];
end
if(i==1)
T=T(2:end);
end
end

T=T*pi/(N/2);
for i=1:size(T,2)
    if(T(i)>pi)
        T(i)=T(i)-2*pi;
    end
end