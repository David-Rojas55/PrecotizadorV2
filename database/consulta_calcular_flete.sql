-- Consulta para calcular el flete
SELECT 
    p.CodigoProducto,
    p.DescripcionProducto,
    pd.Cantidad,
    p.Peso,
    (p.Largo * p.Ancho * p.Alto) / 5000 AS PesoVolumetrico,
    GREATEST(p.Peso,
            (p.Largo * p.Ancho * p.Alto) / 5000) AS PesoFacturable,
    tf.Costo,
    (pd.Cantidad * tf.Costo) AS CostoEnvioProducto
FROM
    precotizaciondetalle pd
        JOIN
    producto p ON pd.CodigoProducto = p.CodigoProducto
        JOIN
    productopaquete pp ON p.CodigoProducto = pp.CodigoProducto
        JOIN
    tarifaflete tf ON pp.IdPaquete = tf.IdPaquete
WHERE
    tf.IdEstado = 3;
