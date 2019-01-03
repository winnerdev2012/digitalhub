import { DirectUpload } from "activestorage";
import Element from './classes/Element';

(() => {

/*
 * Declarations
 */
const fileTypes = {
  'audio/wav': 'wav',
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
    const recordButton = document.getElementById("recordButton");
    const stopButton = document.getElementById("stopButton");
    let recorder = null;
    let errorNode = null;

    const uploadFile = (file) => {
      const url = input.dataset.directUploadUrl
      const upload = new DirectUpload(file, url)

      upload.create((error, blob) => {
        if (errorNode) errorNode.remove();

        if (error) {
          errorNode = (new Element)
            .set('textContent', '')
            .add('.content > .container > .content-column');
        } else {
          // Add an appropriately-named hidden input to the form with a
          // value of blob.signed_id so that the blob ids will be
          // transmitted in the normal upload flow
          const hiddenField = (new Element('input'))
            .set('type', 'hidden')
            .set('value', blob.signed_id)
            .set('name', input.name)
            .add('form');
        }
      })
    }

    input.addEventListener('change', (event) => {
      Array.from(input.files).forEach(file => uploadFile(file))
      input.value = null
    })

    recordButton.addEventListener('click', () => {
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

    stopButton.addEventListener('click', () => {
      recorder.stop()
      // Remove “recording” icon from browser tab
      recorder.stream.getTracks().forEach(i => i.stop())
    })
  }
});

})();
