inputId = fopen('input.txt', 'r');
[input, count] = fscanf(inputId, '%f');

if(count<=0)
    error("No hay ningun dato en el archivo input.txt");
end

probabilidadEsperada = input(1:count/2);
probabilidadObtenida = input(count/2+1:count);

EntropiaCruzada = 0;
for i = 1:count/2
    EntropiaCruzada = EntropiaCruzada + (-1 * probabilidadObtenida(i) * log2(probabilidadEsperada(i)));
end

b = bar([probabilidadEsperada probabilidadObtenida]);
legend(b, {'Probabilidades esperadas' 'Probabilidades obtenidas'});
axis([0.5 count/2+0.5 0 max([max(probabilidadEsperada) max([probabilidadObtenida])])*1.5]);

fclose(inputId);

outputId = fopen('output.txt', 'w+');
fprintf(outputId, '%f', EntropiaCruzada);
fclose(outputId);