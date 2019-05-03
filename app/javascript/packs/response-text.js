$(() => {
  function reloadStoryTexts() {
    Array.from($('.story--response')).forEach((div) => {
      if (div.children[0].children[0]) {
        const modifiedDiv = div.children[0].children[0];
        modifiedDiv.innerText = window.localStorage.getItem(`${div.id}`);
      }
    });
  }

  function lineClampResponseTexts() {
    reloadStoryTexts();
    if (document.documentElement.clientWidth > 670) {
      $('div.story--response-text').succinct({
        size: 400,
        omission: '...',
        ignore: false,
      });
    } else if (document.documentElement.clientWidth < 670) {
      $('div.story--response-text').succinct({
        size: 55,
        omission: '...',
        ignore: false,
      });
    }
  }

  function storeAllStoryTexts() {
    $.get({
      url: '/stories',
      dataType: 'json',
    }).done((res) => {
      res.forEach((story) => {
        if (story.data.attributes.text_response) {
          window.localStorage.setItem(`story${story.data.id}`, story.data.attributes.sanitized_response);
        }
      });
      lineClampResponseTexts();
    });
  }
  storeAllStoryTexts();
  window.addEventListener('resize', lineClampResponseTexts);
});
