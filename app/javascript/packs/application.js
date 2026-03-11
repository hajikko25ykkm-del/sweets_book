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

// ...省略（importなどはそのまま）

document.addEventListener('turbolinks:load', () => { // ここを書き換え！
  console.log("Turbolinks load: JS ready!"); // 確認用ログ

  // 返信ボタンの制御
  document.querySelectorAll('.reply-toggle').forEach(button => {
    button.addEventListener('click', (e) => {
      e.preventDefault();
      const id = button.dataset.id;
      const form = document.getElementById(`reply-form-${id}`);
      if (form) form.style.display = 'block';
    });
  });

  document.querySelectorAll('.cancel-reply').forEach(button => {
    button.addEventListener('click', () => {
      const id = button.dataset.id;
      const form = document.getElementById(`reply-form-${id}`);
      if (form) form.style.display = 'none';
    });
  });

  // 材料追加ボタン
  const addIngredientBtn = document.getElementById('add-ingredient');
  if (addIngredientBtn) {
    addIngredientBtn.addEventListener('click', () => {
      const container = document.getElementById('ingredient-container');
      const fields = container.getElementsByClassName('ingredient-field');
      const newIndex = fields.length;
      const newField = fields[0].cloneNode(true);
      
      newField.querySelectorAll('input').forEach(input => {
        input.value = '';
        input.name = input.name.replace(/\[\d+\]/, `[${newIndex}]`);
        input.id = input.id.replace(/_\d+_/, `_${newIndex}_`);
      });
      container.appendChild(newField);
    });
  }

  // 工程追加ボタン
  const addStepBtn = document.getElementById('add-step');
  if (addStepBtn) {
    addStepBtn.addEventListener('click', () => {
      const container = document.getElementById('step-container');
      const fields = container.getElementsByClassName('step-field');
      if (fields.length === 0) return;

      const newIndex = fields.length;
      const newField = fields[0].cloneNode(true);

      newField.querySelectorAll('textarea, input').forEach(el => {
        el.value = '';
        el.name = el.name.replace(/\[\d+\]/, `[${newIndex}]`);
        el.id = el.id.replace(/_\d+_/, `_${newIndex}_`);
      });

      // 工程番号のバッジ更新 (HTML側のクラス名に合わせる)
      const badge = newField.querySelector('.badge');
      if (badge) badge.textContent = newIndex + 1;

      const positionField = newField.querySelector('.step-position');
      if (positionField) positionField.value = newIndex + 1;

      container.appendChild(newField);
    });
  }
});