p = [1 1 1 1 1 0 0 0 0 0];
q = [0.8 0.9 0.9 0.6 0.8 0.1 0.4 0.2 0.1 0.3];

format long;

% Calcular la entropia cruzada para cada ejemplo
results = zeros(size(p,2),1);
for i = 1:size(p,2)
	% Crea la distribucion para cada evento {0, 1}
	expected = [1.0 - p(i) p(i)];
	predicted = [1.0 - q(i) q(i)];
	% Calcula la entropia cruzada para los dos eventos
	ce = CrossEntropy(expected, predicted);
    fprintf('[y=%.1f, yhat=%.1f] ce: %.3f bits\n', p(i), q(i), ce);
	results(i) = ce;
end
 
% Calcula la entropia cruzada promedio
mean_ce = mean(results);
fprintf('Entropia cruzada promedio: %.3f bits\n\n', mean_ce);