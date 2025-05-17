# proyectointegrador1
# Detección de Comunidades en Redes de la UFV

![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![NetworkX](https://img.shields.io/badge/NetworkX-2.6.3-green)
![Matlab](https://img.shields.io/badge/Matlab-R2023a-orange)

Proyecto académico para analizar interacciones sociales y académicas en la Universidad Francisco de Vitoria (UFV) mediante teoría de grafos y algoritmos de detección de comunidades.

## Breve Resumen
Este proyecto aplica algoritmo de Louvain para identificar comunidades en redes de interacción entre estudiantes de la UPV. Los datos se modelan como grafos (nodos = individuos, aristas = interacciones) y se analizan con Python (NetworkX) y MATLAB.

## Datos del Formulario
Hemos recopilado 150 respuestas de estudiantes de la UFV (después del filtrado de ruido) con la siguiente distribución:

### Facultades
- **EPS (Escuela Politécnica Superior)**: 46.7% de los encuestados
- **Ciencias Sociales**: 28.7%
- **Humanidades**: 19.9%
- **Arte y Comunicación**: 3.3%
- **Ciencias de la Salud**: 1.4%

### Distribución por cursos
- **Primer curso**: 41.9%
- **Segundo curso**: 26.7%
- **Tercer curso**: 17.2%
- **Cuarto curso o más**: 14.2%

### Género
- **Mujeres**: 65%
- **Hombres**: 35%

### Canales de interacción
Los estudiantes utilizan principalmente:
- Clases presenciales (100%)
- WhatsApp (85%)
- Teams (75%)
- Instagram (65%)
- Eventos universitarios (55%)
- Facebook (40%)
- Deportes (25%)


## Estructura del repositorio
├── data/ # Datos de entrada/salida
│ ├── datos_aristas_ufv.csv # Conexiones entre nodos (Source, Target)
│ ├── datos_nodos_ufv.csv # Atributos de cada nodo (ID, Facultad, Género, etc.)
│ └── resultados_formulario.pdf # Datos crudos del formulario
│
├── src/ # Código fuente
│ ├── louvain_deff.py # Script Python para análisis de comunidades
│ └── matlabdef.m # Script MATLAB para generación y visualización inicial
│
├── docs/ # Documentación adicional
│ └── memoria.pdf # Memoria técnica del proyecto (PDF)
│
└── README.md # Este archivo

## Para ejecutar el código

### Requisitos 
- **Python 3.8+** con librerías:
  ```bash
  pip install pandas networkx matplotlib python-louvain

## Autoras
Helena Ventura-Traveset Cervera
Carlota Abad Esteban
Adriana Soria Franco


Universidad Francisco de Vitoria (UFV), Grado en Ingeniería Matemática, 2024



