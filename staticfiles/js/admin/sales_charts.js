// Variable global para cada gráfico
let incomeExpenseChart;
let topProductsChart;
let salesByCategoryChart;
let salesOverTimeChart;

// Escuchar cambios en el filtro de fechas
document.getElementById('filtroFechas').addEventListener('change', function() {
    const selectedFilter = this.value;  // Obtener el valor seleccionado
    updateIncomeExpenseChart(selectedFilter);         // Actualizar Ingresos vs Egresos
    updateTopProductsChart(selectedFilter);           // Actualizar Top Productos
    updateSalesByCategoryChart(selectedFilter);       // Actualizar Ventas por Categoría
    updateSalesOverTimeChart(selectedFilter, 'line'); // Actualizar Ventas por Período
    loadGeneralStatistics(selectedFilter);            // Cargar estadísticas generales
});

// Función para cargar estadísticas generales
function loadGeneralStatistics(filter) {
    fetch(`/ventas_estadisticas/?filtro=${filter}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('totalVentas').textContent = data.total_ventas;
            document.getElementById('totalGanancias').textContent = `$${data.total_ganancias.toFixed(2)}`;
            document.getElementById('productoMasVendido').textContent = data.producto_mas_vendido || 'N/A';
            document.getElementById('cantidadVendida').textContent = data.cantidad_vendida || 0;
        })
        .catch(error => console.error('Error al obtener estadísticas:', error));
}

// Función para actualizar Ingresos vs Egresos
function updateIncomeExpenseChart(filter) {
    fetch(`/ingresos_egresos_data/?filtro=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (incomeExpenseChart) incomeExpenseChart.destroy();  // Destruir gráfico anterior
            const ctx = document.getElementById('ingresosEgresosChart').getContext('2d');
            incomeExpenseChart = new Chart(ctx, {
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
function updateTopProductsChart(filter) {
    fetch(`/top_productos_data/?filtro=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (topProductsChart) topProductsChart.destroy();  // Destruir gráfico anterior
            const ctx = document.getElementById('topProductosChart').getContext('2d');
            topProductsChart = new Chart(ctx, {
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
function updateSalesByCategoryChart(filter) {
    fetch(`/ventas_por_categoria_data/?filtro=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (salesByCategoryChart) salesByCategoryChart.destroy();  // Destruir gráfico anterior
            const ctx = document.getElementById('ventasCategoriaChart').getContext('2d');
            salesByCategoryChart = new Chart(ctx, {
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
                        x: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value + '%';
                                }
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.dataset.label + ': ' + context.parsed.x.toFixed(2) + '%';
                                }
                            }
                        }
                    }
                }
            });
        })
        .catch(error => console.error('Error al obtener los datos:', error));
}

// Función para actualizar Ventas por Período
function updateSalesOverTimeChart(filter, type) {
    fetch(`/api/chartdata/?filtro=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (salesOverTimeChart) salesOverTimeChart.destroy(); // Destruir gráfico anterior

            const ctx = document.getElementById('ventasPeriodoChart').getContext('2d');

            // Gradiente azul desde arriba hacia abajo
            const gradient = ctx.createLinearGradient(0, 0, 0, 400);
            gradient.addColorStop(0, 'rgba(231, 76, 60, 0.4)');  // más oscuro arriba
            gradient.addColorStop(1, 'rgba(231, 76, 60, 1)');    // más claro abajo

            salesOverTimeChart = new Chart(ctx, {
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
loadGeneralStatistics('mensual');
updateIncomeExpenseChart('mensual');
updateTopProductsChart('mensual');
updateSalesByCategoryChart('mensual');
updateSalesOverTimeChart('mensual', 'line');
