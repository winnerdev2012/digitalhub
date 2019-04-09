$(() => {
  // $('button#survey-button').on('click', function (event) {
  // $oneBox = $('div.styled-box__title.styled-box__title--block')
  $oneBox = $('div.styled-box.one-box.styled-box--half')
  $oneBox.on('click', function (event) {
    event.preventDefault();
    $('#survey-modal.modal').html('')

    $('#survey-modal.modal').append('<button id="close-survey" class="close">&times;</button>')
    $('#survey-modal.modal').append(`
      <iframe src="https://mapc.az1.qualtrics.com/jfe/form/SV_0wiHeWbuN9GJ81f" 
      frameborder="0" 
      width=100%;
      height=100%;
      ></iframe> 
    `)

    $('#survey-modal.modal')[0].style.display = "block";

    $('button.close').on('click', function (event) {
      event.preventDefault();
      $('#survey-modal.modal')[0].style.display = "none";
    })

    $('window').on('click', function (event) {
      event.preventDefault();
      if (event.target == modal) {
        $('#survey-modal.modal')[0].style.display = "none";
      }
    })
  })
})
