// Variable global para cada gráfico
let ingresosEgresosChart;
let topProductosChart;
let ventasCategoriaChart;
let ventasPeriodoChart;

// Escuchar cambios en el filtro de fechas
document.getElementById('filtroFechas').addEventListener('change', function() {
    const filtroSeleccionado = this.value;  // Obtener el valor seleccionado
    updateIngresosEgresosChart(filtroSeleccionado);  // Actualizar Ingresos vs Egresos
    updateTopProductosChart(filtroSeleccionado);     // Actualizar Top Productos
    updateVentasCategoriaChart(filtroSeleccionado);  // Actualizar Ventas por Categoría
    updateVentasPeriodoChart(filtroSeleccionado, 'line');  // Actualizar Ventas por Período
});

// Función para actualizar Ingresos vs Egresos
function updateIngresosEgresosChart(filtro) {
    fetch(`/ingresos_egresos_data/?filtro=${filtro}`)
        .then(response => response.json())
        .then(data => {
            if (ingresosEgresosChart) ingresosEgresosChart.destroy();  // Destruir gráfico anterior
            const ctx = document.getElementById('ingresosEgresosChart').getContext('2d');
            ingresosEgresosChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [
                        {
                            label: 'Ingresos',
                            data: data.ingresos,
                            backgroundColor: 'rgba(0, 188, 140, 0.3)',
                            borderColor: 'rgba(0, 188, 140, 1)',
                            borderWidth: 1
                        },
                        {
                            label: 'Egresos',
                            data: data.egresos,
                            backgroundColor: 'rgba(231, 76, 60, 0.3)',
                            borderColor: 'rgba(231, 76, 60, 1)',
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        })
        .catch(error => console.error('Error al obtener los datos:', error));
}

// Función para actualizar Top 5 Productos Más Vendidos
function updateTopProductosChart(filtro) {
    fetch(`/top_productos_data/?filtro=${filtro}`)
        .then(response => response.json())
        .then(data => {
            if (topProductosChart) topProductosChart.destroy();  // Destruir gráfico anterior
            const ctx = document.getElementById('topProductosChart').getContext('2d');
            topProductosChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Cantidad Vendida',
                        data: data.data,
                        backgroundColor: 'rgba(34, 52, 185, 0.3)',
                        borderColor: '#2234B9',
                        borderWidth: 1
                    }]
                },
                options: {
                    indexAxis: 'y', // Barras horizontales
                    scales: {
                        x: { beginAtZero: true }
                    }
                }
            });
        })
        .catch(error => console.error('Error al obtener los datos:', error));
}

// Función para actualizar Ventas por Categoría
function updateVentasCategoriaChart(filtro) {
    fetch(`/ventas_por_categoria_data/?filtro=${filtro}`)
        .then(response => response.json())
        .then(data => {
            if (ventasCategoriaChart) ventasCategoriaChart.destroy();  // Destruir gráfico anterior
            const ctx = document.getElementById('ventasCategoriaChart').getContext('2d');
            ventasCategoriaChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Ventas por Categoría',
                        data: data.data,
                        backgroundColor: [
                            'rgba(34, 52, 185, 0.4)',
                            'rgba(0, 188, 140, 0.4)',
                            'rgba(231, 76, 60, 0.4)',
                            'rgba(243, 156, 18, 0.4)',
                            'rgba(142, 68, 173, 0.4)'
                        ],
                        borderColor: [
                            'rgba(55, 90, 127, 1)',
                            'rgba(0, 188, 140, 1)',
                            'rgba(231, 76, 60, 1)',
                            'rgba(243, 156, 18, 1)',
                            'rgba(142, 68, 173, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    indexAxis: 'y', // Barras horizontales
                    responsive: true,
                    scales: {
                        x: { beginAtZero: true }
                    }
                }
            });
        })
        .catch(error => console.error('Error al obtener los datos:', error));
}

// Función para actualizar Ventas por Período (ya existente, renombrada para consistencia)
function updateVentasPeriodoChart(filtro, tipo) {
    fetch(`/api/chartdata/?filtro=${filtro}`)
        .then(response => response.json())
        .then(data => {
            if (ventasPeriodoChart) ventasPeriodoChart.destroy();

            const ctx = document.getElementById('ventasPeriodoChart').getContext('2d');

            // Gradiente azul desde arriba hacia abajo
            const gradient = ctx.createLinearGradient(0, 0, 0, 400);
            gradient.addColorStop(0, 'rgba(231, 76, 60, 0.4)');  // más oscuro arriba
            gradient.addColorStop(1, 'rgba(231, 76, 60, 1)');  // más claro abajo

            ventasPeriodoChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: '',
                        data: data.values,
                        backgroundColor: gradient,
                        borderColor: 'rgba(231, 76, 60, 1)',
                        borderWidth: 0,
                        fill: true,
                        pointRadius: 0,
                        tension: 0.3
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false },
                        tooltip: { enabled: false }
                    },
                    scales: {
                        x: { display: false },
                        y: { display: true }
                    },
                    elements: {
                        line: { borderWidth: 0 }
                    }
                }
            });
        })
        .catch(error => console.error('Error al obtener los datos:', error));
}



// Inicializar todos los gráficos con un filtro por defecto (mensual)
updateIngresosEgresosChart('mensual');
updateTopProductosChart('mensual');
updateVentasCategoriaChart('mensual');
updateVentasPeriodoChart('mensual', 'line');