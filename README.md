# proyectointegrador1
# Detección de Comunidades en Redes de la UFV

![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![NetworkX](https://img.shields.io/badge/NetworkX-2.6.3-green)
![Matlab](https://img.shields.io/badge/Matlab-R2023a-orange)

Proyecto académico para analizar interacciones sociales y académicas en la Universidad Francisco de Vitoria (UFV) mediante teoría de grafos y algoritmos de detección de comunidades.

## Breve Resumen
Este proyecto aplica algoritmos como el de Louvain para identificar comunidades en redes de interacción entre estudiantes de la UFV. Los datos se modelan como grafos (nodos = individuos, aristas = interacciones) y se analizan con Python (NetworkX) y MATLAB.

Los Objetivos principales:
- Identificar comunidades naturales.
- Analizar patrones de conexión.
- Proponer mejoras para la integración universitaria.


## La Estructura del repositorio
.
├── data/ # Datos de entrada/salida
│ ├── datos_aristas_ufv.csv # Conexiones entre nodos (Source, Target)
│ └── datos_nodos_ufv.csv # Atributos de cada nodo (ID, Facultad, Género, etc.)
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

### Requisitos previos
- **Python 3.8+** con librerías:
  ```bash
  pip install pandas networkx matplotlib python-louvain

## Autoras
Helena Ventura-Traveset Cervera
Carlota Abad Esteban
Adriana Soria Franco


Universidad Francisco de Vitoria (UFV), Grado en Ingeniería Matemática, 2024



