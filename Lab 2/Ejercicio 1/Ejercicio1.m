%------------------------------SOLICITUD DE DATOS------------------------------%

%Se solicita la onda m(t)
m = input("Ingrese la funcion de la onda m(t): ", 's');
m = inline(m, "t");

%Valor n que no se para que sirve
n = 3;

%Valor maximo de la onda
mp = 1;

%Se solicita la frecuencia de la onda m(t)
f = input("Indique la frecuencia de la funcion: ");

%Vector con los valores t desde 0 hasta la frecuencia de la onda para graficarla
t = [0 : 0.001 : f];

%Se grafica la onda m(t)
subplot(2,2,1);
plot(t, m(t), "-");
axis([0 f -(mp+0.5) (mp+0.5)]);

%Opcion para graficar el muestreo y la cuantizacion
opcion = 1;

%------------------------------------------------------------------------------%

%-----------------------------------MUESTREO-----------------------------------%

subplot(2,2,2);

%Se calcula el tiempo T que indica cada cuanto se debe toma una muestra de la onda
T = 1/(2*f);

%Vector para muestrear la onda m(t) cada T segundos
tn = [0: T : f];

if opcion == 1
  %Se grafica en una grafica de puntos
  stem(tn, m(tn));
else
  %Se crea la función delta para tomar muestras de la onda
  delta = inline(" rem(t, T) <  T/8 ", "t");
  
  %Se grafican las muestras tomadas de la onda, delta(t)*m(t)
  plot(t, m(t).*delta(t));
end

axis([0 f -(mp+0.5) (mp+0.5)]);

%------------------------------------------------------------------------------%

%---------------------------------CUANTIZACION---------------------------------%

%Cantidad de zonas, calculadas por la amplitud maxima de la onda
L = 2 ^ n;

%Tamaño Delta de cada zona
Delta = (2*mp) / L;

%Funcion que calcula la zona en la cual se encuentra un valor x
zona = inline(" floor((x + mp)/Delta) - (x >= mp) ", "x");

%Funcion que cuantiza los valores dados en el parametro x
cuantizacion = inline(" zona(x)*Delta - mp + (Delta/2) ", "x");

subplot(2,2,3);

if opcion == 1
  %Se grafica en una grafica de puntos
  stem(tn, cuantizacion(m(tn)) );
else
  %Se grafica la codificacion
  plot(t, cuantizacion( m(t).*delta(t) ));
end


axis([-0.2 f+0.2 -(mp+0.5) (mp+0.5)]);

%------------------------------------------------------------------------------%

%---------------------------------CODIFICACION---------------------------------%

codificacion = cellstr(dec2bin(zona(m(tn))));



%------------------------------------------------------------------------------%

%---------------------------FORMATOS DE SEÑALIZACION---------------------------%



%------------------------------------------------------------------------------%