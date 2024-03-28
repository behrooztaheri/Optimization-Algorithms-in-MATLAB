% Particle Swarm Optimization
function [gBestScore,pos_pso,cg_curve] = PSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)

%PSO Infotmation

Vmax=6;
noP=SearchAgents_no;
w1=0.5+rand()/2;
c1=1.5;
c2=1.5;

% Initializations

iter=Max_iteration;
vel=zeros(noP,dim);
pBestScore=zeros(noP);
pBest=zeros(noP,dim);
gBest=zeros(1,dim);
cg_curve=zeros(1,iter);

% Random initialization for agents.
pos=initialization(noP,dim,ub,lb);
pos_pso=zeros(1,dim);
for i=1:noP
    pBestScore(i)=inf;
end

% Initialize gBestScore for a minimization problem
gBestScore=inf;


for loop=1:iter
    
    % Return back the particles that go beyond the boundaries of the search
    % space
    Flag4ub=pos(i,:)>ub;
    Flag4lb=pos(i,:)<lb;
    pos(i,:)=(pos(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
    
    for i=1:size(pos,1)
        %Calculate objective function for each particle
        fitness=fobj(pos(i,:));
        
        if(pBestScore(i)>fitness)
            pBestScore(i)=fitness;
            pBest(i,:)=pos(i,:);
        end
        if(gBestScore>fitness)
            gBestScore=fitness;
            gBest=pos(i,:);
        end
    end
    
    %Update the W of PSO
    w=w1;
    %Update the Velocity and Position of particles
    for i=1:size(pos,1)
        for j=1:size(pos,2)
            vel(i,j)=w*vel(i,j)+c1*rand()*(pBest(i,j)-pos(i,j))+c2*rand()*(gBest(j)-pos(i,j));
            
            if(vel(i,j)>Vmax)
                vel(i,j)=Vmax;
            end
            if(vel(i,j)<-Vmax)
                vel(i,j)=-Vmax;
            end
            pos(i,j)=pos(i,j)+vel(i,j);
            pos_pso=pos(i,:);
        end
    end
    cg_curve(loop)=gBestScore;
end

end