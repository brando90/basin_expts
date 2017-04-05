function [ f ] = high_D_pyramid( x,c,apex, lb,ub )
% gives the surface height for a hyper-cubed base pyramid
% x_hat in R^D, [c_hat,c_(D+1)=apex] = [c_hat,f] in R^D
%% if x is not in the hypercube, then return 0
%cube = @(x) ~prod( (ub>=x)&&(x>lb) );
inside_base_hypercube = ~prod( (ub>=x).*(x>lb) );
if inside_base_hypercube
    f = 0;
    return
else
    %% get T
%     D = length(x);
%     plus = zeros(1,D);
%     minus = zeros(1,D);
%     for d=1:D
%         % solve for t, c_i + t(x_i - c_i) = +-1
%         t_p = (ub - c(d))/(x(d) - c(d));
%         t_m = (-lb - c(d))/(x(d) - c(d));
%         %
%         plus(d) = t_p;
%         minus(d) = t_m;
%     end
    plus = (ub - c)./(x - c);
    minus = (-lb - c)./(x - c);
    t_solns = [plus, minus];
    %% get the smallest *positive* solution
    t_solns( t_solns < 0 ) = inf;
    T = min(t_solns);
    %% x_(n+1) = (1 - 1/T) c_(n+1)
    f = (1 - 1/T)*apex;
end

