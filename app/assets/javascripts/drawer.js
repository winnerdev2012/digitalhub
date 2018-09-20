function openDrawer() {
  let page = document.getElementById("page_container");
  let content = document.getElementsByClassName("content")[0];
  let footer = document.getElementsByTagName("footer")[0];

  page.classList.add("active");
}

function closeDrawer() {
  let page = document.getElementById("page_container");

  page.classList.remove("active");
}
