function words = decodificar(cods, Ht)
    % Funcion que decondifica un conjunto de códigos
    % Words es una matriz de unos y ceroz, cada fila es un código y la
    % cantidad de columnas representan la longitud de los códigos
    % Ht es la matriz de checkeo de paridad
    % Retona una matriz con ceros y unos que representan la codificación
    % obtenida para cada palabra
    
    % Se obtienen la cantidad de palabras
    numWords = size(cods,1);
    
    % Se multiplican los códigos obtenidos con la matriz de chequeo de
    % paridad para verificar errores
    e = mod(cods(1:numWords,:)*Ht,2);
    
    % Se verifica el resultado obtenido en e en búsca de errores
    for i = 1:numWords
        for j = 1:size(Ht,2)
            if(e(i,j) ~= 0)
                words = i;
                return;
            end
        end
    end
    
    % Se crean celdas para almacenar las palabras obtenidas
    words = {numWords};
    
    % Se le da formato a las palabras para devolver una matriz de
    % caracteres
    for i = 1:numWords
        strWord = "";
        for j = 1:size(Ht,2)
            strWord = strWord + num2str(cods(i,j));
        end
        words(1,i) = cellstr(strWord);
    end
    words = char(string(words)');
end