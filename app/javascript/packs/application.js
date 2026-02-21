// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.reply-toggle').forEach(button => {
    button.addEventListener('click', (e) => {
      e.preventDefault();
      const id = button.dataset.id;
      document.getElementById(`reply-form-${id}`).style.display = 'block';
    });
  });

  document.querySelectorAll('.cancel-reply').forEach(button => {
    button.addEventListener('click', () => {
      const id = button.dataset.id;
      document.getElementById(`reply-form-${id}`).style.display = 'none';
    });
  });
});
