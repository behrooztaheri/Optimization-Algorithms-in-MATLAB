clc ;
clear ;
close all ;

%% (1): Problem Definition 
CostFunction = @(x) Sphere(x) ; % Objective Function
nVar = 3 ; % Number of Unknown Variables
VarMin = -100 ; % Lower Band
VarMax = +100 ; % Upper Band
MaxIt = 100 ; % Maximum Number of Iteration
nPop = 20 ; % Population Size 

%% (2): Initialization
empty_HHO.Position = [] ;
empty_HHO.Cost = [] ;
HHo = repmat(empty_HHO , nPop,1) ;
Rabbit = empty_HHO ;
Rabbit_Energy = inf ;

for i = 1:nPop
   % Initialization Position
   HHo(i).Position = unifrnd(VarMin,VarMax,[1,nVar]) ;
   
   % Evaluation
   HHo(i).Cost = CostFunction(HHo(i).Position) ;
   
   % Update the Location of Rabbit
   if HHo(i).Cost<Rabbit_Energy
       Rabbit_Energy = HHo(i).Cost ;
       Rabbit = HHo(i) ;
   end
    
end

NFE = 0 ;
BestCost = zeros(MaxIt,1) ;

%% (3): HHO Main Loop

for it = 1:MaxIt
    E1 = 2*(1-(it/MaxIt)) ;
    
    for i = 1:nPop
        E0 = 2*rand()-1 ;
        E = E1*E0 ;
       
        if abs(E)>=1
            %% Exploration Phase
            q = rand () ;
            rand_index = floor(nPop.*rand()+1) ;
            X_rand = HHo(rand_index).Position ;
            
            if q<0.5
                AA = 0 ;
                for jj = 1:nPop
                    AA = AA+HHo(jj).Position ;
                end
                MeanX = AA/nPop ;
                HHo(i).Position = (Rabbit.Position-MeanX)-rand([1,nVar]).*((VarMax-VarMin).*rand([1,nVar])+VarMin) ;
                
            elseif q>=0.5
                HHo(i).Position = X_rand - rand([1,nVar]).*abs(X_rand-2.*rand([1,nVar]).*HHo(i).Position) ;
                
            end
           
        elseif abs(E)<1
            %% Exploitation Phase
            %% (1): Soft Besiege
            r = rand() ;
            if r>=0.5 && abs(E)>=0.5
                J = 2.*(1-rand([1,nVar])) ;
                HHo(i).Position = (Rabbit.Position-HHo(i).Position)-E.*abs(J.*Rabbit.Position-HHo(i).Position) ; 
                
            end
            
            %% (2): Hard Besiege
            
            if r>=0.5 && abs(E)<0.5
                HHo(i).Position = (Rabbit.Position)-E.*abs(Rabbit.Position-HHo(i).Position) ;
                
            end
            
            %% (3): Soft Besiege with Progressive Rapid Dives
            if r<0.5 && abs(E)>=0.5
                J = 2.*(1-rand([1,nVar])) ;
                Y = Rabbit.Position-E.*abs((J.*Rabbit.Position)-(HHo(i).Position)) ;
                Z = Y+rand([1,nVar]).*Levy([1,nVar]) ;
                
                CostY = CostFunction(Y) ;
                CostZ = CostFunction(Z) ;
                
                if CostY<HHo(i).Cost
                    HHo(i).Position = Y ;
                end
                
                if CostZ<HHo(i).Cost
                    HHo(i).Position = Z ;
                end
                
            end
            
            %% (4): Hard Besiege with Progressive Rapid Dives
            if r<0.5 && abs(E)<0.5
                J = 2.*(1-rand([1,nVar])) ;
                
                AA = 0 ;
                for jj = 1:nPop
                    AA = AA+HHo(jj).Position ;
                end
                MeanX = AA/nPop ;
                
                Y = Rabbit.Position-E.*abs((J.*Rabbit.Position)-(MeanX)) ;
                Z = Y+rand([1,nVar]).*Levy([1,nVar]) ;
                
                CostY = CostFunction(Y) ;
                CostZ = CostFunction(Z) ;
                
                if CostY<HHo(i).Cost
                    HHo(i).Position = Y ;
                end
                
                if CostZ<HHo(i).Cost
                    HHo(i).Position = Z ;
                end
                
            end
            
        end
    end
    
    %% Check Boundary and Update Final Position
    HHo(i).Position(HHo(i).Position>VarMax) = VarMax ;
    HHo(i).Position(HHo(i).Position<VarMin) = VarMin ;
    HHo(i).Cost = CostFunction(HHo(i).Position) ;
    
    % Update the Location of Rabbit
   if HHo(i).Cost<Rabbit_Energy
       Rabbit_Energy = HHo(i).Cost ;
       Rabbit = HHo(i) ;
   end
   
   NFE = NFE+nPop ;
   BestCost(it) = Rabbit_Energy ;
   disp(['Iteration:',num2str(it),':NFE=',num2str(NFE)...
       ',BestCost=',num2str(BestCost(it))]) ;
end

%% (4): Display

figure ;
plot(1:MaxIt,BestCost,'Linewidth',2)
xlabel('Iteration')
ylabel('Best Cost')
title('Optiomization Trend by HHO')