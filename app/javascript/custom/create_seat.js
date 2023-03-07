'use strict';

{
  document.addEventListener("turbo:load", () => {
    function createSeats() {
      document.querySelectorAll('#seats tr').forEach(tr => {
        tr.remove();
      });

      for (let row = 1; row <= rowNumber.value; row++) {
        const tr = document.createElement('tr');
        for (let col = 1; col <= colNumber.value; col++) {
          const td = document.createElement('td');
          td.textContent = `生徒${col + (row - 1) * colNumber.value}`
          tr.appendChild(td);
        }
        seats.appendChild(tr);
      }
    }

    const createSeatBtn = document.querySelector('#create-seat-btn');
    const colNumber = document.querySelector('#col-number');
    const rowNumber = document.querySelector('#row-number');
    const seats = document.querySelector('#seats');
  
    createSeatBtn.addEventListener('click', () => {
      createSeats();
    });
  });
}
