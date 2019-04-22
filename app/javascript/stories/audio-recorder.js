import { DirectUpload } from "activestorage";
import HyperElement from 'classes/HyperElement';

(() => {

/*
 * Declarations
 */
const fileTypes = {
  'audio/wav': 'wav',
  'audio/ogg': 'ogg',
  'audio/ogg;codecs=opus': 'ogg',
};

/*
 * State
 */
const audioUnsupported = Object.keys(fileTypes).every(type => !MediaRecorder.isTypeSupported(type));

/*
 * Functions
 */
const responseFileName = codec => `response-${Date.now()}.${fileTypes[codec]}`;

document.addEventListener("DOMContentLoaded", () => {
  const audioContainer = document.querySelector('#audio-recording')

  if (audioUnsupported || !audioContainer) {
    audioContainer && audioContainer.parentNode.removeChild(audioContainer);
  }
  else {
    const input = audioContainer.querySelector('#story_audio')
    const recordButton = new HyperElement(audioContainer.querySelector("#recordButton"));
    const stopButton = new HyperElement(audioContainer.querySelector("#stopButton"));
    const sessionInfo = new HyperElement('p');
    let recordingStartTime = 0;
    let hiddenField = null;
    let recorder = null;
    let errorNode = null;

    sessionInfo.setAttr('textContent', 'No audio recorded');
    sessionInfo.addClass('session-info');
    sessionInfo.mount(audioContainer);
    stopButton.unmount();

    const uploadFile = file => {
      const url = input.dataset.directUploadUrl
      const upload = new DirectUpload(file, url)

      upload.create((error, blob) => {
        if (errorNode) errorNode.unmount();

        if (error) {
          errorNode = (new HyperElement)
            .setAttr('textContent', '')
            .mount('.content > .container > .content-column');
        } else {
          if (hiddenField) hiddenField.unmount();

          // Add an appropriately-named hidden input to the form with a
          // value of blob.signed_id so that the blob ids will be
          // transmitted in the normal upload flow
          hiddenField = (new HyperElement('input'))
            .setAttr('type', 'hidden')
            .setAttr('value', blob.signed_id)
            .setAttr('name', input.name)
            .mount('form');
        }
      })
    }

    input.addEventListener('change', (event) => {
      Array.from(input.files).forEach(file => uploadFile(file))
      input.value = null
    })

    recordButton.addEvent('click', () => {
      // Request permissions to record audio
      navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
        stopButton.mount();
        recordButton.unmount();

        recordingStartTime = Date.now();
        sessionInfo.addClass('recording');
        sessionInfo.setAttr('innerHTML', '&#x25CF; Recording');

        recorder = new MediaRecorder(stream)
        recorder.addEventListener('dataavailable', ({ data }) => {
          const file = new File([data], responseFileName(data.type), {type: data.type})
          uploadFile(file)
        })
        recorder.start()
      })
    })

    stopButton.addEvent('click', () => {
      recorder.stop();

      const duration = new Date(Date.now() - recordingStartTime);

      sessionInfo.setAttr('textContent', `Recorded ${duration.getMinutes()} minutes and ${duration.getSeconds()} seconds.`);
      sessionInfo.removeClass('recording');

      recordButton.setAttr('textContent', 'Restart Recording');
      recordButton.mount();
      stopButton.unmount();

      // Remove “recording” icon from browser tab
      recorder.stream.getTracks().forEach(i => i.stop())
    })
  }
});

})();
