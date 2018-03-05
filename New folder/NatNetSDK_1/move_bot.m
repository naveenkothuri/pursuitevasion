function move_bot((x2,y2))
x1,y1 = TODO
distance = sqrt((x2-x1)^2 + (y2-y1)^2);
while distance > 5
    mymotor1.Speed=20;
    mymotor2.Speed=20;
    start(mymotor1);
    start(mymotor2);
    distance = sqrt((x2-x1)^2 + (y2-y1)^2);
    x1,y1 = TODO
end