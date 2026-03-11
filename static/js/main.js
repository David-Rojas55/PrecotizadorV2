// ===== Cargar modelos al seleccionar una marca =====
document.addEventListener("DOMContentLoaded", function() {
    const marcaSelect = document.getElementById("marca");
    const modeloSelect = document.getElementById("modelo");
    const descripcionSelect = document.getElementById("descripcion");

    if (marcaSelect) {
        marcaSelect.addEventListener("change", function() {
            const idMarca = this.value;
            
            if (!idMarca) {
                modeloSelect.innerHTML = '<option value="">Selecciona un modelo</option>';
                descripcionSelect.innerHTML = '<option value="">Selecciona una descripción</option>';
                return;
            }
            
            fetch(`/obtener-modelos/${idMarca}`)
                .then(response => response.json())
                .then(data => {
                    modeloSelect.innerHTML = '<option value="">Selecciona un modelo</option>';
                    data.forEach(modelo => {
                        const option = document.createElement("option");
                        option.value = modelo.IdModelo;
                        option.textContent = modelo.NombreModelo;
                        modeloSelect.appendChild(option);
                    });
                })
                .catch(error => console.error("Error al obtener modelos:", error));
        });
    }

    // ===== Cargar descripciones al seleccionar un modelo =====
    if (modeloSelect) {
        modeloSelect.addEventListener("change", function() {
            const idModelo = this.value;
            // Reset descriptions immediately to default when any change occurs
            descripcionSelect.innerHTML = '<option value="">Selecciona una descripción</option>';
            
            if (!idModelo) {
                // nothing more to do
                return;
            }
            
            fetch(`/obtener-descripcion/${idModelo}`)
                .then(response => response.json())
                .then(data => {
                    // already reset above; just append received options
                    data.forEach(producto => {
                        const option = document.createElement("option");
                        option.value = producto.IdProducto;
                        option.textContent = producto.Descripcion;
                        descripcionSelect.appendChild(option);
                    });
                })
                .catch(error => console.error("Error al obtener descripciones:", error));
        });
    }
});
