document.addEventListener("turbo:load", function() {

  // selectを作成する
  function createSelect(numOfOption, numOfSelected = 4) {
      // selectの作成
      const select = document.createElement('select');

      // optionの作成
      for (let j = 1; j <= numOfOption; j++) {
        const option = document.createElement('option');
        option.value = j;
        option.textContent = j;
        if (j === numOfSelected) {
          option.setAttribute('selected', 'selected');
        }
        select.appendChild(option);
      }

      return select;
  }

  // tableの内容を削除する
  function clearTableContents(tableContent) {
    tableContent.forEach(tr => {
      tr.remove();
    });
  }

  // 生徒数を計算する
  function calcNumOfStudents() {
    const selectList = document.querySelectorAll('.cleaning-duty select');
    let numberOfStudents = 0;
    selectList.forEach(select => {
      numberOfStudents += parseInt(select.value);
    });
    return numberOfStudents;
  }

  // 生徒数の表示を変更する
  function updateNumOfStudents() {
    const numberOfStudents = calcNumOfStudents()
    numOfStudentsList.forEach(numOfStudents => {
      numOfStudents.textContent = numberOfStudents;
    });
  }

  const createGroupBtn = document.querySelector('#create-group-btn');
  const numOfStudentsList = document.querySelectorAll('.num-of-students');
  const createStudentListBtn = document.querySelector('#create-student-list-btn');

  createGroupBtn.addEventListener('click', () => {
    // table内容の削除
    const tableContent = document.querySelectorAll('.cleaning-duty tbody tr');
    clearTableContents(tableContent);
    
    // tableの内容を新しく作成する
    const numberOfGroup = document.querySelector('#number-of-group');
    const tbody = document.querySelector('.cleaning-duty tbody');
    for (let i = 1; i <= numberOfGroup.value; i++) {
      // trの作成
      const tr = document.createElement('tr');

      // inputの作成
      const input = document.createElement('input');
      input.setAttribute('id', `cleaning-place${i}`);
      input.setAttribute('type', 'text');
      input.setAttribute('placeholder', '掃除担当場所');

      // selectを2つ作成
      const select1 = createSelect(10);
      select1.setAttribute('id', `num-of-boys${i}`);
      const select2 = createSelect(10);
      select2.setAttribute('id', `num-of-girls${i}`);

      // tdの作成、trへの追加
      const td1 = document.createElement('td');
      td1.classList.add('td-1');
      td1.appendChild(input);
      tr.appendChild(td1);
      const td2 = document.createElement('td');
      td2.classList.add('td-2');
      td2.appendChild(select1);
      tr.appendChild(td2);
      const td3 = document.createElement('td');
      td3.classList.add('td-3');
      td3.appendChild(select2);
      tr.appendChild(td3);

      tbody.appendChild(tr);
    }

    const selectList = document.querySelectorAll('.cleaning-duty select');
    
    // 生徒数の表示を変更
    updateNumOfStudents();

    // 生徒数を変換した際のイベントを追加
    selectList.forEach(select => {
      select.addEventListener('input', () => {
        updateNumOfStudents();
      });
    });

    createStudentListBtn.addEventListener('click', () => {
      // table内容の削除
      const tableContent = document.querySelectorAll('.student-list tbody tr');
      clearTableContents(tableContent);

      // tableの内容を新しく作成する
      const numberOfGroup = document.querySelector('#number-of-group');
      const tbody = document.querySelector('.student-list tbody');
      for (let groupI = 1; groupI <= numberOfGroup.value; groupI++) {
        const cleaningPlace = document.querySelector(`#cleaning-place${groupI}`);
        const numOfBoys = document.querySelector(`#num-of-boys${groupI}`);
        const numOfGirls = document.querySelector(`#num-of-girls${groupI}`);

        for (let boyI = 1; boyI <= numOfBoys.value; boyI++) {
          // trの作成
          const tr = document.createElement('tr');

          // 担当場所によるクラス名の追加
          if (groupI % 2 === 0) {
            tr.classList.add('group-even');
          } else {
            tr.classList.add('group-odd');
          }

          // inputの作成
          const input = document.createElement('input');
          input.setAttribute('type', 'text');
          input.setAttribute('placeholder', '生徒名');

          // tdの作成、trへの追加
          const td1 = document.createElement('td');
          td1.classList.add('td-1');
          td1.textContent = cleaningPlace.value;
          tr.appendChild(td1);
          const td2 = document.createElement('td');
          td2.classList.add('td-2');
          td2.appendChild(input);
          tr.appendChild(td2);
          const td3 = document.createElement('td');
          td3.classList.add('td-3');
          td3.textContent = '男子';
          tr.appendChild(td3);

          tbody.appendChild(tr);
        }

        for (let girlI = 1; girlI <= numOfGirls.value; girlI++) {
          // trの作成
          const tr = document.createElement('tr');

          // 担当場所によるクラス名の追加
          if (groupI % 2 === 0) {
            tr.classList.add('group-even');
          } else {
            tr.classList.add('group-odd');
          }

          // inputの作成
          const input = document.createElement('input');
          input.setAttribute('type', 'text');
          input.setAttribute('placeholder', '生徒名');

          // tdの作成、trへの追加
          const td1 = document.createElement('td');
          td1.classList.add('td-1');
          td1.textContent = cleaningPlace.value;
          tr.appendChild(td1);
          const td2 = document.createElement('td');
          td2.classList.add('td-2');
          td2.appendChild(input);
          tr.appendChild(td2);
          const td3 = document.createElement('td');
          td3.classList.add('td-3');
          td3.textContent = '女子';
          tr.appendChild(td3);

          tbody.appendChild(tr);
        }
      }
    });

  });

});