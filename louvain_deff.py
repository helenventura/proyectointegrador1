import pandas as pd
import networkx as nx
import os

# 1. Especifica las rutas exactas con los nombres correctos
ruta_base = r'C:\Users\Helena\OneDrive\Escritorio\Uni\1º\segundo_cuatri\proyecto_integrador1\UFV_redes'
ruta_nodos = os.path.join(ruta_base, 'datos_nodos_ufv.csv')
ruta_aristas = os.path.join(ruta_base, 'datos_aristas_ufv.csv')

# 2. Verificación de que los archivos existen
print(f"Verificando nodos en: {ruta_nodos}")
print(f"Verificando aristas en: {ruta_aristas}")

if not os.path.exists(ruta_nodos):
    raise FileNotFoundError(f"ERROR: No se encontró 'datos_nodos_ufv.csv' en:\n{ruta_nodos}")

if not os.path.exists(ruta_aristas):
    raise FileNotFoundError(f"ERROR: No se encontró 'datos_aristas_ufv.csv' en:\n{ruta_aristas}")

# 3. Cargar los datos con los nombres correctos
try:
    nodos_df = pd.read_csv(ruta_nodos, encoding='utf-8')
    aristas_df = pd.read_csv(ruta_aristas, encoding='utf-8')
    print("¡Archivos cargados correctamente!")
except Exception as e:
    print(f"Error al cargar archivos: {str(e)}")
    exit()

# 4. Crear el grafo (ejemplo básico)
G = nx.Graph()

# Añadir nodos
for _, row in nodos_df.iterrows():
    G.add_node(row['ID'], **row.to_dict())

# Añadir aristas (usando los nombres de columnas correctos)
for _, row in aristas_df.iterrows():
    G.add_edge(row['Source'], row['Target'], weight=1)

print(f"Grafo creado con {G.number_of_nodes()} nodos y {G.number_of_edges()} aristas")

# ===== AÑADE ESTO AL FINAL DEL ARCHIVO =====
import matplotlib.pyplot as plt

# Configuración de visualización
plt.figure(figsize=(15, 15))  # Tamaño más grande para mejor visualización

# Diseño del grafo (usando spring layout)
pos = nx.spring_layout(G, k=0.15, iterations=50, seed=42)  # k controla la distancia entre nodos

# Dibujar el grafo con opciones optimizadas
nx.draw(G, pos,
        with_labels=True,
        node_size=80,
        font_size=7,
        font_color='black',
        edge_color='gray',
        alpha=0.7)

plt.title("Red UFV - Visualización del Grafo", fontsize=14)
plt.tight_layout()  # Ajusta los márgenes

# Mostrar el gráfico
plt.show()
# ===== FIN DEL CÓDIGO A AÑADIR =====