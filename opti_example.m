clear
close all
%%
N=50;
maxzprob = optimproblem;
x= optimvar('x',2,'Type','integer','LowerBound',[1,1],'UpperBound',[N,N]);
showbounds(x)
cost=(x(1)-20.3).^2+(x(2)-30.3)^2; % demo cost function
maxzprob.Objective = cost;
%%
[sol,fval] = solve(maxzprob);
sol.x