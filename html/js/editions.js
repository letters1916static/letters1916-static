const tabLinks = document.querySelectorAll(".tab-link");
const tabPanels = document.querySelectorAll(".tab-panel");
const letterPages = document.querySelectorAll(".letter-page");
const pageSections = Array.from(document.querySelectorAll(".letter-page"));
const tabs = {
  transcription: 1,
  about: 2,
  meta: 3,
};
let currentPageIndex = 0;

if (pageSections.length > 0) {
  showPage(currentPageIndex + 1);
} else {
  backButton.disabled = true;
  forwardButton.disabled = true;
}

// OSD Viewer
function osdNextPage() {
  viewer.goToNextPage();
}
function osdPreviousPage() {
  viewer.goToPreviousPage();
}
viewer.addHandler("page", function (e) {
  showPage(e.page + 1);
});

// Function to show a tab by data-tab value
function showTab(tabId) {
  console.log("showTab(" + tabId + ")");
  // Hide all panels and deactivate all links
  tabPanels.forEach((panel) => panel.classList.remove("active"));
  tabLinks.forEach((link) => link.classList.remove("active"));

  // Hide page navigation buttons
  if (tabId == 1) {
    document.querySelector(".page-nav").classList.add("active");
  } else {
    document.querySelector(".page-nav").classList.remove("active");
  }

  // Show the selected panel and activate the link
  document
    .querySelector(`.tab-link[data-tab="${tabId}"]`)
    .classList.add("active");
  document
    .querySelector(`.tab-panel[data-tab="${tabId}"]`)
    .classList.add("active");
}

// Function to show a page by text-page value
function showPage(pageId) {
  console.log("showPage(" + pageId + ")");

  // Update currentPageIndex
  currentPageIndex = pageId - 1;
  console.log("currentPageIndex: " + currentPageIndex);

  // Update the URL hash without scrolling
  hash = "#page-" + pageId;
  history.pushState(null, null, hash);

  // Hide all panels and deactivate all links
  tabPanels.forEach((panel) => panel.classList.remove("active"));
  tabLinks.forEach((link) => link.classList.remove("active"));
  letterPages.forEach((page) => page.classList.remove("active"));

  // Show tab-1 and activate the navigation buttons and the letter-page
  document.querySelector(`.tab-link[data-tab="1"]`).classList.add("active");
  document.querySelector(`.tab-panel[data-tab="1"]`).classList.add("active");
  document.querySelector(".page-nav").classList.add("active");
  document
    .querySelector(`.letter-page[letter-page="${pageId}"]`)
    .classList.add("active");

  // Adjust status backwardButton and forwardButton */
  backButton.disabled = currentPageIndex === 0;
  forwardButton.disabled =
    currentPageIndex === pageSections.length - 1 || pageSections.length === 0;
}

// Add click listeners to tab links
tabLinks.forEach((link) => {
  link.addEventListener("click", (e) => {
    e.preventDefault(); // Stop default scrolling/hash update
    const tabId = link.getAttribute("data-tab"); // Get tab ID (e.g., "1")
    const hash = link.getAttribute("href"); // Get the desired hash (e.g., "#tab-1")

    // Update the URL hash without scrolling
    history.pushState(null, null, hash);

    // Show the selected tab
    if (tabId == 1) {
      showPage(1);
    } else {
      showTab(tabId);
    }
  });
});

// Handle back/forward buttons (popstate event)
window.addEventListener("popstate", () => {
  const currentHash = window.location.hash; // Get current hash (e.g., "#tab-2")
  if (currentHash) {
    if (currentHash.startsWith("#page")) {
      const pageId = currentHash.replace("#page-", "");
      showPage(pageId);
    } else {
      tabKey = currentHash.substring(1);
      console.log("tabKey (popstate): " + tabKey);
      const tabId = tabs[tabKey];
      console.log("tabId (popstate): " + tabId);
      showTab(tabId);
    }
  } else {
    document.querySelector(".page-nav").classList.add("active");
    showPage(1);
  }
});

// Initialize: Show the tab matching the initial hash (or Tab 1)
window.addEventListener("DOMContentLoaded", () => {
  const initialHash = window.location.hash;
  console.log("initialHash:" + initialHash);
  if (initialHash) {
    if (initialHash.startsWith("#page")) {
      const pageId = initialHash.replace("#page-", "");
      showPage(pageId);
    } else {
      tabKey = initialHash.substring(1);
      console.log("tabKey (DOMcontentLoaded): " + tabKey);
      const tabId = tabs[tabKey];
      console.log("tabId (DOMcontentLoaded): " + tabId);
      showTab(tabId);
    }
  } else {
    console.log("No initialHash");
    showPage(1);
  }
});

// Add event listeners to page navigation buttons
backButton.addEventListener("click", () => {
  if (currentPageIndex > 0) {
    currentPageIndex -= 1;
    showPage(currentPageIndex + 1);
    osdPreviousPage();
  }
});

forwardButton.addEventListener("click", () => {
  if (currentPageIndex < pageSections.length - 1) {
    currentPageIndex += 1;
    showPage(currentPageIndex + 1);
    osdNextPage();
  }
});
