%Se solicita la onda m(t)
m = input("Ingrese la funcion de la onda m(t): ", 's');
m = inline(m, "t");

%Valor n que no se para que sirve
n = 3;

%Valor maximo de la onda
mp = 1;

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

%Opcion para graficar el muestreo y la cuantizacion
opcion = 2;

%-----------------------------------MUESTREO-----------------------------------%

subplot(2,2,2);

if opcion == 1
  %Vector para muestrear la onda m(t) cada T segundos
  tn = [0: T : f];
  %Se grafica en una grafica de puntos
  stem(tn, m(tn));
else
  %Se crea la función delta para tomar muestras de la onda
  delta = inline(" rem(t, T) <  T/8 ", "t");
  
  %Se grafican las muestras tomadas de la onda, delta(t)*m(t)
  plot(t, m(t).*delta(t));
end

axis([0 f -1.5 1.5]);

%---------------------------------CUANTIZACION---------------------------------%

%Cantidad de zonas, calculadas por la amplitud maxima de la onda
L = 2 ^ 3;

%Tamaño Delta de cada zona
Delta = (2*mp) / L;

subplot(2,2,3);

if opcion == 1
  %Se crea una funcion coder en base al vector tN
  coder = inline(" Delta * floor(m(tn) / Delta) + (Delta/2) ", "t");
  %Se grafica en una grafica de puntos
  stem(tn, coder(tn));
else
  %Se crea una funcion coder en base a la funcion m(t) y la funcion delta
  coder = inline(" Delta * floor(m(t).*delta(t) / Delta) + (Delta/2) ", "t");
  %Se grafica la codificacion
  plot(t, coder(t));
end

%---------------------------------CODIFICACION---------------------------------%



%---------------------------FORMATOS DE SEÑALIZACION---------------------------%