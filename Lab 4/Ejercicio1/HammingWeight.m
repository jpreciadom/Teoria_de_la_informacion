function weight = HammingWeight(c)
    % Función que calcula el peso de hamming de una palabra de codigo c
    
    % Itera sobre la palabra de código, cuenta la cantidad de unos en ella
    % y lo almacena en weight
    weight = 0;
    for i = 1:size(c,2)
        weight = weight + c(i);
    end
end