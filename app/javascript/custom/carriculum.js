'use strict';

{
  document.addEventListener("turbo:load", () => {
    // params[carriculum_schedule]をセット
    function setCarriculumSchedule() {
      let carriculumScheduleValue = [];
      let carriculumScheduleNames = [];
      schedules.forEach (schedule => {
        if (schedule.value) {
          carriculumScheduleValue.push(schedule.value);
          const index = schedule.selectedIndex;
          carriculumScheduleNames.push(schedule[index].textContent);
        }
      });
      carriculumSchedule.value = carriculumScheduleValue;

      // 全て入力済みなら、ボタンを表示
      if (carriculumScheduleValue.length === 30) {
        saveScheduleBtn.classList.remove('hidden');
        calcAbsentForm.classList.remove('hidden');
        absentTable.classList.remove('hidden');
      } else {
        saveScheduleBtn.classList.add('hidden');
        calcAbsentForm.classList.add('hidden');
        absentTable.classList.add('hidden');
      }

      // 作成したカリキュラムリストを返す
      return carriculumScheduleNames;
    }

    // 欠時数を計算して返す
    function calcAbsent() {
      let absentsOfCarriculm = {};
      const absentCounts = document.querySelectorAll('.absent-counts');
      for (let day = 0; day < 5; day++) {
        document.querySelectorAll(`.class-schedule .td-${day+1} select`).forEach(select => {
          const absentCountOfDay = Number(absentCounts[day].value); // 曜日別欠席数
          const index = select.selectedIndex;
          const carriculumName = select[index].textContent;
          if (absentsOfCarriculm[carriculumName]) {
            absentsOfCarriculm[carriculumName] += absentCountOfDay;
          } else {
            absentsOfCarriculm[carriculumName] = absentCountOfDay;
          }
        });
      }
      return absentsOfCarriculm;
    }

    // 科目別の欠時数をセットする
    function setCarriculumAbsent(absentsOfCarriculm) {
      for (let i = 1; i <= Object.keys(absentsOfCarriculm).length; i++) {
        const absentNum = document.querySelector(`#absent${i}`);
        const carriculumName = document.querySelector(`#carriculum-name${i}`).innerText;
        absentNum.textContent = absentsOfCarriculm[carriculumName];
      }
    }

    // 日課表の値をリセットする
    function clearSchedule() {
      document.querySelectorAll(`.class-schedule select`).forEach(select => {
        select.value = '';
        saveScheduleBtn.classList.add('hidden');
        calcAbsentForm.classList.add('hidden');
        absentTable.classList.add('hidden');
      });
    }

    // absent-tableを作成する
    function makeAbsentTable(carriculumList) {
      const absentTableBody = document.querySelector('.absent-table tbody');

      // 既存の科目リストを削除
      document.querySelectorAll('.absent-table tbody tr').forEach(tr => {
        tr.remove();
      });


      // 科目リストを作成およびセット
      for (let i = 0; i < carriculumList.length; i++) {
        const tr = document.createElement('tr');

        const td1 = document.createElement('td');
        td1.setAttribute('id', `carriculum-name${i+1}`);
        td1.classList.add('td-1');
        td1.textContent = carriculumList[i];

        console.log(td1);

        const td2 = document.createElement('td');
        td2.setAttribute('id', `absent${i+1}`);
        td2.classList.add('td-2', 'absent-count');

        console.log(td2);

        tr.appendChild(td1);
        tr.appendChild(td2);
        absentTableBody.appendChild(tr);
      }
    }

    const carriculumSchedule = document.querySelector('#user_carriculum_schedule');
    const schedules = document.querySelectorAll('.schedules');
    const saveScheduleBtn = document.querySelector('#save-schedule');
    const calcAbsentBtn = document.querySelector('#calc-absent-btn');
    const calcAbsentForm = document.querySelector('.calc-absent');
    const clearScheduleBtn = document.querySelector('#clear-schdule-btn');
    const absentTable = document.querySelector('.absent-table');

    setCarriculumSchedule();

    schedules.forEach (schedule => {
      schedule.addEventListener('input', () => {
        const carriculumScheduleNames = setCarriculumSchedule();
        if (carriculumScheduleNames.length === 30) {
          // 重複なしの科目リストを作成
          const carriculumList = Array.from(new Set(carriculumScheduleNames));
          makeAbsentTable(carriculumList);
        }
      });
    });

    calcAbsentBtn.addEventListener('click', () => {
      const absentsOfCarriculm = calcAbsent();

      setCarriculumAbsent(absentsOfCarriculm);
    });

    clearScheduleBtn.addEventListener('click', () => {
      clearSchedule();
    });

    // makeAbsentTable();

  });
}
