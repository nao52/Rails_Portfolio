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
          const input = document.createElement('input');
          input.setAttribute('type', 'text');
          input.setAttribute('value', `生徒${col + (row - 1) * colNumber.value}`);
          td.appendChild(input);
          tr.appendChild(td);
        }
        seats.appendChild(tr);
      }

      shuffleBtn.classList.remove('hidden');
    }

    function shuffle(array) {
      let shuffledArray = [];
      let usedIndexes = [];
      
      let i = 0;
      while (i < array.length) {
        let randomNumber = Math.floor(Math.random() * array.length);
        if (!usedIndexes.includes(randomNumber)) {
          shuffledArray.push(array[randomNumber]);
          usedIndexes.push(randomNumber);
          i++;
        }
      }
      return shuffledArray;
    }

    function shuffleSeats(studentList) {
      let studentNames = []
      studentList.forEach(studentName => {
        studentNames.push(studentName.value);
      });
      const shuffleNames = shuffle(studentNames);

      for (let index = 0; index < studentList.length; index++) {
        studentList[index].value = shuffleNames[index];
      }
    }

    const createSeatBtn = document.querySelector('#create-seat-btn');
    const shuffleBtn = document.querySelector('#shuffle-btn');
    const colNumber = document.querySelector('#col-number');
    const rowNumber = document.querySelector('#row-number');
    const seats = document.querySelector('#seats');
  
    createSeatBtn.addEventListener('click', () => {
      createSeats();
    });

    shuffleBtn.addEventListener('click', () => {
      const studentList = document.querySelectorAll('#seats input');
      shuffleSeats(studentList);
    });

  });
}
