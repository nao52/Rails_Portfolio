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
          const seatNo = col + (row - 1) * colNumber.value;

          const td = document.createElement('td');
          const input = document.createElement('input');
          input.classList.add('student-name');
          input.setAttribute('id', `set-name${seatNo}`);
          input.setAttribute('type', 'text');
          input.setAttribute('value', `生徒${seatNo}`);

          const label1 = document.createElement('label');
          label1.textContent = '使用しない';
          const label2 = document.createElement('label');
          label2.textContent = '固定する';

          const checkbox1 = document.createElement('input');
          checkbox1.setAttribute('id', `disable${seatNo}`);
          checkbox1.classList.add('disable-btn');
          checkbox1.setAttribute('type', 'checkbox');
          label1.appendChild(checkbox1);

          const checkbox2 = document.createElement('input');
          checkbox2.setAttribute('id', `fixed${seatNo}`);
          checkbox2.setAttribute('type', 'checkbox');
          label2.appendChild(checkbox2);

          td.appendChild(input);
          td.appendChild(label1);
          td.appendChild(label2);
          tr.appendChild(td);
        }
        seats.appendChild(tr);
      }

      shuffleBtn.classList.remove('hidden');

      studentList = document.querySelectorAll('#seats .student-name');
      setDisabled();
    }

    function setDisabled() {
      for(let i = 1; i <= studentList.length; i++) {
        const disableBtn = document.querySelector(`#disable${i}`);
        const setName = document.querySelector(`#set-name${i}`);
        const fixedBtn = document.querySelector(`#fixed${i}`);
        disableBtn.addEventListener('input', () => {
          if (disableBtn.checked) {
            setName.disabled = true;
            fixedBtn.disabled = true;
          } else {
            setName.disabled = false;
            fixedBtn.disabled = false;
          }
        });
      }
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
      for (let index = 0; index < studentList.length; index++) {
        const disabledSeat = document.querySelector(`#disable${index+1}`);
        const fixedSeat = document.querySelector(`#fixed${index+1}`);
        if (!disabledSeat.checked && !fixedSeat.checked) {
          studentNames.push(studentList[index].value);
        } 
      }
      const shuffleNames = shuffle(studentNames);

      // シャッフルされた名前のみ値に格納する
      for (let index = 0; index < studentList.length; index++) {
        const disabledSeat = document.querySelector(`#disable${index+1}`);
        const fixedSeat = document.querySelector(`#fixed${index+1}`);
        if (!disabledSeat.checked && !fixedSeat.checked) {
          studentList[index].value = shuffleNames[index];
        } else {
          shuffleNames.push(shuffleNames[index]);
        }
      }
    }

    const createSeatBtn = document.querySelector('#create-seat-btn');
    const shuffleBtn = document.querySelector('#shuffle-btn');
    const colNumber = document.querySelector('#col-number');
    const rowNumber = document.querySelector('#row-number');
    const seats = document.querySelector('#seats');

    let studentList;
  
    createSeatBtn.addEventListener('click', () => {
      createSeats();
    });

    shuffleBtn.addEventListener('click', () => {
      shuffleSeats(studentList);
    });


  });
}
