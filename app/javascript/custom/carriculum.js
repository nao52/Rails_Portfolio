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
      } else {
        saveScheduleBtn.classList.add('hidden');
      }
    }

    const carriculumSchedule = document.querySelector('#user_carriculum_schedule');
    const schedules = document.querySelectorAll('.schedules');
    const saveScheduleBtn = document.querySelector('#save-schedule');

    setCarriculumSchedule();

    schedules.forEach (schedule => {
      schedule.addEventListener('input', () => {
        setCarriculumSchedule();
      });
    });
  });
}