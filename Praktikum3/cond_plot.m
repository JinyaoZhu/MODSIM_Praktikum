close all;
clear all;

C1 = 0.01;
C2 = 0.02;
R = 100;
h = 1e-3;

N = 5000;

cond_his = zeros(1,N);
h_his = zeros(1,N);

for k=1:N
  
  h = h + 0.00000001*k;

  J = [ 1,  0, -h/(2*C1),         0, 0,  0;
          0,  1,         0, -h/(2*C2), 0,  0;
          1, -1,         0,         0, 0,  0;
          1,  0,         0,         0, 1,  0;
          0,  0,         0,         0, 1, -R;
          0,  0,        -1,        -1, 0,  1];
          
   cond_his(k) = cond(J);
   h_his(k) = h;
end

plot(h_his, cond_his);
grid;
xlabel('h[s]');
ylabel('cond(J)');

idx = find(cond_his==min(cond_his));
disp('The minimal condition number is:');
disp(sprintf('%.3f (h = %f)',cond_his(idx),h_his(idx)));