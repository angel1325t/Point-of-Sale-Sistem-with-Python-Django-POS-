document.addEventListener('DOMContentLoaded', function () {
    // Toggle de filtros
    const filterToggle = document.querySelector('.filter-toggle');
    const filtersContainer = document.querySelector('.filters-container');

    filterToggle.addEventListener('click', function () {
        filtersContainer.classList.toggle('active');
        filterToggle.classList.toggle('active');
    });

    const productsBody = document.getElementById('products-body');
    const allRows = Array.from(productsBody.getElementsByTagName('tr'));

    // Función para limpiar filtros
    function clearFilters() {
        document.getElementById('search').value = '';
        document.getElementById('category').value = '';
        document.getElementById('order_by').value = '';
        document.getElementById('estado').value = '';
        document.getElementById('precio_min').value = '';
        document.getElementById('precio_max').value = '';
        applyFiltersAndSort(); // Reaplicar filtros después de limpiar
    }

    // Función para filtrar en tiempo real
    function applyFiltersAndSort() {
        const search = document.getElementById('search').value.toLowerCase();
        const category = document.getElementById('category').value;
        const orderBy = document.getElementById('order_by').value;
        const estado = document.getElementById('estado').value;
        const precioMin = parseFloat(document.getElementById('precio_min').value) || -Infinity;
        const precioMax = parseFloat(document.getElementById('precio_max').value) || Infinity;

        // Filtrar productos
        let filteredRows = allRows.filter(row => {
            const nombre = row.dataset.nombre;
            const categoria = row.dataset.categoria;
            const stock = parseInt(row.dataset.stock);
            const precio = parseFloat(row.dataset.precio);
            const descripcion = row.dataset.descripcion;
            const marca = row.dataset.marca;

            // Filtro de búsqueda
            const matchesSearch = !search ||
                nombre.includes(search) ||
                descripcion.includes(search) ||
                (marca && marca.toLowerCase().includes(search));

            // Filtro de categoría
            const matchesCategory = !category || categoria === category;

            // Filtro de estado
            const matchesEstado = !estado ||
                (estado === 'en_stock' && stock > 25) ||
                (estado === 'bajo_stock' && stock <= 25 && stock > 0) ||
                (estado === 'agotado' && stock === 0);

            // Filtro de precio
            const matchesPrecio = precio >= precioMin && precio <= precioMax;

            return matchesSearch && matchesCategory && matchesEstado && matchesPrecio;
        });

        // Ordenar productos
        filteredRows.sort((a, b) => {
            const nombreA = a.dataset.nombre;
            const nombreB = b.dataset.nombre;
            const precioA = parseFloat(a.dataset.precio);
            const precioB = parseFloat(b.dataset.precio);

            if (orderBy === 'nombre_asc') return nombreA.localeCompare(nombreB);
            if (orderBy === 'nombre_desc') return nombreB.localeCompare(nombreA);
            if (orderBy === 'precio_asc') return precioA - precioB;
            if (orderBy === 'precio_desc') return precioB - precioA;
            return 0;
        });

        // Limpiar y actualizar la tabla
        productsBody.innerHTML = '';
        if (filteredRows.length > 0) {
            filteredRows.forEach(row => productsBody.appendChild(row));
        } else {
            productsBody.innerHTML = `
                <tr>
                    <td colspan="7" class="px-4 py-4 text-center text-gray-500">
                        <div class="flex flex-col items-center">
                            <img src="{% static 'icons/not_found.svg' %}" alt="No encontrado" class="w-16 h-16">
                            <p class="mt-2 text-lg font-semibold">No se encontraron productos</p>
                            <p class="text-gray-500">Intenta con otra búsqueda o categoría.</p>
                        </div>
                    </td>
                </tr>
            `;
        }
    }

    // Escuchar cambios en tiempo real en los inputs
    const inputs = ['search', 'category', 'order_by', 'estado', 'precio_min', 'precio_max'];
    inputs.forEach(id => {
        const element = document.getElementById(id);
        ['input', 'change'].forEach(event => {
            element.addEventListener(event, applyFiltersAndSort);
        });
    });

    // Añadir evento al botón de limpiar
    document.getElementById('clear-filters').addEventListener('click', clearFilters);

    // Inicializar la aplicación de filtros
    applyFiltersAndSort();
});