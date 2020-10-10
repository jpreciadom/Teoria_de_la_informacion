%Se solicita la onda m(t)
m = input("Ingrese la funcion de la onda m(t): ", 's');
m = inline(m, "t");

%Se solicita la frecuencia de la onda m(t)
f = input("Indique la frecuencia de la funcion: ");
%Se calcula el tiempo T que indica cada cuanto se debe toma una muestra de la onda
T = 1/(2*f);

%Vector con los valores t desde 0 hasta la frecuencia de la onda para graficarla
t = [0 : 0.001 : f];

%Se grafica la onda m(t)
subplot(2,1,1);
plot(t, m(t), "-");
axis([0 f -1.5 1.5]);

%Se crea la función delta para tomar muestras de la onda
delta = inline(" rem(t, T) <  T/8 ", "t");

%Se grafican las muestras tomadas de la onda, delta(t)*m(t)
subplot(2,1,2);
plot(t, m(t).*delta(t));
axis([0 f -1.5 1.5]);