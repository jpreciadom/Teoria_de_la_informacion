function cod = codificar(words, G)
    % Funcion que condifica un conjunto de palabras
    % Words es una matriz de unos y ceroz, cada fila es una palabra y la
    % cantidad de columnas representan la longitud de las parabras
    % G es la matriz generadora
    % Retona una matriz con ceros y unos que representan la codificación
    % obtenida para cada palabra
    
    % Se obtienen la cantidad de palabras
    numWords = size(words,1);
    
    % Se codifican las palabras usando la matriz generadora teniendo que
    % ci = di*G
    cod = mod(words(1:numWords,:)*G,2);
    
    % Se crean celdas para almacenar la codificacion obtenida
    strCodT = {numWords};
    
    % Se le da formato a lo codificacion para devolver una matriz de
    % caracteres
    for i = 1:numWords
        strCod = "";
        for j = 1:size(G,2)
            strCod = strCod + num2str(cod(i,j));
        end
        strCodT(1,i) = cellstr(strCod);
    end
    cod = char(string(strCodT)');
end