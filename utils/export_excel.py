import pandas as pd
import mysql.connector

conexion = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="precotizador_fletes"
)

query = """
SELECT 
m.NombreMarca,
mo.NombreModelo,
p.DescripcionProducto,
p.Largo,
p.Ancho,
p.Alto,
p.Peso,
pd.Cantidad,
p.PrecioUSD
FROM precotizaciondetalle pd
JOIN producto p ON pd.CodigoProducto = p.CodigoProducto
JOIN modelo mo ON p.IdModelo = mo.IdModelo
JOIN marca m ON mo.IdMarca = m.IdMarca
"""

df = pd.read_sql(query, conexion)

df.to_excel("precotizacion.xlsx", index=False)