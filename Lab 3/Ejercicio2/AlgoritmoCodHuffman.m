
% Se solicita el vector [P(X)]
Px = input("Ingrese el vector [P(X)] = ");
disp("");

n = size(Px, 2);

%------------------------------------------------------------------------------%

% 1. Ordenar la lista de probabilidades en orden decresiente
Px = sort( Px, 'descend' );

% 2. Combinar las probabilidades
reg = zeros(n, n-1);
for i = 1:n
  reg(i,1) = Px(i);
endfor

for j = 2:n-1
  for i = 1:n-j
    reg(i,j) = reg(i,j-1);
  endfor
  % Se combinan las los probabilidades mas bajas
  reg(i+1, j) = reg(i+1, j-1) + reg(i+2, j-1);
  
  % Se ordena la j-esima columna de manera descendente
  reg = sort( reg, 'descend' );
endfor

% 
for i = 1:n
  out = num2str(Px(i));
  out = strcat(out, " ", "-->", " ", coding(reg, i, 1));
  disp(out);
endfor
