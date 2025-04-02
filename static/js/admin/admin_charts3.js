document.addEventListener("DOMContentLoaded", () => {
    const ctx = document.getElementById("ventasChart");
    if (!ctx) {
        console.error("No se encontró el elemento #ventasChart en el DOM");
        return;
    }
    const ctx2d = ctx.getContext("2d");
    const selectFiltro = document.getElementById("filtroFechas");
    const selectTipo = document.getElementById("tipoGrafico");
    let ventasChart;

    const cargarDatos = async (filtro = "mensual", tipo = "line") => {
        try {
            console.log(`Cargando datos con filtro: ${filtro} y tipo: ${tipo}`);
            const response = await fetch(`/api/chartdata/?filtro=${filtro}`);
            if (!response.ok) throw new Error(`Error ${response.status}: ${await response.text()}`);

            const data = await response.json();
            console.log("Datos recibidos:", data);

            if (ventasChart) ventasChart.destroy();

            const configBase = {
                type: tipo,
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: "Ventas",
                        data: data.values,
                        borderColor: "rgba(55, 90, 127, 1)",
                        backgroundColor: tipo === "line" ? "rgba(55, 90, 127, 0.2)" : "rgba(55, 90, 127, 0.8)",
                        borderWidth: 2,
                        fill: tipo !== "line"
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'top' },
                        title: {
                            display: true,
                            text: `Ventas - Gráfico de ${tipo === "line" ? "Líneas" : "Barras"}`
                        }
                    }
                }
            };

            ventasChart = new Chart(ctx2d, configBase);
            window.ventasChart = ventasChart;
            console.log(`Gráfico de ${tipo} creado exitosamente`);
            return ventasChart;
        } catch (error) {
            console.error("Error al generar el gráfico:", error);
        }
    };

    selectFiltro.addEventListener("change", () => cargarDatos(selectFiltro.value, selectTipo.value));
    selectTipo.addEventListener("change", () => cargarDatos(selectFiltro.value, selectTipo.value));

    cargarDatos();
});