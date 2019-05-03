function calculateHeight(container) {
  const children = Array.from(container.children);
  const clientWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
  const storyStyles = window.getComputedStyle(document.querySelector('.story'));
  const containerStyles = window.getComputedStyle(container);
  const storyMarginBottom = parseInt(storyStyles.getPropertyValue('margin-bottom'), 10);
  const paddingTopAndBottom = parseInt(containerStyles.getPropertyValue('padding-top'), 10) + parseInt(containerStyles.getPropertyValue('padding-bottom'), 10);
  const totalHeight = children.reduce((height, child) => height + child.clientHeight + storyMarginBottom, 0);
  let bonusHeight = 0;

  let columns = 3;
  if (clientWidth < 960) {
    columns = 1;
  } else if (clientWidth < 1280) {
    columns = 2;
  }
  // if totalHeight doesn't evenly divide into boxes, add 360 to bonusHeight;
  if (Math.round(360 - ((totalHeight / columns) % 360 !== 0))) {
    bonusHeight = 360 + paddingTopAndBottom;
  }

  if (columns === 1) {
    return Math.round(totalHeight / columns);
  }
  return Math.round(totalHeight / columns) + bonusHeight;
}

function updateContainerHeight() {
  const container = document.getElementById('stories');
  container.style.height = `${calculateHeight(container)}px`;
}

function responseLinks() {
  $('.story--response-text').on('click', (event) => {
    event.preventDefault();
    window.location.href = event.currentTarget.firstElementChild.attributes.href.value;
    window.history.pushState({}, '/stories', '/stories.html');
  });
}

window.addEventListener('load', () => {
  window.addEventListener('resize', updateContainerHeight);
  updateContainerHeight();
  responseLinks();
});
