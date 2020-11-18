T = input("Ingrese el periodo de la onda rectangular: ");      %Solicita el periodod de la onda rectangular
amp = input("Ingrese la amplitud de la onda rectangular: ");   %Solicita la amplitud de la onda rectangular
w0 = (2*pi)/T;                                                 %Calcula w0

x = inline(" (rem(t, T) < T/2)*amp ", "t");     %Crea la funcion x(t) correspondiente a la onda periodica rectangular

t = [0:0.001:2*T-0.001];                        %Define un vector de valores t

subplot(2,2,1);                                 %Se definen 2x2 planos cartesianos
plot(t, x(t), "-r"); xlabel("t"); ylabel("f(t)"); title("Onda cudrada periodica");
grid(); axis([0 2*T -0.1 amp*2 + 0.1]);         %Se grafica la funcion x(t) en el primer plano 

t = [0:0.001:T];                                %Se redefine un nuevo intervalo t
N = [11 51 91];                                 %Se define un vector para los valores en donde se va a truncar la serie

for i = 2:1:4
  subplot(2,2,i);
  xN = strcat(num2str(amp), "/2");              %Se comienza a crear la funcion xN(t)
  for K = 1:2:N(i-1)                            %Se itera con k desde 1 hasta el valor almacenado en N(i-1)
    bK = strcat(num2str(2*amp), "/(", num2str(K*pi), ")"); %Se forma el termino bK
    tsK = strcat(" + ", bK, "*sin(", num2str(K), "*", num2str(w0), "*t)"); %Se forma el k/esimo termino de la serie
    xN = strcat(xN, tsK);                       %Se agrega el k/esimo termino a la funcion xN
  endfor
  xN = inline(xN, "t");                         %Se convierte a xN en funcion
  plot(t, xN(t), "-b"); xlabel("t"); ylabel("xN(t)");
  title(strcat("Serie de fourier truncada en k = ", num2str(N(i-1))));
  grid(); axis([0 T -0.1 amp*2 + 0.1]);         %Se grafica la serie de fourier truncada en k = N(i-1)
endfor
