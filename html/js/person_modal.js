// This funtion is used to show a modal with person details
// when a row in the Tabulator table is clicked.
// It uses Bootstrap's modal component to display the information.

var personModal = new bootstrap.Modal(document.getElementById("person-modal"));

function showPersonModal(data) {
  if (!personModal) return;

  const modalTitle = document.getElementById("person-modal-title");
  const modalBody = document.getElementById("person-modal-body");

  if (modalTitle) {
    modalTitle.innerHTML =
      data && data["name"] ? data["name"] : "Person details";
  }

  if (modalBody) {
    modalBody.innerHTML =
      data && data["mentioned_in"]
        ? `<p><strong>Mentioned in:</strong></p><ul>` +
          data["mentioned_in"] +
          `</ul>`
        : "<p>No additional information available.</p>";
  }

  personModal.show();
}

if (personModal) {
  personModal.hide();
}
