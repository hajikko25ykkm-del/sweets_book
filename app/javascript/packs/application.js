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

document.addEventListener('DOMContentLoaded', () => {
  // 材料追加ボタン
  const addIngredientBtn = document.getElementById('add-ingredient');
  if (addIngredientBtn) {
    addIngredientBtn.addEventListener('click', () => {
      const container = document.getElementById('ingredient-container');
      const fields = container.getElementsByClassName('ingredient-field');
      const newIndex = fields.length; // 現在の数 = 次のインデックス
      
      const newField = fields[0].cloneNode(true); // 最初の欄をコピー
      
      // inputタグのnameとidの数字を書き換える
      newField.querySelectorAll('input').forEach(input => {
        input.value = ''; // 中身を空にする
        input.name = input.name.replace(/\[\d+\]/, `[${newIndex}]`);
        input.id = input.id.replace(/_\d+_/, `_${newIndex}_`);
      });
      container.appendChild(newField);
    });
  }

  // 工程追加ボタン（材料とほぼ同じ）
  const addStepBtn = document.getElementById('add-step');
  if (addStepBtn) {
    addStepBtn.addEventListener('click', () => {
      const container = document.getElementById('step-container');
      const fields = container.getElementsByClassName('step-field');
      
      if (fields.length === 0) return; // コピー元がない場合は終了

      const newIndex = fields.length;
      const newField = fields[0].cloneNode(true); // 1つ目をコピー

      // textarea と input の両方を対象にする
      newField.querySelectorAll('textarea, input').forEach(el => {
        el.value = ''; // 入力内容をクリア
        // name属性とid属性の数字を更新 (例: [0] -> [1])
        el.name = el.name.replace(/\[\d+\]/, `[${newIndex}]`);
        el.id = el.id.replace(/_\d+_/, `_${newIndex}_`);
      });

      // 工程番号の更新
      const stepNum = newField.querySelector('.step-num');
      if (stepNum) {
        stepNum.textContent = newIndex + 1;
      }

      // position（隠しフィールド）があれば更新
      const positionField = newField.querySelector('.step-position');
      if (positionField) {
        positionField.value = newIndex + 1;
      }

      container.appendChild(newField);
      console.log("工程を追加しました。現在の数:", newIndex + 1);
    });
  }
});