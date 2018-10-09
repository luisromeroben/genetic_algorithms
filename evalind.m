% Función de evaluación %

function eval = evalind(P,y,x,N,lt)

for i=1:N
    %y_x(i,:) = P(i,1)*x.^2 + P(i,2)*x + P(i,3);
    y_x = 0;
    for j=1:lt
        y_x = y_x + P(i,end-(j-1))*x.^(j-1);% objetivo
    end
    err = abs(y-y_x);
    eval(i,:) = 1/sum(err);
end

end