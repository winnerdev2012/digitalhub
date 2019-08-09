$(() => {
  function closeResponseText() {
    $('div.response__modal-overlay').html('').removeClass('response__modal-overlay');
  }

  function buttonCloseResponseText() {
    $('button.response__modal-close').on('click', (event) => {
      event.preventDefault();
      event.stopPropagation();
      closeResponseText();
    });
  }

  function overlayCloseResponseText() {
    $('.response__modal-overlay').on('click', (event) => {
      event.preventDefault();
      event.stopPropagation();
      closeResponseText();
    });
  }

  function openLargeResponseModal(responseQuestion, responseText, responseSubmitter, event) {
    $('div.response__modal-overlay').html('');
    $('body').append(`
    <div class="response__modal-overlay">
      <button class="response__modal-close">&times;</button>
      <div class="response__modal">
      <p class="response__modal-question">${responseQuestion}</p>
      <p class="response__modal-text">${responseText}</p>
        <p class="response__modal-submitter">${responseSubmitter}</p>
      </div>
    </div>`);
    event.preventDefault();
    event.stopPropagation();
    buttonCloseResponseText();
    overlayCloseResponseText();
  }

  const modalNonLineClamped = () => {
    $('q').on('click', (event) => {
      const responseQuestion = event.currentTarget.parentNode.parentElement.firstElementChild.textContent;
      const responseText = event.currentTarget.innerText;
      const responseSubmitter = event.currentTarget.parentElement.parentElement.children[2].textContent;
      openLargeResponseModal(responseQuestion, responseText, responseSubmitter);
      event.preventDefault();
      event.stopPropagation();
    });
  };

  const modalLineClamped = () => {
    $('body').on('click', 'div.story--response-text q', (event) => {
      const storyId = event.currentTarget.parentElement.parentElement.id;
      const responseQuestion = event.currentTarget.parentNode.parentElement.firstElementChild.textContent;
      const responseText = localStorage.getItem(storyId);
      const responseSubmitter = event.currentTarget.parentElement.parentElement.children[2].textContent;
      openLargeResponseModal(responseQuestion, responseText, responseSubmitter, event);
      event.preventDefault();
      event.stopPropagation();
    });
  };
  modalNonLineClamped();
  modalLineClamped();
});
