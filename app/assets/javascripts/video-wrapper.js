

document.addEventListener("DOMContentLoaded", function() {
  // Swap out all iframes for wrappers, video placeholders, and thumbnails
  var videos = document.getElementsByTagName('iframe');
  for (var i = 0; i < videos.length; i++) {
    var video = videos[i];
    var match = video.src.match(/https:\/\/www\.youtube\.com\/embed\/([^\?]*)(?:\?|$)/);
    var parent = video.parentNode;
    if (match) {
      var videoId = match[1];

      var wrapper = document.createElement('div');
      wrapper.setAttribute('data-video', videoId);
      wrapper.classList.add('video-wrapper');

      var videoPlaceholder = document.createElement('div');
      videoPlaceholder.setAttribute('id', "video-" + videoId);

      var thumbnail = document.createElement('button');
      thumbnail.classList.add('thumbnail');
      thumbnail.setAttribute('id', "video-button-" + videoId);
      thumbnail.style.backgroundImage = "url(http://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg)";

      wrapper.appendChild(videoPlaceholder);
      wrapper.appendChild(thumbnail);
      parent.replaceChild(wrapper, video);
    } else {
      parent.removeChild(video);
    }
  }

  //youtube script
  var tag = document.createElement('script');
  tag.src = "//www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
});

function onYouTubeIframeAPIReady() {
  // When the YouTube API is ready, set up the video player
  var videos = document.getElementsByClassName('video-wrapper');

  for (var i = 0; i < videos.length; i++) {
    var video = videos[i];
    var videoId = video.getAttribute('data-video');
    var button = document.getElementById("video-button-" + videoId);
    var playWhenReady = false;
    var playerReady = false;
    var player = new YT.Player("video-" + videoId, {
      height: '244',
      width: '434',
      videoId: videoId,
      playerVars: {
        'autoplay': 0,
        'rel': 0,
        'showinfo': 0
      },
      events: {
        'onStateChange': function(event) {
          if (event.data == YT.PlayerState.PLAYING) {
            button.style.display = 'none';
          }
        },
        'onReady': function() {
          playerReady = true;
          if (playWhenReady) {
            player.playVideo();
          }
        }
      }
    });

    button.onclick = function() {
      button.classList.add('readying');
      if (playerReady) {
        player.playVideo();
      } else {
        playWhenReady = true;
      }
    };
  }
}
