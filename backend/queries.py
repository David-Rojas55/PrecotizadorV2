from backend.db_connection import get_connection

def obtener_NombreEstados():

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
    SELECT NombreEstado
    FROM estado
    """

    cursor.execute(query)
    NombreEstados = cursor.fetchall()

    conn.close()

    return NombreEstados

def obtener_NombreMarcas():

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
    SELECT IdMarca, NombreMarca
    FROM marca
    """

    cursor.execute(query)
    NombreMarcas = cursor.fetchall()

    conn.close()

    return NombreMarcas

def obtener_NombreModelos(id_marca):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
    SELECT IdModelo, NombreModelo
    FROM modelo
    """

    cursor.execute(query, (id_marca,))
    NombreModelos = cursor.fetchall()

    conn.close()

    return NombreModelos

def obtener_modelos_por_marca(id_marca):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
    SELECT IdModelo, NombreModelo
    FROM modelo
    WHERE IdMarca = %s
    """

    cursor.execute(query, (id_marca,))
    modelos = cursor.fetchall()

    conn.close()

    return modelos

def obtener_descripcion_por_modelo(id_modelo):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
    SELECT CodigoProducto AS IdProducto, DescripcionProducto AS Descripcion
    FROM Producto
    WHERE IdModelo = %s
    """

    cursor.execute(query, (id_modelo,))
    productos = cursor.fetchall()

    conn.close()

    return productos
