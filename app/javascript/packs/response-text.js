window.addEventListener('load', () => {
  storeAllStoryTexts()
  lineClampResponseTexts()
  window.addEventListener('resize', lineClampResponseTexts);

  function storeAllStoryTexts() {
    $.get({
      url: '/stories',
      dataType: 'json'
    }).done(res = function (res) {
      res.forEach(story => {
        if (story.data.attributes.response.length > 0) {
          window.localStorage.setItem(`story${story.data.id}`, story.data.attributes.response.replace(/<p>|<\/p>/, ''))
        }
      })
    })
  }

  function lineClampResponseTexts() {
    if (document.documentElement.clientWidth > 770) {
      reloadStoryTexts()
      console.log("over 770")
      $('div.story--response-text').succinct({
        size: 400,
        omission: '...',
        ignore: false
      });
    } else if (document.documentElement.clientWidth < 770) {
      console.log("under 770")
      $('div.story--response-text').succinct({
        size: 45,
        omission: '...',
        ignore: false
      });
    }
  }

  function reloadStoryTexts() {
    if (document.documentElement.clientWidth > 770) {
      Array.from($('.story--response')).forEach(div => {
        if (div.children[0].children[0]) {
          div.children[0].children[0].innerText = window.localStorage.getItem(`${div.id}`)
        }
      })
    }
  }

});