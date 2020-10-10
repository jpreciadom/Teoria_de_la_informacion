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
subplot(2,2,1);
plot(t, m(t), "-");
axis([0 f -1.5 1.5]);

opcion = 2;

%-----------------------------------MUESTREO-----------------------------------%

subplot(2,2,2);

if opcion == 1
  tn = [0: T : f];
  stem(tn, m(tn));
else
  %Se crea la función delta para tomar muestras de la onda
  delta = inline(" rem(t, T) <  T/8 ", "t");
  
  %Se grafican las muestras tomadas de la onda, delta(t)*m(t)
  plot(t, m(t).*delta(t));
end

axis([0 f -1.5 1.5]);

%---------------------------------CUANTIZACION---------------------------------%

%Valor maximo de la onda
mp = 1;

%Cantidad de zonas, calculadas por la amplitud maxima de la onda
L = ceil(mp) * 10;

%Tamaño Delta de cada zona
Delta = (2*mp) / L;

subplot(2,2,3);

if opcion == 1
  coder = inline(" Delta * floor(m(tn) / Delta) + (Delta/2) ", "t");
  stem(tn, coder(tn));
else
  coder = inline(" Delta * floor(m(t).*delta(t) / Delta) + (Delta/2) ", "t");
  plot(t, coder(t));
end

%---------------------------------CODIFICACION---------------------------------%



%---------------------------FORMATOS DE SEÑALIZACION---------------------------%