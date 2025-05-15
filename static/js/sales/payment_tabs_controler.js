document.addEventListener('DOMContentLoaded', function () {
  const cashTab = document.getElementById('cash-tab');
  const cardTab = document.getElementById('card-tab');
  const transferTab = document.getElementById('transfer-tab');
  const cashContent = document.getElementById('contenedor_cash');
  const cardContent = document.getElementById('card-payment');
  const transferContent = document.getElementById('multistep-form');
  const cashPayment = document.getElementById('cash-payment');

  // Verificar que los elementos existen
  if (!cashTab || !cardTab || !transferTab) {
    console.error('No se encontraron los elementos de tabs');
    return;
  }

  // Función para cambiar la visibilidad de los contenidos de los tabs
  function changeTab(tab) {
    // Ocultar todos los contenidos
    cashContent?.classList.add('hidden');
    cardContent?.classList.add('hidden');
    transferContent?.classList.add('hidden');
    cashPayment?.classList.add('hidden'); // Ocultar por defecto

    // Quitar clase 'active' de todos los tabs
    cashTab.classList.remove('active');
    cardTab.classList.remove('active');
    transferTab.classList.remove('active');

    // Mostrar el contenido correspondiente al tab seleccionado y agregar clase 'active'
    if (tab === 'cash') {
      cashContent?.classList.remove('hidden');
      cashTab.classList.add('active');
      cashPayment?.classList.remove('hidden'); // Mostrar solo en efectivo
    } else if (tab === 'card') {
      cardContent?.classList.remove('hidden');
      cardTab.classList.add('active');
    } else if (tab === 'transfer') {
      transferContent?.classList.remove('hidden');
      transferTab.classList.add('active');
    }
  }

  // Asignar eventos de clic a los tabs
  cashTab.addEventListener('click', function () {
    changeTab('cash');
  });

  cardTab.addEventListener('click', function () {
    changeTab('card');
  });

  transferTab.addEventListener('click', function () {
    changeTab('transfer');
  });

  // Inicializar con el tab de 'efectivo' seleccionado
  changeTab('cash');
});
