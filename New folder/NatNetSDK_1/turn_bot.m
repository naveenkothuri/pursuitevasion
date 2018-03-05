function turn_bot(tyaw)
%cyaw = TODO
error = tyaw - cyaw
while abs(error) > 10
    if tyaw < 0
        mymotor1.Speed=20;
        start(mymotor1)
    else
        mymotor2.Speed=20;
        start(mymotor2);
    end
    cyaw = TODO
    error = tyaw - cyaw
end
    
    