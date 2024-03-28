%%                                                                 %%
% Black Widow Optimization  (BWO) source codes                      %
%                                                                   %
%  Developed in MATLAB R2015b                                       %
%                                                                   %
%  Author and programmer: Vahideh Hayyolalam                        %
%                                                                   %
%%                                                                

% In order to use the algorithm for your optimization problem, just simply define your Fitness function in a new file and load its handle to func

%%
% Should you need further help or face any problem, please do not hesitate to contact me.
% My email address: p.hayyolalam@gmail.com

%%
% The initial parameters:

% Func = @CostFunction
% dim = number of variables
% MaxIter = maximum number of Iteration
% npop = number of population
% lb refers to the lower bound of variable 
% ub refers to the upper bound of variable 

%%
clear all 
clc

npop=40; % Number of population

FuncNo='F1'; % This parameter choses one of the benchmark functions from "FunctionSelection", but for your convenience there is only one function

MaxIter=500; % Maximum number of iterations

RepNo=1;
%% Load Fitness function

[lb,ub,dim,func]=FunctionSelection(FuncNo);

%% invoking BWO Function

[BestCostBw,BestRepBWO,BestOfAllBwo,meanBwo,medianBwo,WorstBwo,StdBwo]=BWOA(npop,MaxIter,lb,ub,dim,func,RepNo);

%% Ploting 

figure('Position',[500 500 660 290])
%Draw search space
subplot(1,2,1);
func_plot(FuncNo);
title('Sphere function')
xlabel('x_1');
ylabel('x_2');
zlabel([FuncNo,'( x_1 , x_2 )'])
grid off

%Draw objective space
subplot(1,2,2);
semilogy(BestCostBw,'Color','r')
title('Convergence curve')
xlabel('Iteration');
ylabel('Best value');

axis tight
grid off
box on
legend('BWO')


        



