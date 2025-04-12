// Function to calculate and update the return summary
function updateReturnSummary() {
    let subtotalProducts = 0;
    let totalDiscounts = 0;
  
    // Select all table rows across all tables
    const rows = document.querySelectorAll('table tbody tr');
  
    rows.forEach(row => {
      const checkbox = row.querySelector('.item-checkbox');
      if (checkbox && checkbox.checked) {
        // Get quantity
        const quantityInput = row.querySelector('.cantidad-input');
        const quantity = quantityInput ? parseInt(quantityInput.value, 10) : 0;
  
        // Get unit price and parse it
        const priceCell = row.querySelector('.precio-unitario');
        let price = 0;
        if (priceCell) {
          const priceText = priceCell.textContent.trim();
          price = parseFloat(priceText.replace(/[^0-9.-]+/g, "")) || 0;
        }
  
        // Get discount percentage and parse it
        const discountCell = row.querySelector('.descuento-porcentaje');
        let discountPercentage = 0;
        if (discountCell) {
          const discountText = discountCell.textContent.trim();
          discountPercentage = parseFloat(discountText.replace('%', '')) || 0;
        }
  
        // Calculate subtotal and discount for this product
        const productSubtotal = quantity * price;
        const productDiscount = (productSubtotal * discountPercentage) / 100;
  
        // Accumulate totals
        subtotalProducts += productSubtotal;
        totalDiscounts += productDiscount;
      }
    });
  
    // Calculate ITBIS (18%) and total to return
    const itbis = subtotalProducts * 0.18;
    const totalReturn = subtotalProducts + itbis - totalDiscounts;
  
    // Update the summary in the DOM
    document.getElementById('subtotal-products').textContent = `$${subtotalProducts.toFixed(2)}`;
    document.getElementById('itbis').textContent = `$${itbis.toFixed(2)}`;
    document.getElementById('discounts').textContent = `-$${totalDiscounts.toFixed(2)}`;
    document.getElementById('total-return').textContent = `$${totalReturn.toFixed(2)}`;
  }
  
  // Handle "select-all" checkbox for each table
  const selectAllCheckboxes = document.querySelectorAll('#select-all');
  selectAllCheckboxes.forEach(selectAll => {
    selectAll.addEventListener('change', function () {
      const table = selectAll.closest('table');
      const checkboxes = table.querySelectorAll('.item-checkbox');
      checkboxes.forEach(checkbox => {
        checkbox.checked = selectAll.checked;
      });
      updateReturnSummary();
    });
  });
  
  // Add event listeners to individual checkboxes
  const checkboxes = document.querySelectorAll('.item-checkbox');
  checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', function () {
      // Uncheck "select-all" if any item is deselected
      const table = checkbox.closest('table');
      const selectAll = table.querySelector('#select-all');
      if (selectAll && !checkbox.checked) {
        selectAll.checked = false;
      }
      updateReturnSummary();
    });
  });
  
  // Add event listeners to quantity inputs
  const quantityInputs = document.querySelectorAll('.cantidad-input');
  quantityInputs.forEach(input => {
    input.addEventListener('input', updateReturnSummary);
  });
  
  // Initialize the summary on page load
  window.addEventListener('load', updateReturnSummary);