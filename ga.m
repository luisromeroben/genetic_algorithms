%% Genetic algorithm %%

% BEGIN /* Algoritmo Genetico Simple */
%   Generar una poblacion inicial.
%   Computar la funcion de evaluacion de cada individuo.
%   WHILE NOT Terminado DO
%   BEGIN /* Producir nueva generacion */
%       FOR Tama~no poblacion/2 DO
%       BEGIN /*Ciclo Reproductivo */
%           Seleccionar dos individuos de la anterior generacion,
%           para el cruce (probabilidad de seleccion proporcional
%           a la funcion de evaluacion del individuo).
%           Cruzar con cierta probabilidad los dos
%           individuos obteniendo dos descendientes.
%           Mutar los dos descendientes con cierta probabilidad.
%           Computar la funcion de evaluacion de los dos
%           descendientes mutados.
%           Insertar los dos descendientes mutados en la nueva generacion.
%       END
%       IF la poblacion ha convergido THEN
%           Terminado := TRUE
%   END
% END

clear all;clc

%% Generar población inicial %%

N = 30; % número de individuos

% parameters of the equation = [a b c ...]
target = [1 2 4]; 
lt = length(target);
maxi = 11;

x = -2:0.1:2;
M = length(x);

y = 0;
for i=1:lt
    y = y + target(end-(i-1))*x.^(i-1);% objetivo
end

% y = x;
% lt = 3;
% y = target(1)*x.^2 + target(2)*x + target(3);
times  = 0; % numero de convergencias consecutivas

P = [];
for i=1:N
    P = [P;randi(maxi,lt,1)'];%randi(maxi,1)-1 randi(maxi,1)-1 randi(maxi,1)-1]; % población inicial
end

[Mp,Np] = size(P);

%% Computar la funcion de evaluacion de cada individuo %%

eval = evalind(P,y,x,N,lt)

%% WHILE NOT Terminado DO %%

terminated = 0;
cont = 1;
% P
% eval

while ~terminated
    
    plot(x,y,'r*-');hold on
    for i=1:N
        y_x = 0;
        for j=1:lt
            y_x = y_x + P(i,end-(j-1))*x.^(j-1);% objetivo
        end
        plot(x,y_x,'*-');
    end
    hold off
    
    press = 0;
    while press == 0
       press = waitforbuttonpress;
    end
    press = 0;
    
    for i=1:N/2
        
        % Seleccionar dos individuos de la anterior generacion, para el
        % cruce (probabilidad de seleccion proporcional a la funcion de
        % evaluacion del individuo)
        %disp('INDS');
        inds = selind(P,eval,Mp,Np);
        
        % Cruzar con cierta probabilidad los dos
        % individuos obteniendo dos descendientes
        
        range = 10;
        r1 = rand*range;
        r2 = range-r1;%rand*range;
        %disp('NEW IND');
        for j=1:Np
            new_ind(1,j) = (r1*inds(1,j)+r2*inds(2,j))/(r1+r2);
        end
        % Mutar los dos descendientes con cierta probabilidad.
        
        %[Y,~] = sort(eval,'descend');
        pmut = 0.2;
        if convergence(P)
            cont = cont + 0.1;
            pmut = pmut+0.1;
        end
        r3 = rand;
        if r3<(pmut)
            disp('*********MUT************');
            for k=1:Np
                new_ind(1,k) = new_ind(1,k)+((1-2*rand)/cont);
            end
        end
        
        % Computar la funcion de evaluacion de los dos
        % descendientes mutados.
        
        %disp('EVAL NEW IND');
        eval_new_ind = evalind(new_ind,y,x,1,lt);
        
        % Insertar los dos descendientes mutados en la nueva generacion.
        
        %disp('INSERT');
        P = [P;new_ind];
        eval = [eval;eval_new_ind];
        
        [eval,I] = sort(eval,'descend');
        P = P(I,:);
        
        %disp('DELETE');
        P = P(1:length(eval)-1,:);
        eval = eval(1:length(P),:)
        
    end
    
    % IF la poblacion ha convergido THEN -> Terminado := TRUE
    
    if convergence2(eval)
       if times > 10
            terminated = 1;
       end
       times = times + 1;
    else
        times = 0;
    end
    
end

