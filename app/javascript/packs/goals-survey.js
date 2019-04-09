$(() => {
  getSurveyOneBox();
  getSurveyAnnouncement();
})

  const getSurveyOneBox = () => {
    $('a').on('click', function(event){
      if(this.href.split('/')[this.href.split('/').length - 1] == "#"){
        $('body').append('<div class="overlay"></div>')
        $('div.overlay').html("")
        $('div.overlay').append(`
          <iframe src="https://mapc.az1.qualtrics.com/jfe/form/SV_0wiHeWbuN9GJ81f" 
          frameborder="0" 
          width=100%;
          height=100%;
          id="goals-survey";
          ></iframe> 
        `)
        $('div.overlay').append(`<button id="close-survey" class="close-survey">&times;</button>`)
        event.preventDefault();
      }
      closeSurvey();
    })
  }
    
    const getSurveyAnnouncement = () => {
      $('a.button.announcements__button').on('click', function(event){
        if(this.href.split('/')[this.href.split('/').length - 1] == "#"){
          $('body').append('<div class="overlay"></div>')
          $('div.overlay').html("")
          $('div.overlay').append(`
            <iframe src="https://mapc.az1.qualtrics.com/jfe/form/SV_0wiHeWbuN9GJ81f" 
            frameborder="0" 
            width=100%;
            height=100%;
            id="goals-survey";
            ></iframe> 
          `)
          $('div.overlay').append(`<button id="close-survey" class="close-survey">&times;</button>`)
          event.preventDefault();
        }
      closeSurvey();
    })
  }

const closeSurvey = () => {
  $('div.overlay button#close-survey.close-survey').on('click', function (event) {
    event.preventDefault()
    $('div.overlay').html("").removeClass('overlay')
  })
}
