  %% LA CONFIGURACIÓN INICIAL 
clc; clear; close all; 
% si cerramos todas las figuras abiertas, nos permite asegurar que empezamos desde cero.

rng(2023); 


%% DATOS DEMOGRÁFICOS (Curso 2023-2024)
num_estudiantes = 150; 
%El número total de estudiantes que han respondido a nuestra
% encuesta.


% Facultades (según distribución UFV)
facultades_ufv = {'EPS', 'Humanidades', 'Ciencias Sociales', 'Salud', 'Artes'};
% Creamos un array con los nombres de las facultades que  hemos considerado.

dist_facultades = [70, 20, 40, 10, 10]; 
% Definimos el número de estudiantes de cada facultad que han respondido a nuestra encuesta, sumando en total 150.
% Hemos redondeado, para que fuesen más fáciles los cálculos.

% Asignamos a cada estudiante su facultad.
facultades = cell(num_estudiantes,1); 
last = 0;
for i = 1:length(facultades_ufv)
    facultades(last+1:last+dist_facultades(i)) = facultades_ufv(i);
    last = last + dist_facultades(i);
end

% Años académicos (donde habrá 150 elementos, ya que hay 150 alumnos)
anios = [ones(62,1); 2*ones(40,1); 3*ones(26,1); 4*ones(22,1)]; 
% Creamos un vector indicando el año académico de cada estudiante.



genero = [repmat({'Hombre'},57,1); repmat({'Mujer'},93,1)]; 
% Creamos un vector con el género de cada estudiante.


%% DATOS DE ENCUESTA 

canales = {
    'Clases presenciales';
    'Teams UFV';
    'WhatsApp';
    'Instagram'; 
    'Facebook';
    'Eventos UFV'; 
    'Deportes UFV'
};
% Definimos los canales de comunicación que nosotras consideramos 
% para las interacciones.

% Inicializamos una matriz para guardar las probabilidades de uso por facultad.
prob_canales = zeros(length(facultades_ufv), length(canales));

% Asignamos probabilidades para cada facultad (que nosotras hemos calculado aproximadamente con las encuestas).

% EPS: más Teams, menos redes sociales
prob_canales(1,:) = [1.0, 0.9, 0.8, 0.4, 0.2, 0.3, 0.3];

% Humanidades: más estable
prob_canales(2,:) = [1.0, 0.7, 0.9, 0.6, 0.4, 0.5, 0.2];

% Ciencias Sociales: más redes sociales
prob_canales(3,:) = [1.0, 0.6, 0.95, 0.8, 0.5, 0.6, 0.1];

% Salud: menos deportes, más Teams
prob_canales(4,:) = [1.0, 0.95, 0.9, 0.5, 0.3, 0.4, 0.05];

% Artes: más eventos, Instagram
prob_canales(5,:) = [1.0, 0.5, 0.7, 0.9, 0.4, 0.8, 0.1];

% Generamos los datos de encuesta simulando si cada estudiante usa cada canal.
uso_canales = false(num_estudiantes, length(canales));
for i = 1:num_estudiantes
    fac_idx = find(strcmp(facultades_ufv, facultades{i})); 
    % Encontramos el índice de la facultad del estudiante actual.
    for j = 1:length(canales)
        if rand() <= prob_canales(fac_idx,j)
            uso_canales(i,j) = true; 
            % Si el número aleatorio es menor a la probabilidad, marcamos que usa el canal.
        end
    end
end

%% CONSTRUCCIÓN DEL GRAFO 
% Matriz de adyacencia (grafos no dirigidos)
A = zeros(num_estudiantes); 
% Inicializamos la matriz que nosotras usaremos para representar 
% las conexiones entre estudiantes.

% 4.2 Reglas de conexión (basadas en nuestro alcance)
for i = 1:num_estudiantes
    for j = i+1:num_estudiantes
        prob = 0.05; 
        % Establecemos una probabilidad base para que dos estudiantes estén conectados.

        if strcmp(facultades{i}, facultades{j})
            prob = prob + 0.35; 
            % Aumentamos la probabilidad si son de la misma facultad.
        end
        
        if anios(i) == anios(j)
            prob = prob + 0.25; 
            % Aumentamos la probabilidad si están en el mismo año académico.
        end
        
        if sum(uso_canales(i,:) & uso_canales(j,:)) >= 3
            prob = prob + 0.2; 
            % Aumentamos la probabilidad si comparten al menos 3 canales de comunicación.
        end
        
        if rand() <= prob
            A(i,j) = 1;
            A(j,i) = 1; 
            % Si pasa la probabilidad total, conectamos ambos nodos (grafo no dirigido).
        end
    end
end

%% PREPARACION PARA ANÁLISIS DE COMUNIDADES
% Datos para Louvain (exportar a Python)
nodos = table((1:num_estudiantes)', facultades, anios, genero, ...
    'VariableNames', {'ID', 'Facultad', 'Anio', 'Genero'});
% Creamos una tabla con la información básica de cada estudiante 
% que nosotras pudimos usar para el análisis de comunidades.

for i = 1:length(canales)
    nodos.(canales{i}) = uso_canales(:,i); 
  
end

% Exportar grafo para NetworkX 
[src, dst] = find(triu(A)); 
% Extraemos las aristas únicas

aristas = table(src, dst, 'VariableNames', {'Source', 'Target'}); 
% Creamos la tabla de aristas que representa las conexiones 
% que nosotras analizaremos.

writetable(nodos, 'datos_nodos_ufv.csv'); 
% Guardamos los nodos en un archivo CSV para análisis externo.
writetable(aristas, 'datos_aristas_ufv.csv'); 
% Guardamos las aristas en otro archivo CSV.

%% MÉTRICAS PRELIMINARES 

grado = sum(A, 2); 
% Calculamos cuántas conexiones tiene cada estudiante (que son los nodos).
nodos.Grado = grado; 
% Añadimos esta información a la tabla que nosotras creamos.


clustering = zeros(num_estudiantes,1);
for i = 1:num_estudiantes
    vecinos = find(A(i,:)); 
    % Encontramos los vecinos (nodos conectados) del nodo i.
    k = length(vecinos); 
    if k < 2
        clustering(i) = 0; 
        % Si tiene menos de dos vecinos, su clustering es 0.
    else
        subgraf = A(vecinos, vecinos); 
        % Extraemos el subgrafo formado por sus vecinos.
        clustering(i) = sum(subgraf(:))/(k*(k-1)); 
        % Calculamos el coeficiente de clustering local.
    end
end
nodos.Clustering = clustering; 
% Guardamos el resultado en la tabla para que nosotras podamos analizarlo.

% Centralidad 
nodos.Centralidad = grado/(num_estudiantes-1); 
% Calculamos la centralidad por grado normalizado para cada nodo.

%% VISUALIZACIÓN BÁSICA 
figure;
G = graph(A);
h = plot(G, 'Layout', 'force', 'NodeLabel', {}, 'MarkerSize', 3);
title('Red Social UFV - Visualización Preliminar');

colores = lines(length(facultades_ufv));
hold on; 
handles = []; 

for i = 1:length(facultades_ufv)
    idx = find(strcmp(facultades, facultades_ufv{i}));
    highlight(h, idx, 'NodeColor', colores(i,:));
    handles(i) = scatter(NaN, NaN, 'MarkerFaceColor', colores(i,:), 'MarkerEdgeColor', colores(i,:));
end

legend(handles, facultades_ufv, 'Location', 'best');
hold off;