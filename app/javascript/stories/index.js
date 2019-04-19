document.addEventListener('DOMContentLoaded', () => {
  const audioRecordings = document.querySelectorAll('.media-player__audio');

  audioRecordings.forEach((recording) => {
    const audio = recording.getElementsByTagName('audio')[0];
    const pausePlayButton = recording.getElementsByClassName('media-player__pause-play')[0];
    const progressBar = recording.getElementsByClassName('media-player__progress-value')[0];
    const time = recording.getElementsByClassName('media-player__time')[0];

    pausePlayButton.addEventListener('click', () => {
      if (audio.paused) {
        audio.play();
        pausePlayButton.className += ' media-player__pause-play--playing';
      } else {
        audio.pause();
        pausePlayButton.className = pausePlayButton.className.replace(' media-player__pause-play--playing', '');
      }
    });

    audio.onended = () => {
      pausePlayButton.className = pausePlayButton.className.replace(' media-player__pause-play--playing', '');
    };

    audio.ontimeupdate = () => {
      progressBar.style.width = `${(audio.currentTime / audio.duration * 100).toString()}%`;
      if (audio.currentTime % 60 < 10) {
        time.textContent = `${parseInt((audio.currentTime / 60), 10)}:0${parseInt((audio.currentTime % 60), 10)}`;
      } else {
        time.textContent = `${parseInt((audio.currentTime / 60), 10)}:${parseInt((audio.currentTime % 60), 10)}`;
      }
    };
  });
});
