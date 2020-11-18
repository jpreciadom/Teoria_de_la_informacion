%------------------------------------------------------------------------------%

% Se ingresa [P(X)]
Px = input("Ingrese [P(X)]: ");

% Se ingresa la matriz de canal [P(Y|X)]
Pyx = input("Ingrese la matriz de [P(Y|X)]: ");

% Se calcula el tamaño del alfabeto de la fuente X
m = size(Px, 1);

% Se calculan la cantidad de columnas de la matrix [P(Y|X)]
n = size(Pyx, 2);

%------------------------------------------------------------------------------%

% Se calcula [P(Y)]
Py = Px * Pyx;

%Se imprime el resultado de [Py]
disp("[P(Y)] es: ");
disp(Py);
disp(newline);

%------------------------------------------------------------------------------%

% Se crea la matriz [P(X)]d, que se usará para calcular [P(X,Y)]
Pxd = Px;
for i = 1:m
  for j = 1:n
    if (i ~= j)
      Pxd(i, j) = 0;
    endif
  endfor
endfor  

% Se calcula la matriz [P(X,Y)]
Pxy = Pxd * Pyx;

%Se imprime el resultado de Pxy
disp("[P(X,Y)] es: ");
disp(Pxy);
disp(newline);

%------------------------------------------------------------------------------%

% Se calcula el valor de H(X)
Hx = 0;
for i = 1:m
  Hx = Hx - (P(i) * log2(P(i)));
endfor

% Se muestra el resultado de H(X)
display("H(X) = " + num2str(Hx) + newline);

%------------------------------------------------------------------------------%

% Se calcula el valor de H(Y|X)
Hyx = 0;



%------------------------------------------------------------------------------%

% Se calcula el valor de H(Y)
Hy = 0;



%------------------------------------------------------------------------------%

% Se calcula el valor de H(X,Y)
Hxy = 0;



%------------------------------------------------------------------------------%

% Se calcula el valor de I(X;Y )
Ixy = 0;



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
  % Se calcula el valor de Cs
  Cs = 0;
endif  

%------------------------------------------------------------------------------%