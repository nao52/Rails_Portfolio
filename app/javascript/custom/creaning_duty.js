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

  const createGroupBtn = document.querySelector('#create-group-btn');
  const numOfStudents = document.querySelector('.num-of-students');

  createGroupBtn.addEventListener('click', () => {
    // table内容の削除
    const tableContent = document.querySelectorAll('.cleaning-duty tbody tr');
    clearTableContents(tableContent);
    
    // tableの内容を新しく作成する
    const numberOfGroup = document.querySelector('#number-of-group');
    const tbody = document.querySelector('.cleaning-duty tbody');
    for (let i = 0; i < numberOfGroup.value; i++) {
      const tr = document.createElement('tr');

      // inputの作成
      const input = document.createElement('input');
      input.setAttribute('type', 'text');
      input.setAttribute('placeholder', '掃除担当場所');

      // selectを2つ作成
      const select1 = createSelect(10);
      const select2 = createSelect(10);

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
    // 生徒数の表示を変更
    numOfStudents.textContent = numberOfGroup.value * 8;
  });

});