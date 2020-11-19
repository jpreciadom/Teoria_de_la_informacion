%------------------------------------------------------------------------------%

% Se ingresa [P(X)]
Px = input("Ingrese [P(X)]: ");

% Se ingresa la matriz de canal [P(Y|X)]
Pyx = input("Ingrese la matriz de [P(Y|X)]: ");

disp("");

% Se calcula el tamaño del alfabeto de la fuente X
m = size(Px, 2);

% Se calculan la cantidad de columnas de la matrix [P(Y|X)]
n = size(Pyx, 2);

%------------------------------------------------------------------------------%

% Se calcula [P(Y)] aplicando la formula 10.15
Py = Px * Pyx;

%Se imprime el resultado de [Py]
disp("[P(Y)] es: ");
disp(Py);
disp("");

%------------------------------------------------------------------------------%

% Se crea la matriz [P(X)]d, que se usará para calcular [P(X,Y)] mostrada en la
% expresion 10.16
Pxd = zeros(m,m);
for i = 1:m
  Pxd(i,i) = Px(i);
endfor  

% Se calcula la matriz [P(X,Y)] aplicando la formula 10.17
Pxy = Pxd * Pyx;

%Se imprime el resultado de Pxy
disp("[P(X,Y)] es: ");
disp(Pxy);
disp("");

%------------------------------------------------------------------------------%

% Se calcula el valor de H(X) aplicando la formula 10.21
Hx = 0;
for i = 1:m
  Hx = Hx + (Px(i) * log2(Px(i)));
endfor
Hx = Hx * (-1);

% Se muestra el resultado de H(X)
disp(strcat("H(X) = ", num2str(Hx)));
disp("");

%------------------------------------------------------------------------------%

% Se calcula el valor de H(Y|X) aplicando la formula 10.24
Hyx = 0;
for xi = 1:m
  for yj = 1:n
    Hyx = Hyx + (Pxy(xi, yj) * log2(Pyx(yj,xi)));
  endfor
endfor
Hyx = Hyx * (-1);

% Se muestra el resultado de H(Y|X)
disp(strcat("H(Y|X) = ", num2str(Hyx)));
disp("");

%------------------------------------------------------------------------------%

% Se calcula el valor de H(Y) aplicando la formula 10.22
Hy = 0;
for i = 1:n
  Hy = Hy + (Py(i) * log2(Py(i)));
endfor
Hy = Hy * (-1);

% Se muestra el resultado de H(Y)
display(strcat("H(Y) = ", num2str(Hy)));
disp("");

%------------------------------------------------------------------------------%

% Se calcula el valor de H(X,Y) aplicando la formula 10.25
Hxy = 0;
for xi = 1:m
  for yj = 1:n
    Hxy = Hxy + (Pxy(xi, yj) * log2(Pxy(xi, yj)));
  endfor
endfor
Hxy = Hxy *(-1);

% Se muestra el resultado de H(X,Y)
disp(strcat("H(X,Y) = ", num2str(Hxy)));
disp("");

%------------------------------------------------------------------------------%

% Se calcula el valor de I(X;Y) aplicando la propiedad mostrada en la formula
% 10.31 I(X;Y) = H(Y) - H(Y|X) 
Ixy = Hy - Hyx;

% Se muestra el resultado de I(X;Y)
disp(strcat("I(X;Y) = ", num2str(Ixy)));
disp("");

%------------------------------------------------------------------------------%

% Se verifica si es un canal simétrico binario
isBSC = 1;
if (m ~=2 && n~= 2)
  isBSC = 0;
elseif(Pyx(1,1) ~= Pyx(2,2))
  isBSC = 0;
endif

% Comparamos si es un canal simétrico binario
if (isBSC == 1)
  % Se calcula el valor de Cs aplicando la formula 10.42
  p = Pyx(1,1);
  Cs = 1 + (p * log2(p)) + ((1-p) * log2(1-p));
  
  % Se muestra el resultado de Cs
  disp(strcat("Cs = ", num2str(Cs)));
  disp("");
endif  

%------------------------------------------------------------------------------%