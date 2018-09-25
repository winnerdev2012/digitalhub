function toggleDrawer() {
  var page = document.getElementById("page_container");
  var drawer = document.getElementById("drawer");
  if (page.classList.contains("active")) {
    page.classList.remove("active");
    drawer.classList.remove("active");
  } else {
    page.classList.add("active");
    drawer.classList.add("active");
  }
}
