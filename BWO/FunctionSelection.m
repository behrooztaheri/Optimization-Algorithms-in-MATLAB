
% This file includes the implementation of Sphere benchmark function
% (Function 16 from Table 1)
% lb refers to the lower bound
% ub refers to the uppper bound
% dim refers to the number of variables 

function [lb,ub,dim,func] = FunctionSelection(F)


switch F
    case 'F1'
        func = @F1;
        lb=-100;
        ub=100;
        dim=10;   
               
end

end

% F1

function o = F1(x)
o=sum(x.^2);
end

