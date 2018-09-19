function openDrawer() {
  let page = document.getElementById("page");
  let footer = document.getElementsByTagName("footer")[0];
  let drawer = document.getElementById("drawer");
  let toggle = document.getElementsByClassName("header-content-right")[0];

  drawer.style.right = 0;
  page.classList.add("active");
  footer.classList.add("active");
  toggle.classList.add("active");
}

function closeDrawer() {
  let page = document.getElementById("page");
  let footer = document.getElementsByTagName("footer")[0];
  let drawer = document.getElementById("drawer");
  let toggle = document.getElementsByClassName("header-content-right")[0];


  drawer.style.right = '-25em';
  page.classList.remove("active");
  footer.classList.remove("active");
  toggle.classList.remove("active");
}
