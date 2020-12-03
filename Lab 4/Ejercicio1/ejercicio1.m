% Tama�o del bloque de c�digo
n = 6;
% Tama�o del bloque de bits
k = 3;

% Matriz generadora G
G = [1 0 0 1 1 1; 0 1 0 0 1 1; 0 0 1 1 1 0];
disp(newline);

% Se crea una tabla vacia para almacenar las palabras y su codificaci�n
T = table;

% Se agrega una columna con los �ndices a la tabla
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