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

  // 配列をシャッフルする
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

  const createGroupBtn = document.querySelector('#create-group-btn');
  const numOfStudentsList = document.querySelectorAll('.num-of-students');
  const createStudentListBtn = document.querySelector('#create-student-list-btn');
  const shuffleBoysBtn = document.querySelector('#shuffle-boys');
  const shuffleGirlsBtn = document.querySelector('#shuffle-girls');
  const clearNamesBtn = document.querySelector('#clear-names');

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

    // 生徒リスト作成ボタンの表示
    createStudentListBtn.classList.remove('hidden');

    // 生徒数を変換した際のイベントを追加
    selectList.forEach(select => {
      select.addEventListener('input', () => {
        updateNumOfStudents();
      });
    });

    // 生徒リストの作成
    createStudentListBtn.addEventListener('click', () => {
      // 生徒名情報の格納
      const boysName = [];
      const girlsName = [];
      document.querySelectorAll('.boysName').forEach( input => {
        boysName.push(input.value);
      });
      document.querySelectorAll('.girlsName').forEach( input => {
        girlsName.push(input.value);
      });

      // table内容の削除
      const tableContent = document.querySelectorAll('.student-list tbody tr');
      clearTableContents(tableContent);

      // tableの内容を新しく作成する
      const numberOfGroup = document.querySelector('#number-of-group');
      const tbody = document.querySelector('.student-list tbody');
      let boysIndex = 0;
      let girlsIndex = 0;

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
          input.classList.add('boysName');
          input.setAttribute('type', 'text');
          input.setAttribute('placeholder', '生徒名');

          // 名前が入力されていた場合はセット
          if (boysName[boysIndex]) {
            input.setAttribute('value', boysName[boysIndex]);
          } else {
            input.setAttribute('value', `男子生徒${boysIndex+1}`);
          }
          boysIndex++;

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
          input.classList.add('girlsName');
          input.setAttribute('type', 'text');
          input.setAttribute('placeholder', '生徒名');

          // 名前が入力されていた場合はセット
          if (girlsName[girlsIndex]) {
            input.setAttribute('value', girlsName[girlsIndex]);
          } else {
            input.setAttribute('value', `女子生徒${girlsIndex+1}`);
          }
          girlsIndex++;

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

      // シャッフルボタンの表示
      document.querySelector('.student-list-btn').classList.remove('hidden');

      // 男子生徒のシャッフル
      shuffleBoysBtn.addEventListener('click', () => {
        const boysNameArray = [];
        const boysInput = document.querySelectorAll('.boysName');
        boysInput.forEach(input => {
          boysNameArray.push(input.value);
        });
        const shuffledNamesArray = shuffle(boysNameArray);
        for (let i = 0; i < boysInput.length; i++) {
          boysInput[i].value = shuffledNamesArray[i];
        }
      });

      // 女子生徒のシャッフル
      shuffleGirlsBtn.addEventListener('click', () => {
        const girlsNameArray = [];
        const girlsInput = document.querySelectorAll('.girlsName');
        girlsInput.forEach(input => {
          girlsNameArray.push(input.value);
        });
        const shuffledNamesArray = shuffle(girlsNameArray);
        for (let i = 0; i < girlsInput.length; i++) {
          girlsInput[i].value = shuffledNamesArray[i];
        }
      });

      // 生徒名のクリア
      clearNamesBtn.addEventListener('click', () => {
        const studentNames = document.querySelectorAll('.student-list tbody input');
        for (let i = 0; i < studentNames.length; i++) {
          studentNames[i].value = '';
        }
      });
    });

  });

});