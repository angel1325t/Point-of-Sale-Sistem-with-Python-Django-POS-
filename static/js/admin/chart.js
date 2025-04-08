// Global variable for each chart
let incomeExpensesChart;
let topProductsChart;
let salesCategoryChart;
let salesPeriodChart;

// Listen for changes in the date filter
document.getElementById('dateFilter').addEventListener('change', function() {
    const selectedFilter = this.value;  // Get the selected value
    updateIncomeExpensesChart(selectedFilter);  // Update Income vs Expenses
    updateTopProductsChart(selectedFilter);     // Update Top Products
    updateSalesCategoryChart(selectedFilter);  // Update Sales by Category
    updateSalesPeriodChart(selectedFilter, 'line');  // Update Sales by Period
});

// Function to update Income vs Expenses chart
function updateIncomeExpensesChart(filter) {
    fetch(`/income_expenses_data/?filter=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (incomeExpensesChart) incomeExpensesChart.destroy();  // Destroy previous chart
            const ctx = document.getElementById('incomeExpensesChart').getContext('2d');
            incomeExpensesChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [
                        {
                            label: 'Income',
                            data: data.income,
                            backgroundColor: 'rgba(0, 123, 255, 0.6)',
                        },
                        {
                            label: 'Expenses',
                            data: data.expenses,
                            backgroundColor: 'rgba(220, 53, 69, 0.6)',
                        },
                    ],
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                        },
                    },
                },
            });
        });
}

// Function to update Top Products chart
function updateTopProductsChart(filter) {
    fetch(`/top_products_data/?filter=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (topProductsChart) topProductsChart.destroy();  // Destroy previous chart
            const ctx = document.getElementById('topProductsChart').getContext('2d');
            topProductsChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Top Products',
                        data: data.data,
                        backgroundColor: 'rgba(40, 167, 69, 0.6)',
                    }],
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                        },
                    },
                },
            });
        });
}

// Function to update Sales by Category chart
function updateSalesCategoryChart(filter) {
    fetch(`/sales_by_category_data/?filter=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (salesCategoryChart) salesCategoryChart.destroy();  // Destroy previous chart
            const ctx = document.getElementById('salesCategoryChart').getContext('2d');
            salesCategoryChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Sales by Category',
                        data: data.data,
                        backgroundColor: ['rgba(255, 159, 64, 0.6)', 'rgba(255, 99, 132, 0.6)', 'rgba(54, 162, 235, 0.6)', 'rgba(75, 192, 192, 0.6)'],
                    }],
                },
                options: {
                    responsive: true,
                },
            });
        });
}

// Function to update Sales by Period chart
function updateSalesPeriodChart(filter, chartType) {
    fetch(`/chart_data/?filter=${filter}`)
        .then(response => response.json())
        .then(data => {
            if (salesPeriodChart) salesPeriodChart.destroy();  // Destroy previous chart
            const ctx = document.getElementById('salesPeriodChart').getContext('2d');
            salesPeriodChart = new Chart(ctx, {
                type: chartType,
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Sales',
                        data: data.values,
                        borderColor: 'rgba(153, 102, 255, 1)',
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        fill: chartType === 'line',  // Only fill for line chart
                    }],
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                        },
                    },
                },
            });
        });
}
// Inicializar todos los gráficos con un filtro por defecto (mensual)
updateIncomeExpensesChart('monthly');
updateTopProductsChart('monthly');
updateSalesCategoryChart('monthly');
updateSalesPeriodChart('monthly', 'line');
