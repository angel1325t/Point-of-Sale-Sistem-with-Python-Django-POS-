// Función para actualizar el resumen en tarjeta con descuento
function updateCardSummary() {
  const saleItems = document.querySelectorAll('#sale-items .product-item');
  const montoInput = document.getElementById('total-card');
  const cardButton = document.getElementById('pay-button-card');

  if (saleItems.length === 0) {
    cardButton?.classList.add('cursor-not-allowed', 'bg-blue-400');
    cardButton?.classList.remove('bg-blue-600', 'bg-[#23328C]', 'hover:bg-[#1a2570]');
    cardButton.disabled = true;
    montoInput.value = "";
    console.log('No hay productos en la lista de venta');
  } else {
    cardButton?.classList.remove('cursor-not-allowed', 'bg-blue-400');
    cardButton?.classList.add('bg-[#23328C]', 'hover:bg-[#1a2570]');
    cardButton.disabled = false;

    const { totalWithTax } = getProductsList();
    montoInput.value = totalWithTax.toFixed(2);
  }
}

// Observador para actualizar los resúmenes cuando cambian los elementos en #sale-items
const saleItemsContainerCard = document.getElementById('sale-items');
const observerCard2 = new MutationObserver(() => {
  updateCardSummary();
});
observerCard2.observe(saleItemsContainerCard, {
  childList: true,
  subtree: true,
});

// 🔧 Llamada inicial para manejar el caso en que ya está vacío al cargar
updateCardSummary();
