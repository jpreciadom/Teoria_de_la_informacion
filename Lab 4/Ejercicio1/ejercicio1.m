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
      0 0 1];
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
cod = cod-'0';

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
        % Tabla para mostrar la codificación del mensaje ingresado
        TC = table;
        % Se solicita el mensaje a codificar
        mensaje = input("Ingrese el mensaje binario que desea codificar: ", "s");
        disp(newline);
        % Se calcula el tamaño del mensaje
        mSize = size(mensaje, 2);
        
        % Se verifica que el mensaje tenga un tamaño múltiplo de k
        if(mod(mSize, k) == 0)
            % Se calcula la cantidad de bloques 
            bloques = mSize/k;
            % Vector para almacenar los indices de cada bloque
            indices = zeros(bloques,1);
            % Celdas para almacenar los palabas en cada bloque
            m = {bloques};
            % Se crean las palabras de tamaño k y se almacenan en el i-ésimo
            % bloque
            for i = 1 : bloques
                indices(i, 1) = i;
                im = "";
                for j = 1:k
                    im = im + mensaje((i*k)-k+j);
                end
                m(1,i) = cellstr(im);
            end
            % Se cambia de tipo celda a matriz de caracteres
            m = char(string(m)');
            % Se agrega la columna de indices a la tabla
            TC.("i") = indices;
            % Se agregan los bloques con las palabras a la tabla
            TC.("bloque_i") = m;
            % Se codifican las palabras y se agregan a la tabla
            TC.("c_i") = codificar(m, G);
            % Se muestra la tabla
            disp(TC);
        else
            disp("Tamaño del mensaje no válido, retornando.......");
        end
    elseif(opcion == 2)
        % Tabla para mostrar la codificación del mensaje ingresado
        TC = table;
        % Se solicita el mensaje a codificar
        mensaje = input("Ingrese el mensaje que desea decodificar: ", "s");
        disp(newline);
        % Se calcula el tamaño del mensaje
        mSize = size(mensaje, 2);
        
        % Se verifica que el codigo tenga un tamaño múltiplo de n
        if(mod(mSize, n) == 0)
            % Se calcula la cantidad de bloques 
            bloques = mSize/n;
            % Vector para almacenar los indices de cada bloque
            indices = zeros(bloques,1);
            % Celdas para almacenar los codigos en cada bloque
            m = {bloques};
            % Se crean los codigos de tamaño n y se almacenan en el i-ésimo
            % bloque
            for i = 1 : bloques
                indices(i, 1) = i;
                im = "";
                for j = 1:n
                    im = im + mensaje((i*n)-n+j);
                end
                m(1,i) = cellstr(im);
            end
            % Se cambia de tipo celda a matriz de caracteres
            m = char(string(m)');
            % Se decodifica
            decod = decodificar(m, Ht);
            % Se verifica el resultado obtenido por la función
            if(isnumeric(decod))
                disp("Ha habido un error con el bloque " + num2str(decod));
                disp(m(decod, :));
            else
                % Se agrega la columna de indices a la tabla
                TC.("i") = indices;
                % Se agregan los bloques con las palabras a la tabla
                TC.("c_i") = m;
                % Se agrega la columna con las palabras obtenidas
                TC.("palabra_i") = decod;
                % Se muestra la tabla
                disp(TC);
            end
        else
            disp("Tamaño del mensaje no válido, retornando.......");
        end
    end
end