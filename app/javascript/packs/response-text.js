$(() => {
  const origStoryText = $('div.story--response-text')[0].children[0].innerText
  console.log(origStoryText)
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
        let longStoryText = origStoryText.substring(0,350)
        .split(' ')
        .slice(0,-1)
        .join(" ")
        $('div.story--response-text')[0].children[0].innerText = longStoryText + "..."
      } else if (document.documentElement.clientWidth < 670) {
        let shortStoryText = origStoryText.substring(0,55)
        .split(' ')
        .slice(0,-1)
        .join(" ")
        $('div.story--response-text')[0].children[0].innerText = shortStoryText + "..."
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
