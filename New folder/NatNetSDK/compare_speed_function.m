

time_1 = zeros(1,100);
time_2 = zeros(1,100);
for i=1:100
    
   time_1(i)=speed_COIP([2 3],[7 7],[3 5],0.5);
   time_2(i)=speed_modified_COIP([2 3],[7 7],[3 5],0.5);

end

plot(time_1)
hold
plot(time_2,'r')
