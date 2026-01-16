UI::ParsedHTMLString = "
<section class=\"bg-white\">
    <div>
        <h4>
            Ejemplo de boton para expxortar gráficas
        </h4>
        <p>
            El ejemplo incluye una gráfica reactiva en la cual se puede visualizar los datos además de modificar el rango de fechas que son visibles.
            El boton que exporta la gráfica a un archivo PNG funciona haciendo una gráfica estátita y posteriormente la exporta, esto se hizo de esta manera
            debido a que una gráfica reativa no puede ser exportada directamente. Finalmente la gráfica se exporta según el rango de fechas seleccionado y 
            debería funcionar para distintos usuarios que esten consultado la gráfica al mismo tiempo.
        </p>
    </div>

    <!-- Plot -->
    <div class=\"row\">
        <div style=\"height: 80vh; width: 100%\"class=\"st-module st-col col\">
            <div class=\"full-height column\">
                <div class=\"flex justify-end\">
                    <q-btn 
                        label=\"Descargar gráfica\" 
                        unelevated  
                        class=\"q-mb-md\"
                        target=\"_blank\"
                        :href=\"dl_url\"
                        style=\"background-color:#00457f; color:white;\">
                    </q-btn>
                </div>
                
                <div :data-jscall-id=\"fig1.js_id1\">
                    <canvas style=\"display: block\" :data-jscall-id=\"fig1.js_id2\" tabindex=\"0\"></canvas>
                 </div>

            </div>
        </div>
    </div>
</section>
"