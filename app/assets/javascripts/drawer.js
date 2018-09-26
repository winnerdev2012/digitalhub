function toggleDrawer() {
  var page = document.getElementById("page_container");
  var drawer = document.getElementById("drawer");
  if (page.classList.contains("active")) {
    page.classList.remove("active");
    drawer.classList.remove("active");
    // Drawer starts out aria-hidden
    // Hidden removes the menu from the tab order until the menu is opened
    // Timeout matches CSS transition
    setTimeout(function() {
      if (!page.classList.contains("active")) {
        drawer.hidden = true;
        drawer.setAttribute('aria-hidden', 'true');
      }
    }, 1000);
  } else {
    drawer.hidden = false;
    drawer.setAttribute('aria-hidden', 'false');
    // Need time for hidden: false to take effect
    setTimeout(function() {
      page.classList.add("active");
      drawer.classList.add("active");
    }, 80);
  }
}
