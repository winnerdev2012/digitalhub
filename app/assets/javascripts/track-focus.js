/*! track-focus v 1.0.0 | Author: Jeremy Fields [jeremy.fields@vget.com], 2015 | License: MIT */
// inspired by: http://irama.org/pkg/keyboard-focus-0.3/jquery.keyboard-focus.js
// Adjusted for focus--keyboard instead of focus--mouse

document.onreadystatechange = function() {
  if (document.readyState === 'complete') {
    (function(body) {

      var usingKeyboard;

      var preFocus = function(event) {
        usingKeyboard = (event.type === 'keydown');
      };

      var addFocus = function(event) {
        if (usingKeyboard)
          event.target.classList.add('focus--keyboard');
      };

      var removeFocus = function(event) {
        event.target.classList.remove('focus--keyboard');
      };

      var bindEvents = function() {
        body.addEventListener('keydown', preFocus);
        body.addEventListener('mousedown', preFocus);
        body.addEventListener('focusin', addFocus);
        body.addEventListener('focusout', removeFocus);
      };
      bindEvents();

    })(document.body);
  }
}

