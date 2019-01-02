import { DirectUpload } from "activestorage"

(() => {

const fileTypes = {
  'audio/wav': 'wav',
  'audio/ogg;codecs=opus': 'ogg',
};

function responseFileName (codec) {
  return `response-${Date.now()}.${fileTypes[codec]}`;
}

document.addEventListener("DOMContentLoaded", function(){
  const audioContainer = document.querySelector('#audio-recording')
  const audioUnsupported = Object.keys(fileTypes).every(type => !MediaRecorder.isTypeSupported(type));

  if (audioUnsupported || !audioContainer) {
    audioContainer && audioContainer.parentNode.removeChild(audioContainer);
  }
  else {
    const input = audioContainer.querySelector('#story_audio')
    const recordButton = audioContainer.getElementById("recordButton");
    const stopButton = audioContainer.getElementById("stopButton");
    let recorder = null;

    const uploadFile = (file) => {
      const url = input.dataset.directUploadUrl
      const upload = new DirectUpload(file, url)

      upload.create((error, blob) => {
        if (error) {
          const errorAlert = document.createElement('div')
          errorAlert.textContent = 'Sorry, there was an error submitting your audio.'
          document.querySelector('.content > .container > .content-column').appendChild(errorAlert)
        } else {
          // Add an appropriately-named hidden input to the form with a
          //  value of blob.signed_id so that the blob ids will be
          //  transmitted in the normal upload flow
          const hiddenField = document.createElement('input')
          hiddenField.setAttribute("type", "hidden");
          hiddenField.setAttribute("value", blob.signed_id);
          hiddenField.name = input.name
          document.querySelector('form').appendChild(hiddenField)
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
