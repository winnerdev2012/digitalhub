window.addEventListener('load', () => {
  function storeAllStoryTexts() {
    $.get({
      url: '/stories',
      dataType: 'json',
    }).done((res) => {
      res.forEach((story) => {
        if (story.data.attributes.response.length > 0) {
          window.localStorage.setItem(`story${story.data.id}`, story.data.attributes.response.replace(/<p>|<\/p>/, ''));
        }
      });
    });
  }

  function reloadStoryTexts() {
    if (document.documentElement.clientWidth > 670) {
      Array.from($('.story--response')).forEach((div) => {
        if (div.children[0].children[0]) {
          const modifiedDiv = div.children[0].children[0];
          modifiedDiv.innerText = window.localStorage.getItem(`${div.id}`);
        }
      });
    }
  }

  function lineClampResponseTexts() {
    if (document.documentElement.clientWidth > 670) {
      reloadStoryTexts();
      $('div.story--response-text').succinct({
        size: 400,
        omission: '...',
        ignore: false,
      });
    } else if (document.documentElement.clientWidth < 670) {
      $('div.story--response-text').succinct({
        size: 45,
        omission: '...',
        ignore: false,
      });
    }
  }

  storeAllStoryTexts();
  lineClampResponseTexts();
  window.addEventListener('resize', lineClampResponseTexts);
});
