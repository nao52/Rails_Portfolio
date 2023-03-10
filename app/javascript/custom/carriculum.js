'use strict';

{
  document.addEventListener("turbo:load", () => {
    // params[carriculum_schedule]をセット
    function setCarriculumSchedule() {
      let scheduleList = [];
      schedules.forEach (schedule => {
        if (schedule.value) {
          scheduleList.push(schedule.value);
        }
      });
      carriculumSchedule.value = scheduleList;

      // 全て入力済みなら、ボタンを表示
      if (scheduleList.length === 30) {
        saveScheduleBtn.classList.remove('hidden');
        calcAbsentForm.classList.remove('hidden');
        absentTable.classList.remove('hidden');
      } else {
        saveScheduleBtn.classList.add('hidden');
        calcAbsentForm.classList.add('hidden');
        absentTable.classList.add('hidden');
      }
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
        setCarriculumSchedule();
      });
    });

    calcAbsentBtn.addEventListener('click', () => {
      const absentsOfCarriculm = calcAbsent();

      setCarriculumAbsent(absentsOfCarriculm)
    });

    clearScheduleBtn.addEventListener('click', () => {
      clearSchedule();
    });
  });
}
