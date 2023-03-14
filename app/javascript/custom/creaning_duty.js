document.addEventListener("turbo:load", function() {

  // selectを作成する
  function createSelect(numOfOption, numOfSelected = 4) {
      // selectの作成
      const select = document.createElement('select');

      // optionの作成
      for (let j = 0; j <= numOfOption; j++) {
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

  // 掃除担当場所一覧テーブルを削除する
  function clearCleaningGroups() {
    document.querySelectorAll('.cleaning-duty tbody tr').forEach(tr => {
      tr.remove();
    });
  }

  // 生徒一覧テーブルを削除する
  function clearStudentListTable() {
    document.querySelectorAll('.student-list tbody tr').forEach(tr => {
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

  // params[group_size]
  function setGroupSize() {
    const numberOfGroup = document.querySelector('#number-of-group');
    groupSize.value = numberOfGroup.value;
  }

  // params[name]をセット
  function setCleaningPlaceName() {
    const cleaningPlaceInput = document.querySelectorAll('.cleaning-duty .td-1 input');
    let nameValue = [];
    cleaningPlaceInput.forEach(input => {
      if (input.value) {
        nameValue.push(input.value);
      }
    });
    cleaningPlaceName.value = nameValue;
  }

  // params[boys_num]をセット
  function setBoysNum() {
    const boysNumSelect = document.querySelectorAll('.cleaning-duty .td-2 select');
    let numValue = [];
    boysNumSelect.forEach(select => {
      numValue.push(select.value);
    });
    boysNum.value = numValue;
  }

  // params[girls_num]をセット
  function setGirlsNum() {
    const girlsNumSelect = document.querySelectorAll('.cleaning-duty .td-3 select');
    let numValue = [];
    girlsNumSelect.forEach(select => {
      numValue.push(select.value);
    });
    girlsNum.value = numValue;
  }

  // 掃除担当場所の情報を保存するボタンの表示
  function showSaveCleaningPlaceBtn() {
    if (cleaningPlaceName.value.split(',').length === Number(groupSize.value)) {
      saveCleaningPlaceBtn.classList.remove('hidden');
    } else {
      saveCleaningPlaceBtn.classList.add('hidden');
    }
  }

  // 生徒リストテーブルの作成
  function createStudentsList() {
    const tbody = document.querySelector('.student-list tbody');
    const numberOfStudents = calcNumOfStudents();
    for (let studentNum = 1; studentNum <= numberOfStudents; studentNum++) {
      const tr = document.createElement('tr');

      const cleaningPlace = document.createElement('td');
      cleaningPlace.classList.add('td-1');
      tr.appendChild(cleaningPlace);

      const studentName = document.createElement('td');
      studentName.classList.add('td-2');
      const input = document.createElement('input');
      input.setAttribute('type', 'text');
      input.setAttribute('value', `生徒${studentNum}`);
      input.setAttribute('placeholder', '生徒名');
      studentName.appendChild(input);
      tr.appendChild(studentName);

      const sex = document.createElement('td');
      sex.classList.add('td-3');
      tr.appendChild(sex);

      tbody.appendChild(tr);
    }
  }

  // 生徒リストテーブルに値をセット
  function setStudentsList() {
    const cleaningPlacesValue = document.querySelectorAll('.cleaning-duty .td-1 input');
    const boys = document.querySelectorAll('.cleaning-duty .td-2 select');
    const girls = document.querySelectorAll('.cleaning-duty .td-3 select');
    const cleaningPlaces = document.querySelectorAll('.student-list .td-1');
    const sexes = document.querySelectorAll('.student-list .td-3');
    let tableIndex = 0;
    for (let placeNum = 0; placeNum < cleaningPlacesValue.length; placeNum++) {
      for (let i = 0; i < boys[placeNum].value; i++) {
        cleaningPlaces[tableIndex].textContent = cleaningPlacesValue[placeNum].value;
        sexes[tableIndex].textContent = '男子';
        tableIndex++;
      }
      for (let i = 0; i < girls[placeNum].value; i++) {
        cleaningPlaces[tableIndex].textContent = cleaningPlacesValue[placeNum].value;
        sexes[tableIndex].textContent = '女子';
        tableIndex++;
      }
    }
  }

  const createGroupBtn = document.querySelector('#create-group-btn');
  const numOfStudentsList = document.querySelectorAll('.num-of-students');
  const createStudentListBtn = document.querySelector('#create-student-list-btn');
  const shuffleBoysBtn = document.querySelector('#shuffle-boys');
  const shuffleGirlsBtn = document.querySelector('#shuffle-girls');
  const clearNamesBtn = document.querySelector('#clear-names');
  const saveCleaningPlaceBtn = document.querySelector('#save-cleaning-place');
  const groupSize = document.querySelector('#cleaning_place_group_size');
  const cleaningPlaceName = document.querySelector('#cleaning_place_name');
  const boysNum = document.querySelector('#cleaning_place_boys_num');
  const girlsNum = document.querySelector('#cleaning_place_girls_num');

  // データベースから値を取ってきた際の画面表示
  setGroupSize()
  setCleaningPlaceName();
  setBoysNum();
  setGirlsNum();
  updateNumOfStudents()
  showSaveCleaningPlaceBtn();
  if (boysNum.value) {
    createStudentListBtn.classList.remove('hidden');
  }

  // グループ数が変更されたら、parmams[group-size]の値を変更する
  document.querySelector('#number-of-group').addEventListener('input', () => {
    setGroupSize();
    showSaveCleaningPlaceBtn();
  });

  // 掃除場所が入力されたら、params[name]の値を変更する
  document.querySelectorAll('.cleaning-duty .td-1 input').forEach(input => {
    input.addEventListener('input', () => {
      setCleaningPlaceName();
      showSaveCleaningPlaceBtn();
    });
  });

  // 男子の数が変更されたら、params[boys_num]の値を変更する
  document.querySelectorAll('.cleaning-duty .td-2 select').forEach(select => {
    select.addEventListener('input', () => {
      setBoysNum();
    });
  });

  // 女子の数が変更されたら、params[girls_num]の値を変更する
  document.querySelectorAll('.cleaning-duty .td-3 select').forEach(select => {
    select.addEventListener('input', () => {
      setGirlsNum();
    });
  });

  createStudentListBtn.addEventListener('click', () => {
    // 生徒リストテーブルを削除
    clearStudentListTable();

    // 生徒リストテーブルの作成
    createStudentsList();

    // 生徒リストテーブルに値をセット
    setStudentsList();
  });

  createGroupBtn.addEventListener('click', () => {
    // table内容の削除
    clearCleaningGroups();
    
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

    // params[name]の値をリセット
    cleaningPlaceName.value = "";

    // その他のparamsの値をセット
    setBoysNum();
    setGirlsNum();

    // 生徒リスト作成ボタンの表示
    // グループ情報保存ボタンの表示
    createStudentListBtn.classList.remove('hidden');
    saveCleaningPlaceBtn.classList.add('hidden');

    // 生徒数を変換した際のイベントを追加
    selectList.forEach(select => {
      select.addEventListener('input', () => {
        updateNumOfStudents();
        setBoysNum();
        setGirlsNum();
      });
    });

    // 掃除担当場所一覧の値をセット
    const cleaningPlaceInput = document.querySelectorAll('.cleaning-duty .td-1 input');
    cleaningPlaceInput.forEach(input => {
      input.addEventListener('input', () => {
        setCleaningPlaceName();
        // グループ数と担当掃除場所の数が一致したら、ボタンを表示する
        if (cleaningPlaceName.value.split(',').length === Number(groupSize.value)) {
          saveCleaningPlaceBtn.classList.remove('hidden');
        } else {
          saveCleaningPlaceBtn.classList.add('hidden');
        }
      });
    });

    // 生徒リストの作成
    // createStudentListBtn.addEventListener('click', () => {
    //   // 生徒名情報の格納
    //   const boysName = [];
    //   const girlsName = [];
    //   document.querySelectorAll('.boysName').forEach( input => {
    //     boysName.push(input.value);
    //   });
    //   document.querySelectorAll('.girlsName').forEach( input => {
    //     girlsName.push(input.value);
    //   });

    //   // table内容の削除
    //   const tableContent = document.querySelectorAll('.student-list tbody tr');
    //   clearTableContents(tableContent);

    //   // tableの内容を新しく作成する
    //   const numberOfGroup = document.querySelector('#number-of-group');
    //   const tbody = document.querySelector('.student-list tbody');
    //   let boysIndex = 0;
    //   let girlsIndex = 0;

    //   for (let groupI = 1; groupI <= numberOfGroup.value; groupI++) {
    //     const cleaningPlace = document.querySelector(`#cleaning-place${groupI}`);
    //     const numOfBoys = document.querySelector(`#num-of-boys${groupI}`);
    //     const numOfGirls = document.querySelector(`#num-of-girls${groupI}`);

    //     for (let boyI = 1; boyI <= numOfBoys.value; boyI++) {
    //       // trの作成
    //       const tr = document.createElement('tr');

    //       // 担当場所によるクラス名の追加
    //       if (groupI % 2 === 0) {
    //         tr.classList.add('group-even');
    //       } else {
    //         tr.classList.add('group-odd');
    //       }

    //       // inputの作成
    //       const input = document.createElement('input');
    //       input.classList.add('boysName');
    //       input.setAttribute('type', 'text');
    //       input.setAttribute('placeholder', '生徒名');

    //       // 名前が入力されていた場合はセット
    //       if (boysName[boysIndex]) {
    //         input.setAttribute('value', boysName[boysIndex]);
    //       } else {
    //         input.setAttribute('value', `男子生徒${boysIndex+1}`);
    //       }
    //       boysIndex++;

    //       // tdの作成、trへの追加
    //       const td1 = document.createElement('td');
    //       td1.classList.add('td-1');
    //       td1.textContent = cleaningPlace.value;
    //       tr.appendChild(td1);
    //       const td2 = document.createElement('td');
    //       td2.classList.add('td-2');
    //       td2.appendChild(input);
    //       tr.appendChild(td2);
    //       const td3 = document.createElement('td');
    //       td3.classList.add('td-3');
    //       td3.textContent = '男子';
    //       tr.appendChild(td3);

    //       tbody.appendChild(tr);
    //     }

    //     for (let girlI = 1; girlI <= numOfGirls.value; girlI++) {
    //       // trの作成
    //       const tr = document.createElement('tr');

    //       // 担当場所によるクラス名の追加
    //       if (groupI % 2 === 0) {
    //         tr.classList.add('group-even');
    //       } else {
    //         tr.classList.add('group-odd');
    //       }

    //       // inputの作成
    //       const input = document.createElement('input');
    //       input.classList.add('girlsName');
    //       input.setAttribute('type', 'text');
    //       input.setAttribute('placeholder', '生徒名');

    //       // 名前が入力されていた場合はセット
    //       if (girlsName[girlsIndex]) {
    //         input.setAttribute('value', girlsName[girlsIndex]);
    //       } else {
    //         input.setAttribute('value', `女子生徒${girlsIndex+1}`);
    //       }
    //       girlsIndex++;

    //       // tdの作成、trへの追加
    //       const td1 = document.createElement('td');
    //       td1.classList.add('td-1');
    //       td1.textContent = cleaningPlace.value;
    //       tr.appendChild(td1);
    //       const td2 = document.createElement('td');
    //       td2.classList.add('td-2');
    //       td2.appendChild(input);
    //       tr.appendChild(td2);
    //       const td3 = document.createElement('td');
    //       td3.classList.add('td-3');
    //       td3.textContent = '女子';
    //       tr.appendChild(td3);

    //       tbody.appendChild(tr);
    //     }
    //   }

    //   // シャッフルボタンの表示
    //   document.querySelector('.student-list-btn').classList.remove('hidden');

    //   // 男子生徒のシャッフル
    //   shuffleBoysBtn.addEventListener('click', () => {
    //     const boysNameArray = [];
    //     const boysInput = document.querySelectorAll('.boysName');
    //     boysInput.forEach(input => {
    //       boysNameArray.push(input.value);
    //     });
    //     const shuffledNamesArray = shuffle(boysNameArray);
    //     for (let i = 0; i < boysInput.length; i++) {
    //       boysInput[i].value = shuffledNamesArray[i];
    //     }
    //   });

    //   // 女子生徒のシャッフル
    //   shuffleGirlsBtn.addEventListener('click', () => {
    //     const girlsNameArray = [];
    //     const girlsInput = document.querySelectorAll('.girlsName');
    //     girlsInput.forEach(input => {
    //       girlsNameArray.push(input.value);
    //     });
    //     const shuffledNamesArray = shuffle(girlsNameArray);
    //     for (let i = 0; i < girlsInput.length; i++) {
    //       girlsInput[i].value = shuffledNamesArray[i];
    //     }
    //   });

    //   // 生徒名のクリア
    //   clearNamesBtn.addEventListener('click', () => {
    //     const studentNames = document.querySelectorAll('.student-list tbody input');
    //     for (let i = 0; i < studentNames.length; i++) {
    //       studentNames[i].value = '';
    //     }
    //   });
    // });

  });

});