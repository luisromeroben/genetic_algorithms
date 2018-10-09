%% Seleccionar dos individuos de la anterior generacion, para el cruce (probabilidad de seleccion proporcional a la funcion de evaluacion del individuo) %%

function inds = selind(P,eval,Mp,Np)

    eval_sc = eval/(max(eval));% + min(eval));

    [Y,I] = sort(eval_sc,'descend');
%     Y
    inds = zeros(2,Np);
    P_ordered = P(I,:);
    ns = 0;    
    
    for i=1:Mp
        r = rand;
        if Y(i)>r && ns < 2
            inds(ns+1,:) = P_ordered(i,:);
            ns = ns + 1;
        end
    end

end