import '../audio-recorder.js';
import HyperElement from '../classes/HyperElement';

(() => {


document.addEventListener('DOMContentLoaded', () => {
  const videoContainer = document.querySelector('.video-response');

  const videoInfo = new HyperElement('p');
  videoInfo.addClass('video-info');

  const videoUploader = new HyperElement(videoContainer.querySelector('input[type="file"]'));
  videoUploader.addEvent('change', () => {
    const fileName = videoUploader.node.value.split('\\').pop();

    videoInfo.setAttr('innerHTML', `Uploaded Video: ${fileName}`);
    videoInfo.mount(videoContainer);
  });
});


})();
