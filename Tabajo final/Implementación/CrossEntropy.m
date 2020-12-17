function ce = CrossEntropy(p, q)
    % Calcula la entropia cruzada para dos distribuciones de probabilidad
    % de probabilidad p y q
    ce = 0;
    for i = 1:size(p,2)
        ce = ce + (p(i)*log2(q(i)));
    end
    ce = ce * -1;
end