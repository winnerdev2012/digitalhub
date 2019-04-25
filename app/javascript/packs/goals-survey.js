$(() => {
  announcementGoalsLink();
  weighInGoalsLink();
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

const weighInGoalsLink = () => {
  $("div.story--prompt-large").on('click', function (event) {
    event.preventDefault();
    event.stopPropagation();
    if (document.documentElement.clientWidth > 770) {
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
  buttonCloseGoals();
  overlayCloseGoals();
}

const openGoalsInNewTab = (url) => {
  var win = window.open(url, '_blank');
  win.focus();
}

const buttonCloseGoals = () => {
  $('button#close-survey.close-survey').on('click', function (event) {
    event.preventDefault()
    closeGoals()
  })
}

const overlayCloseGoals = () => {
  $('div.overlay').on('click', function (event) {
    event.preventDefault()
    closeGoals()
  })
}

const closeGoals = () => {
  $('div.overlay').html("").removeClass('overlay')
}
