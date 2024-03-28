%_________________________________________________________________________%
%  Dingo Optimization Algorithm (DOA) source code                         %
%                                                                         %
%  Developed in MATLAB 9.4.0.813654 (R2018a)                              %
%                                                                         %
%  Author: Dr. Hernan Peraza-Vazquez                                      %
%          MTA. Gustavo Echavarria-Castillo                               %
%                                                                         %
%  e-mail:  hperaza@ipn.mx        gechavarriac1700@alumno.ipn.mx          %
%                                                                         %
%  Programmer:  Dr. Hernan Peraza-Vazquez                                 %
%  Main paper:                                                            %
%  A Bio-Inspired Method for Engineering Design Optimization Inspired by  %
%  Dingoes Hunting Strategies.                                            %
%  Mathematical Problems in Engineering. (2021). Hindawi.                 %                                                      %
%  DOI:   doi.org/10.1155/2021/9107547                                    %
%_________________________________________________________________________%
clc;
clear
close all;

SearchAgents_no=100; % number of dingoes
Function_name='F7'; % Name of the test function. From F1 to F23 (Table 2,3,4 in the paper)
Max_iteration=500; % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[vMin,theBestVct,Convergence_curve]=DOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[gwo_vMin,gwo_theBestVct,gwo_Convergence_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[pso_vMin,pso_theBestVct,pso_Convergence_curve]=PSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

display(['The best solution obtained by DOA is : ', num2str(theBestVct)]);
display(['The best optimal value of the objective function found by DOA is : ', num2str(vMin)]);

semilogy(0:Max_iteration,Convergence_curve,'color','r','linewidth',1.5);
hold on
semilogy(1:Max_iteration,gwo_Convergence_curve,'color','b','linewidth',1.5);
semilogy(1:Max_iteration,pso_Convergence_curve,'color','k','linewidth',1.5);

title('Convergence curve');
xlabel('Iteration#');
ylabel('Best fitness function');
legend('DOA','GWO','PSO')



