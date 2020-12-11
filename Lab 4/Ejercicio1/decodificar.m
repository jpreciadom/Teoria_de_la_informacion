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
    
    % Se crean celdas para almacenar las palabras obtenidas
    words = {numWords};
    
    % Se le da formato a las palabras para devolver una matriz de
    % caracteres
    for i = 1:numWords
        % Se calcula el peso de hamming de cada fila de e para saber si
        % tiene error 
        hw = HammingWeight(e(i,:));
        % Si el peso de hamming es 0 el i-esimo código no tiene error y se
        % obtiene la palabra correspondiente
        if(hw ==0)
            strWord = "";
            for j = 1:size(Ht,2)
                strWord = strWord + num2str(cods(i,j));
            end
            words(1,i) = cellstr(strWord);
        % Si es peso de hamming es 1 se puede corregir el error
        elseif (hw == 1)
            % Se busca y se corrige el error
            for j = 1:size(Ht,1)
                find = 1;
                for k = 1:size(e,2)
                    if(e(i,k) ~= Ht(j,k))
                        find = 0;
                        break;
                    end
                end
                if(find == 1)
                    cods(i,j) = mod(cods(i,j)+1,2);
                    break;
                end
            end
            % Con el error corregido se obtiene la palabra correspondiente
            strWord = "";
            for j = 1:size(Ht,2)
                strWord = strWord + num2str(cods(i,j));
            end
            words(1,i) = cellstr(strWord);
        end
    end
    words = char(string(words)');
end