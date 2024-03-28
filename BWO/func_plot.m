
%%                                                                 %%
% Black Widow optimization  (BWO) source codes                      %
%                                                                   %
%  Developed in MATLAB R2015b                                       %
%                                                                   %
%  Author and programmer: Vahideh Hayyolalam                        %
%                                                                   %
%%                                                                

function func_plot(func_name)

[lb,ub,dim,func]=FunctionSelection(func_name);

switch func_name 
    case 'F1' 
        x=-100:2:100; y=x; 
end    

    
L=length(x);
f=[];

for i=1:L
    for j=1:L
            f(i,j)=func([x(i),y(j)]);
    
    end
end

surfc(x,y,f,'LineStyle','none');

end

