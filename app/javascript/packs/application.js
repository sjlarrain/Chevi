// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";  // Make sure the CSS is imported

document.addEventListener("turbo:load", () => {
  flatpickr("#session_date", {
    dateFormat: "Y-m-d",  // Adjust the format as needed
  });
});
