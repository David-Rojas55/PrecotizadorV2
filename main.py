from flask import Flask, render_template, request, jsonify
# from backend.cotizador import cotizar_envio
from backend.queries import obtener_NombreEstados, obtener_NombreMarcas, obtener_modelos_por_marca, obtener_descripcion_por_modelo, obtener_NombreModelos

app = Flask(__name__)


@app.route("/login")
def login():
    return render_template("login.html")


@app.route("/cotizador")
def cotizador():

    NombreEstados = obtener_NombreEstados()
    NombreMarcas = obtener_NombreMarcas()

    return render_template(
        "cotizador.html",
        estados=NombreEstados,
        marcas=NombreMarcas,
    )


@app.route("/obtener-modelos/<id_marca>")
def get_modelos(id_marca):
    modelos = obtener_modelos_por_marca(id_marca)
    return jsonify(modelos)


@app.route("/obtener-descripcion/<id_modelo>")
def get_descripcion(id_modelo):
    # asegurarse de que id_modelo se interpreta como entero
    try:
        id_int = int(id_modelo)
    except ValueError:
        return jsonify([]), 400
    productos = obtener_descripcion_por_modelo(id_int)
    return jsonify(productos)


if __name__ == "__main__":
    app.run(debug=True)
