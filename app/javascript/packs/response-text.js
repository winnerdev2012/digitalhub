$(() => {
  function reloadStoryTexts() {
    Array.from($('.story--response')).forEach((div) => {
      const modifiedDiv = div.children[1].children[0];
      if (document.documentElement.clientWidth > 670) {
        modifiedDiv.innerText = lineClampResponseTexts(div, 350)
      } else if (document.documentElement.clientWidth < 670) {
        modifiedDiv.innerText = lineClampResponseTexts(div, 55)
      }
    });
  }

  function lineClampResponseTexts(div, length) {
    const origText = localStorage.getItem(`${div.id}`)
    return `${origText.substring(0, length).split(' ').slice(0, -1).join(' ')}...`
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
      reloadStoryTexts()
    });
  }

  storeAllStoryTexts();
  window.addEventListener('resize', reloadStoryTexts);
});
