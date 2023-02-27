function [xhat, q, p, d, dhat] = pred_coder(x, delta, p_size)

% Function skeleton for a predictive coder.
%
% [xhat, q, p, d, dhat] = pred_coder(x, a, delta)
%
% Input:
%  x      onedimensional signal to code
%  a      vector of predictor coefficients
%  delta  stepsize of uniform quantizer
%
% Output:
%  xhat   decoded signal (the coder always contains a decoder)
%  p      prediction
%  d      prediction error
%  dhat   reconstructed prediction error
%  q      quantized prediction error (typically an integer signal
%         suitable for source coding)


% Allocate variables
% All included for completeness. We really only need all xhat and q values,
% the other ones can be scalars in the code and are not needed as output
% variables
xhat = zeros(size(x));
d    = zeros(size(x));
dhat = zeros(size(x));
p    = zeros(size(x));
q    = zeros(size(x));

%Quantize
% q = round(x/delta);
% q(q>127) = 127;
% q(q<-128) = -128;
% xhat = q*delta;

%predictor size
i =p_size;
for k =1:i 
    P(k) = mean(x(1:end-k).*x(k+1:end));
end

for row = 1:i
    for col = 1:i
        k = abs(row-col);
        R(row,col) = mean(x(1:end-k).*x(k+1:end));
    end
end
a = R\P';


% Main loop
for k=1:length(x)
 if k < i
 p(k) = 0;
 end
if(k>i)
 for j=1:i
  p(k) = p(k)+ a(j).*xhat(k-j);
 end
end
                             % Prediction, should be a linear combination of old xhat values
  d(k) = x(k) - p(k);        % Prediction error
  q(k) = round(d(k)/delta);                  % Should be the quantization of the prediction error
  dhat(k) = q(k)*delta;               % Should be the reconstruction of the prediction error
  xhat(k) = p(k) + dhat(k);  % New decoded sample
end



end
