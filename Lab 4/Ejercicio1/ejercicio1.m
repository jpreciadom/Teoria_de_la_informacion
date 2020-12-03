% Tamaño del bloque de código
n = 6;
% Tamaño del bloque de bits
k = 3;

% Matriz generadora G
G = [1 0 0 1 1 1;
     0 1 0 0 1 1;
     0 0 1 1 1 0];
% Matriz de chequeo de paridad Ht
Ht = [1 1 1;
      0 1 1;
      1 1 0;
      1 0 0;
      0 1 0;
      0 0 1]
disp(newline);

% Se crea una tabla vacia para almacenar las palabras y su codificación
T = table;

% Se agrega una columna con los índices a la tabla
T.("i") = (1:8)';

% Se crea un vector d con todas las posibles palabras y se agrega como
% columna a la tabla
d = dec2bin(0:7);
T.("d") = d;
d = d - '0';

% Se crea un vector cod para la codificacion de cada palabra en d y se
% agrega como columna a la tabla
cod = codificar(d(1:8,:), G);
T.("c") = cod;

% Se imprime la tabla
disp(T);

% Ciclo para solicitar al usuario palabras para codificar o decodificar
opcion = 3;
while(opcion ~= 0)
    % Se pregunta al usuario lo que desea hacer
    disp(newline);
    disp("Elija una opción: ");
    disp("1. Codificar un mensaje");
    disp("2. Decodificar un mensaje");
    disp("0. Terminar ejecición")
    opcion = input("Opción: ");
    disp(newline);
    %If para mirar la opcion ingresada
    if(opcion == 1)
        TC = table;
        mensaje = input("Ingrese el mensaje binario que desea codificar: ", "s");
        disp(newline);
        mSize = size(mensaje, 2);
        bloques = mSize/k;
        
        indices = zeros(bloques,1);
        m = {bloques};
        for i = 1 : bloques
            indices(i, 1) = i;
            im = "";
            for j = 1:k
                im = im + mensaje((i*k)-k+j);
            end
            m(1,i) = cellstr(im);
        end
        m = char(string(m)');
        TC.("i") = indices;
        TC.("bloque_i") = m;
        TC.("c_i") = codificar(m, G);
        disp(TC);
    elseif(opcion == 2)
        mensaje = input("Ingrese el mensaje que desea decodificar: ");
    end
end