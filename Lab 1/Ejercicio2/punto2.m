clear

%declaracion de variables
%pasa el ancho del pulso como parametro
a=1;
w1 = 0.5;
w2 = 1.5;
wc = 1;
ts=0.1;
t=[-5:0.01:5];
w=[-10:0.02:10];

figure(1)
%Declaracion la señal de pulso y la grafica
p = (t<a)&(t>-a);
subplot(3,1,1); plot(t,p,'-r'); 
xlabel ("Tiempo(t)");
ylabel ("x(t)");
title('Pulso Rectangular'); axis([-a-2 a+2 -0.1 1.1]); grid;
%--------------------------------------

%fft computacional
comp=fftshift(fft(p));
subplot(3,1,2);plot(w ,abs(comp)*ts,'-b');
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|H(\omega)|');
title('Transformada de fourier pulso rectangular(computacional)');grid;axis([-10 10 ])

%fft teorica
teor=inline('2*a*(sin(w*a)+(w==0))./(w*a+(w==0))','w');
subplot(3,1,3);plot(w ,teor(w),'-b');
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('X(\omega)'); 
title('Transformada de fourier pulso rectangular(teórica)');grid;axis([-10 10 ])

figure(2)
%Declaracion de los filtros
LPF = (t < wc) & (t > -wc); %Pasa Bajas
HPF = (t > wc) | (t < -wc); %Pasa Altas
BPF = ((t < w2) & (t > w1)) | ((t > -w2) & (t < -w1)); %Pasa Bandas
BFS = (t < -w2) | ((t > -w1) & (t < w1)) | (t > w2); %Suprime Bandas
%--------------------------------------

subplot(4,1,1);plot(t,LPF,'-r'); 
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|H(\omega)|');
title('Filtro pasa bajas');grid;axis([-5 5 0 1.3]);
subplot(4,1,2);plot(t,HPF,'-r'); 
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|H(\omega)|');
title('Filtro pasa altas');grid;axis([-5 5 0 1.3]);
subplot(4,1,3);plot(t,BPF,'-r'); 
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|H(\omega)|');
title('Filtro pasa bandas');grid;axis([-5 5 0 1.3]);
subplot(4,1,4);plot(t,BFS,'-r'); 
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|H(\omega)|');
title('Filtro suprime bandas');grid;axis([-5 5 0 1.3]);

figure(3)


subplot(3,2,1);plot(t,p,'-r');
xlabel ("Tiempo(t)");
ylabel ("x(t)");
title('Pulso Rectangular'); axis([-a-2 a+2 -0.1 1.1]); grid;

subplot(3,2,2);plot(w ,abs(comp)*ts,'-b'); 
xlabel ("Frecuencia[Hz]");
ylabel ('|H(\omega)|');
title('Transformada de fourier pulso rectangular(computacional)');grid;axis([-10 10 ])

fw=fftshift(fft(p)*ts).*LPF;
subplot(3,2,3);plot(w,abs(fw),'-b');
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|Y(\omega)|');
title('Filtro LPF en la frecuencia'); axis([-10 10 ]); grid;

subplot(3,2,5);plot(t,abs(ifft(ifftshift(fw)))/ts); 
xlabel ("Tiempo(t)");
ylabel ("x(t)");
title('Filtro LPF en el tiempo'); axis([-a-2 a+2 -0.1 1.1]); grid;

fw=fftshift(fft(p)*ts).*HPF;
subplot(3,2,4);plot(w,abs(fw),'-b');
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|Y(\omega)|'); 
title('Filtro HPF en la frecuencia'); axis([-10 10 ]); grid;

subplot(3,2,6);plot(t,abs(ifft(ifftshift(fw)))/ts);
xlabel ("Tiempo(t)");
ylabel ("x(t)");
title('Filtro HPF en el tiempo'); axis([-a-2 a+2 -0.1 1.1]); grid;


figure(4)
subplot(3,2,1);plot(t,p,'-r');
xlabel ("Tiempo(t)");
ylabel ("x(t)");
title('Pulso Rectangular'); axis([-a-2 a+2 -0.1 1.1]); grid;

subplot(3,2,2);plot(w ,abs(comp)*ts,'-b'); 
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|Y(\omega)|');
title('Transformada de fourier pulso rectangular(computacional)');grid;axis([-10 10 ])

fw=fftshift(fft(p)*ts).*BPF;
subplot(3,2,3);plot(w,abs(fw),'-b');
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|Y(\omega)|');
title('Filtro BPF en la frecuencia'); axis([-10 10 ]); grid;

subplot(3,2,5);plot(t,abs(ifft(ifftshift(fw)))/ts); 
xlabel ("Tiempo");
ylabel ("x(t)"); 
title('Filtro BPF en el tiempo'); axis([-a-2 a+2 -0.1 1.1]); grid;

fw=fftshift(fft(p)*ts).*BFS;
subplot(3,2,4);plot(w,abs(fw),'-b'); 
xlabel ('Frecuencia[Hz](\omega)');
ylabel ('|Y(\omega)|');
title('Filtro BFS en la frecuencia'); axis([-10 10 ]); grid;

subplot(3,2,6);plot(t,abs(ifft(ifftshift(fw)))/ts);
xlabel ("Tiempo");
ylabel ("x(t)"); 
title('Filtro BFS en el tiempo'); axis([-a-2 a+2 -0.1 1.1]); grid;


