%% Convergencia %%

function res = convergence(P)

    if all(P(:,:)==P(1,:))
       res = 1;
    else
        res = 0;
    end

end