$(() => {
  if (checkWidth()) {
    getImages()
  }
});

let counter = 0
let imagesList = []
let baseUrl = window.location.href

if (baseUrl.match(/\/$/)) {
  baseUrl = baseUrl.replace(/\/$/i, "")
} if (baseUrl.match(/\/..?$/i)) {
  baseUrl = baseUrl.replace(/\/..?$/i, "")
}

const checkWidth = () => {
  return document.documentElement.clientWidth > 1300
}

const getImages = () => {
  $.get(`${baseUrl}/hero_images`)
    .done(response => {
      counter = response.length
      imagesList = response
      loadImages(response)
    })
};

const loadImages = (images) => {
  let index = 0
  for (let i = 0; i < images.length; i++) {
    setTimeout(() => {
    }, i * 1000);

    setTimeout(() => {
      loadImage(images[i])

      if (index < images.length) {
        loadImages(images[index]);
        index++
      }
    }, i * 3000);
  }
};

const loadImage = (img) => {
  counter -= 1
  let hero = $('.styled-box')[0];

  if (img && checkWidth()) {
    let imgUrl = `${baseUrl}${img.included[0].attributes.hero_image_thumbnail_url}`
    hero.style.backgroundImage = `url(${imgUrl})`
    hero.classList.add('rotation-test')
  }

  if (counter == 0) {
    setTimeout(() => {
      replay()
    }, 4000);
  }
}

const replay = () => {
  counter = imagesList.length
  if (checkWidth()) {
    loadImages(imagesList)
  }
};
