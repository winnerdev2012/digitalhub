$(() => {
  announcementGoalsLink();
  oneBoxGoalsLink();
})

const goalsSurveyLink = "https://mapc.az1.qualtrics.com/jfe/form/SV_832YVvNk2Yabzox"

const announcementGoalsLink = () => {
  $("body").on('click', 'a.button.announcements__button', function (event) {
    event.preventDefault();
    if (document.documentElement.clientWidth > 770 && event.currentTarget.href == goalsSurveyLink) {
      openGoals()
    } else {
      openGoalsInNewTab(event.currentTarget.href);
    }
  })
}

const oneBoxGoalsLink = () => {
  $('a').on('click', (event) => {
    event.preventDefault();
    if (document.documentElement.clientWidth > 770 && event.currentTarget.href == goalsSurveyLink) {
      openGoals()
    } else {
      openGoalsInNewTab(event.currentTarget.href);
    }
  })
}

const openGoals = () => {
  $('div.overlay').html("")
  $('body').append(`
    <div class="overlay">
      <button id="close-survey" class="close-survey">&times;</button>
      <iframe src="${goalsSurveyLink}" frameborder="0"; width=100%; height=auto; id="goals-survey";></iframe>
    </div>`)
  closeGoals();
}

const openGoalsInNewTab = (url) => {
  var win = window.open(url, '_blank');
  win.focus();
}

const closeGoals = () => {
  $('div.overlay button#close-survey.close-survey').on('click', function (event) {
    event.preventDefault()
    $('div.overlay').html("").removeClass('overlay')
  })
}
