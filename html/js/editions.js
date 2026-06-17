// This file contains JavaScript code for handling
// the OpenSeadragon viewer and page navigation in the letters edition.

function osdNextPage() {
  viewer.goToNextPage();
}
function osdPreviousPage() {
  viewer.goToPreviousPage();
}
const pageSections = Array.from(document.querySelectorAll(".letter-page"));
let currentIndex = 0;

const backButton = document.getElementById("backButton");
const forwardButton = document.getElementById("forwardButton");

function showPage(index) {
  pageSections.forEach((section, idx) => {
    section.classList.toggle("d-none", idx !== index);
  });
  backButton.disabled = index === 0;
  forwardButton.disabled =
    index === pageSections.length - 1 || pageSections.length === 0;
}

backButton.addEventListener("click", () => {
  if (currentIndex > 0) {
    currentIndex -= 1;
    showPage(currentIndex);
  }
  osdPreviousPage();
});

forwardButton.addEventListener("click", () => {
  if (currentIndex < pageSections.length - 1) {
    currentIndex += 1;
    showPage(currentIndex);
  }
  osdNextPage();
});

if (pageSections.length > 0) {
  showPage(currentIndex);
} else {
  backButton.disabled = true;
  forwardButton.disabled = true;
}
