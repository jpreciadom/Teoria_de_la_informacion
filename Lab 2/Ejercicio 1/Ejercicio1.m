%------------------------------SOLICITUD DE DATOS------------------------------%

%Se solicita la onda m(t)
m = input("Ingrese la funcion de la onda m(t): ", 's');
m = inline(m, "t");

%Se solicita la frecuencia de la onda m(t)
f = input("Indique la frecuencia de la funcion: ");

%Vector con los valores t desde 0 hasta la frecuencia de la onda para graficarla
t = [0 : 0.001 : f];

%Valor maximo de la onda
mp = max(m(t));

%Se grafica la onda m(t)
subplot(2,2,1);
plot(t, m(t), "-"); xlabel("t"); ylabel("m(t)"); title("Onda m(t)");
axis([0 f -(mp+0.5) (mp+0.5)]);

%------------------------------------------------------------------------------%

%-----------------------------------MUESTREO-----------------------------------%


%Se calcula el tiempo T que indica cada cuanto se debe toma una muestra de la onda
T = 1/(2*f);

%Vector para muestrear la onda m(t) cada T segundos
tn = [0: T : f];

%Se grafica en una grafica de puntos
subplot(2,2,2);
stem(tn, m(tn));
xlabel("t_n"); ylabel("m(t_n)"); title("Onda m(t) muestreada");

axis([0 f -(mp+0.5) (mp+0.5)]);

%------------------------------------------------------------------------------%

%---------------------------------CUANTIZACION---------------------------------%

%Valor n que no se para que sirve
n = input("Ingrese el numero de bits a codificar: ");

%Cantidad de zonas, calculadas por la amplitud maxima de la onda
L = 2 ^ n;

%Tamaï¿½o Delta de cada zona
Delta = (2*mp) / L;

%Funcion que calcula la zona en la cual se encuentra un valor x
zona = inline(" floor((x + mp)/Delta) - (x >= mp) ", "x");

%Funcion que cuantiza los valores dados en el parametro x
cuantizacion = inline(" zona(x)*Delta - mp + (Delta/2) ", "x");

%Se grafica en una grafica de puntos
subplot(2,2,3);
stem(tn, cuantizacion(m(tn)));
xlabel("t_n"); ylabel("m(t_n)"); title("Cuantizacion de la onda m(t)");


axis([-0.2 f+0.2 -(mp+0.5) (mp+0.5)]);

%------------------------------------------------------------------------------%

%---------------------------------CODIFICACION---------------------------------%

y_niveles_binario = dec2bin(zona(m(tn)));
codificacion = cellstr(y_niveles_binario);
y_niveles_binario = [];
for i=1:length(codificacion)
  y_niveles_binario = [y_niveles_binario sprintf('%d',base2dec(codificacion(i,1),10)) - '0'];
  codificacion(i,1) = strcat("Código numérico: ", mat2str(zona(m(tn))(i)),"    Código binario: ", codificacion(i,1) );
endfor
codificacion

%------------------------------------------------------------------------------%

%-------Literal d. REPRESENTACION DEL PULSO-------------------------------
disp("Seleccione el tipo de codificaciï¿½n :");
disp("1-Unipolar NRZ");
disp("2-Bipolar NRZ");
disp("3-Unipolar RZ");
disp("4-Bipolar RZ");
disp("5-AMI");
disp("6-Manchester");
opcion=input("ingrese la opción: ");
y=[];

#Tipos dependiendo de la eleccion
f_s=100;
#No Return to Zero
NRZ=ones(1,f_s);
#Return Zero
RZ= [ones(1,f_s/2) zeros(1,f_s/2)];
#Caso especial para Manchester
Man=[ones(1,f_s/2)  -ones(1,f_s/2)] ;

switch (opcion)
	case 1
		#El nivel de amplitud se mantiene durante todo el intervalo de bit
    #Solo admite salidas positivas
		tipo=NRZ;
		for i=1:length(y_niveles_binario)
		    switch y_niveles_binario(i)
		        case 1
		            y=[y  tipo];
		        case 0
		            y=[y  (0*tipo)];        
		    end
		end
	case 2
		#El nivel de amplitud se mantiene durante todo el intervalo de bit
    #Admite salidas positivas y negativas
		tipo=NRZ;
		for i=1:length(y_niveles_binario)
		    switch y_niveles_binario(i)
		        case 1
		            y=[y  tipo];
		        case 0
		             y=[y  -tipo];
		    end
		end
	case 3
		#El pulso positivo retorna a cero
    #Solo admite salidas positivas
		tipo=RZ;
		for i=1:length(y_niveles_binario)
		    switch y_niveles_binario(i)
		        case 1
		            y=[y  tipo];
		        case 0
		            y=[y  (0*tipo)];        
		    end
		end
	case 4
		#Pulsos con retorno a zero en la mitad del bit
    #Admite salidas positivas y negativas
		tipo=RZ;
		for i=1:length(y_niveles_binario)
		    switch y_niveles_binario(i)
		        case 1
		            y=[y  tipo];
		        case 0
		             y=[y  -tipo];
		    end
		end
	case 5
		#Pulsos de 1 se alternan entre positivo y negativo,pulso 0 ausencia de pulso
		tipo=RZ;
		count = 0;
		for i=1:length(y_niveles_binario)
		    switch y_niveles_binario(i)
		        case 1
              if mod (count,2) == 0
                y=[y  tipo];
              else
                y=[y  -tipo];		          	
              endif
              count++;
		        case 0
		            y=[y  (0*tipo)];        
		    end
		end		
	case 6
		#pulso positivo: inicia positivo termina negativo
    #pulso negativo: inicia negativo termina positivo 
		tipo=Man;
		for i=1:length(y_niveles_binario)
		    switch y_niveles_binario(i)
		        case 1
		            y=[y  tipo];
		        case 0
		             y=[y  -tipo];
		    end
		end
endswitch

  t1=(0:(length(y)-1))/f_s;
  figure(2);
  subplot(1,1,1);plot(t1,y,'k');set(gca,'Xlim',[0 8]); set(gca,'XTick',(0:1:8)); axis([0 8 -1.1 1.1]); title('SeÃ±al codificada');xlabel('nT_s'); ylabel('x(nT_s)');
  
  %-----------------Literal e. RECUPERAR M(T)----------------

sum=0;
w_m=f;
for i=0:100
  fun=m(i*T)*(sin(w_m.*(t-i*T))/w_m.*(t-i*T));
  sum=sum+fun;
endfor
figure(3);
plot(t,sum); title('Recuperacion de la seÃ±al');


