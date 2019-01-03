import { DirectUpload } from "activestorage";
import HyperElement from './classes/Element';

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
    let recorder = null;
    let errorNode = null;

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
          // Add an appropriately-named hidden input to the form with a
          // value of blob.signed_id so that the blob ids will be
          // transmitted in the normal upload flow
          const hiddenField = (new HyperElement('input'))
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
      stopButton.mount();
      recordButton.unmount();

      // Request permissions to record audio
      navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
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
      recordButton.mount();
      stopButton.unmount();

      // Remove “recording” icon from browser tab
      recorder.stream.getTracks().forEach(i => i.stop())
    })
  }
});

})();
