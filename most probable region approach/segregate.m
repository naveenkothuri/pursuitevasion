function Lim=segregate(lim)
n=5;
liml=[];
limit=[];
Lim=[];
for j = 1:size(lim,2)
    if(lim(j)<0)
        lim(j)=lim(j)+2*pi;
    end
end
for j=1:2:size(lim,2)
    if(lim(j)>lim(j+1))
        lim(j+1)=lim(j+1)+2*pi;
    end
end
    
for i=0:1:n
    liml(end+1)=lim(j)+i*(lim(j+1)-lim(j))/n;   
end
%so each set i.e., lim (i) to lim(i+1) corresponds to n+1 elements of lim1
%example for n=10,  lim = 20 to 30 means 20 21 22 ....30 , total 11 elements
for i=1:2*size(liml,2)
    if(mod(i,2))
    limit(end+1)=liml(ceil(i/2));
    else
        limit(end+1)=limit(end);
    end
end
limit(1)=[];
limit(end)=[];
Lim=[Lim limit];
limit=[];
liml=[];

for i=1:size(Lim,2)
    if(Lim(i)>2*pi)
        Lim(i)=Lim(i)-2*pi;
    end
    if(Lim(i)>pi)
        Lim(i)=Lim(i)-2*pi;
    end
end
    

end

