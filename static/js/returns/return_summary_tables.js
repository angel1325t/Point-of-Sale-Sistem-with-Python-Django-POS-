// return_summary_tables.js
document.addEventListener('DOMContentLoaded', function() {
    function initializeTable(table, facturaId) {
      const selectAllCheckbox = table.querySelector('.select-all');
      const itemCheckboxes = table.querySelectorAll('.item-checkbox');
  
      if (!selectAllCheckbox || itemCheckboxes.length === 0) {
        console.warn('No se encontraron checkboxes en la tabla:', table);
        return;
      }
  
      selectAllCheckbox.addEventListener('change', function() {
        itemCheckboxes.forEach(cb => {
          cb.checked = this.checked;
        });
        updateReturnSummary(facturaId);
      });
  
      itemCheckboxes.forEach(cb => {
        cb.addEventListener('change', () => {
          const allChecked = [...itemCheckboxes].every(cb => cb.checked);
          selectAllCheckbox.checked = allChecked;
          updateReturnSummary(facturaId);
        });
      });
  
      const quantityInputs = table.querySelectorAll('.cantidad-input');
      quantityInputs.forEach(input => {
        input.addEventListener('input', () => updateReturnSummary(facturaId));
      });
    }
  
    function updateReturnSummary(facturaId) {
      let subtotalProducts = 0;
      let totalDiscounts = 0;
  
      const table = document.querySelector(`table[data-factura-id="${facturaId}"]`);
      if (!table) {
        console.warn(`No se encontró tabla para factura ID: ${facturaId}`);
        return;
      }
  
      const rows = table.querySelectorAll('tbody tr');
      rows.forEach(row => {
        const checkbox = row.querySelector('.item-checkbox');
        if (checkbox && checkbox.checked) {
          const quantityInput = row.querySelector('.cantidad-input');
          const quantity = quantityInput ? parseInt(quantityInput.value, 10) || 0 : 0;
  
          const priceCell = row.querySelector('.precio-unitario');
          let price = 0;
          if (priceCell) {
            const priceText = priceCell.textContent.trim();
            price = parseFloat(priceText.replace(/[^0-9.-]+/g, '')) || 0;
          } else {
            console.warn('No se encontró precio-unitario en la fila:', row);
          }
  
          const discountCell = row.querySelector('.descuento-porcentaje');
          let discountPercentage = 0;
          if (discountCell) {
            const discountText = discountCell.textContent.trim();
            discountPercentage = parseFloat(discountText.replace('%', '')) || 0;
          }
  
          const productSubtotal = quantity * price;
          const productDiscount = (productSubtotal * discountPercentage) / 100;
  
          subtotalProducts += productSubtotal;
          totalDiscounts += productDiscount;
        }
      });
  
      const itbis = (subtotalProducts - totalDiscounts) * 0.18;
      const totalReturn = subtotalProducts + itbis - totalDiscounts;
  
      try {
        document.getElementById(`subtotal-products-${facturaId}`).textContent = `$${subtotalProducts.toFixed(2)}`;
        document.getElementById(`itbis-${facturaId}`).textContent = `$${itbis.toFixed(2)}`;
        document.getElementById(`discounts-${facturaId}`).textContent = `-$${totalDiscounts.toFixed(2)}`;
        document.getElementById(`total-return-${facturaId}`).textContent = `$${totalReturn.toFixed(2)}`;
  
        document.getElementById(`subtotal-hidden-${facturaId}`).value = subtotalProducts.toFixed(2);
        document.getElementById(`impuesto-hidden-${facturaId}`).value = itbis.toFixed(2);
        document.getElementById(`descuento-hidden-${facturaId}`).value = totalDiscounts.toFixed(2);
        document.getElementById(`total-devolver-hidden-${facturaId}`).value = totalReturn.toFixed(2);
      } catch (e) {
        console.error('Error al actualizar el resumen:', e);
      }
    }
  
    const tables = document.querySelectorAll('table');
    tables.forEach(table => {
      const facturaId = table.closest('form').querySelector('input[name="factura_id"]').value;
      table.dataset.facturaId = facturaId;
      initializeTable(table, facturaId);
    });
  
    tables.forEach(table => {
      const facturaId = table.closest('form').querySelector('input[name="factura_id"]').value;
      updateReturnSummary(facturaId);
    });
  });
  