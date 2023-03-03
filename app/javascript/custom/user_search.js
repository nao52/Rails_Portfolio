document.addEventListener("turbo:load", () => {
  
  const condition_name = document.querySelector('#condition_name');
  const condition_subject = document.querySelector('#condition_subject');
  const condition_club = document.querySelector('#condition_club');
  const search_name = document.querySelector('#search_name');
  const search_subject = document.querySelector('#search_subject');
  const search_club = document.querySelector('#search_club');

  show_form();

  function show_form() {
    if (condition_name.checked) {
      search_name.classList.remove('hidden');
      search_subject.classList.add('hidden');
      search_club.classList.add('hidden');
    } else if (condition_subject.checked) {
      search_name.classList.add('hidden');
      search_subject.classList.remove('hidden');
      search_club.classList.add('hidden');
    } else if (condition_club.checked) {
      search_name.classList.add('hidden');
      search_subject.classList.add('hidden');
      search_club.classList.remove('hidden');
    }
  } 

  condition_name.addEventListener('click', () => {
    show_form();
  });
  condition_subject.addEventListener('click', () => {
    show_form();
  });
  condition_club.addEventListener('click', () => {
    show_form();
  });

});