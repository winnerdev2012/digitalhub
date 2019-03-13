document.addEventListener("DOMContentLoaded", () => {
  const carouselContainer = getCarousel();

  if(carouselContainer) {
    getData().then(result => populateCarousel(result, carouselContainer));
  }
});

function getData() {
  return new Promise((resolve, reject) => {
      const xhr = new XMLHttpRequest();
      xhr.open("GET", "/announcements");
      xhr.onload = () => resolve(JSON.parse(xhr.responseText));
      xhr.onerror = () => reject(xhr.statusText);
      xhr.send();
    });
}

function getCarousel() {
  return document.querySelector('.announcements');
}

function populateCarousel(announcements, carouselContainer) {
  const numberParent = carouselContainer.querySelector('.announcements__numbers');

  for (i = 0; i < announcements.length; i++) {
    let node = document.createElement("div");
    if(i == 0) {
      node.setAttribute('class', 'announcements__number announcements__number--selected');
    } else {
      node.setAttribute('class', 'announcements__number');
    }
    let textnode = document.createTextNode((i+1).toString());
    node.appendChild(textnode);
    numberParent.appendChild(node);
  }

  populateAnnouncement(announcements[0], carouselContainer);
  makeNumbersClickable(numberParent, announcements, carouselContainer);
}

function populateAnnouncement(announcement, carouselContainer) {
  const {
      data: { attributes: { title, sanitized_body: body, link }},
      included
    } = announcement;

  const {
    attributes: { title: imageTitle = "Default Image",
                  alt: imageAlt = "A default image.",
                  image_name: imageName = "default.jpg",
                  image_width: imageWidth = "0",
                  image_height: imageHeight= "0",
                  url: imageUrl= "" }
  } = included[0]

  let titleNode = document.createElement("h2");
  titleNode.setAttribute('class', 'announcements__title')
  titleNode.appendChild(document.createTextNode(title))
  carouselContainer.firstElementChild.appendChild(titleNode)

  let paragraphNode = document.createElement("p")
  paragraphNode.setAttribute('class', 'announcements__paragraph')
  paragraphNode.innerHTML = body
  carouselContainer.firstElementChild.appendChild(paragraphNode)

  let imageNode = document.createElement("img")
  imageNode.setAttribute('src', imageUrl)
  imageNode.setAttribute('class', 'announcements__image')
  carouselContainer.appendChild(imageNode)

}

function makeNumbersClickable(numberParent, announcements, carouselContainer) {
  const numbers = numberParent.children

  for (var i = 0; i < numbers.length; i++) {
    numbers[i].addEventListener("click", genDisplay(announcements, carouselContainer));
  }
}

function genDisplay(data, carouselContainer) {
  function displayAnnouncement(event) {
    const selection = parseInt(event.target.textContent) - 1;
    const numbers = event.target.parentElement.children
    const {
      data: { attributes: { title, sanitized_body: body, link }},
      included
    } = data[selection];

    const {
      attributes: { title: imageTitle = "Default Image",
                    alt: imageAlt = "A default image.",
                    image_name: imageName = "default.jpg",
                    image_width: imageWidth = "0",
                    image_height: imageHeight= "0",
                    url: imageUrl= "" }
    } = included[0]

    carouselContainer.querySelector('.announcements__title').innerText = title;
    carouselContainer.querySelector('.announcements__paragraph').innerText = body;
    carouselContainer.querySelector('.announcements__image').setAttribute('src', imageUrl);
    for (var i = 0; i < numbers.length; i++) {
        numbers[i].setAttribute('class', 'announcements__number')
    }
    event.target.setAttribute('class', 'announcements__number announcements__number--selected');

    // carouselContainer.querySelector('.button').setAttribute('href', link)
  };
  return displayAnnouncement;
}
