import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="editable"
export default class extends Controller {
  
  static values = { field: String, url: String }

  connect() {
    console.log('editable connected.')
    this.element.setAttribute('data-action', "focusout->editable#update");
  }

  update() {
    const value = this.element.textContent.trim();
    const field = this.element.dataset.editableField;
    const url = this.element.dataset.editableUrl;

    const data = {};
    data[field] = value;

    console.log(`Updating field ${field} with value ${value}`);

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content") 
      },
      body: JSON.stringify({ student: data }) 
    })
    .then(response => {
      if (response.ok) {
        console.log("Update successful");
      } else {
        console.error("Update failed", response.statusText);
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }
}
