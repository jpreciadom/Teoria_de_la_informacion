function cod = coding( A, row, col )
  
  % Se obtienen la cantidad de filas
  n = size(A, 1);
  
  % Se obtiene el valor de la probabilidad actual
  current = A(row, col);
  
  % Si se cumplen alguna de las dos condiciones nuestra probabilidad actual esta
  % combinada con otra en la siguiente columna y se calcula el valor que esta en
  % la siguiente columna
  % Next value representa el valor que se va a buscar en la siguiente columna
  % para contuniar con el algoritmo
  % Cod representa la codificación que se obtiene en la columa actual
  if (row == (n+1-col))
    cod = "1";
    nextValue = current + A(row - 1, col);
  elseif (row == (n-col))
    cod = "0";
    nextValue = current + A(row + 1, col);
  else
    cod = "";
    nextValue = current;
  endif
  
  % Verifica que no este en la ultima columna para decidir si continuar o
  % terminar el algoritmo
  if (col < size(A,2))
    % Si no esta en la ultima columna de busca el siguiente valor en la
    % siguiente columna, ya sea la combinacion de probabilidades o la misma
    % probabilidad
    nextCol = col+1;
    % Se busca la fila donde esta el valor que se esta buscando en la siguiente
    % columna y se almacena en nextRow
    for i = n-col:-1:1
      if( A(i,nextCol) == nextValue )
        nextRow = i;
        break;
      endif
    endfor
    % Se llama recursivamente a la misma funcion con lo0s valores de la
    % siguiente posición y al resultado que se obtenga se la concatena al final
    % el resultado obtenido para la posicion actual
    cod = strcat(coding( A, nextRow, nextCol ), cod);
  endif  
  
endfunction
