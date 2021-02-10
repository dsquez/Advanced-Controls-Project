function x = dthetadzeta(zeta,params)

lambda_1 = params.lambda_1;
lambda_2 = params.lambda_2;

u = (zeta^2 + lambda_1^2 - lambda_2^2)/(2*lambda_1*zeta);

du = ((2*lambda_1*zeta)*(2*zeta) ...
    - (zeta^2 + lambda_1^2 - lambda_2^2)*(2*lambda_1))...
    / (2*lambda_1*zeta)^2;

x = du/sqrt(1-u^2);

end

