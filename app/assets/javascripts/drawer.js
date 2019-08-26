function toggleDrawer() {
  var page = document.getElementById("page_container");
  var drawer = document.getElementById("drawer");
  var body = document.getElementsByTagName("body")[0];
  if (page.classList.contains("menu-open")) {
    page.classList.remove("menu-open");
    drawer.classList.remove("menu-open");
    body.classList.remove("menu-open");
    // Drawer starts out aria-hidden
    // Hidden removes the menu from the tab order until the menu is opened
    // Timeout matches CSS transition
    setTimeout(function () {
      if (!page.classList.contains("menu-open")) {
        drawer.hidden = true;
        drawer.setAttribute('aria-hidden', 'true');
      }
    }, 1000);
  } else {
    drawer.hidden = false;
    drawer.setAttribute('aria-hidden', 'false');
    // Need time for hidden: false to take effect
    setTimeout(function () {
      page.classList.add("menu-open");
      drawer.classList.add("menu-open");
      body.classList.add("menu-open");
    }, 80);
  }
}

function toggleLanguageList() {
  var navLang = document.getElementById("navigation-language");
  // var dropdown = navLang.getElementsByTagName("ul")[0];
  if (navLang.classList.contains("menu-open")) {
    navLang.classList.remove("menu-open");
    navLang.setAttribute("aria-expanded", "false");
  } else {
    navLang.classList.add("menu-open");
    navLang.setAttribute("aria-expanded", "true");
  }
}
