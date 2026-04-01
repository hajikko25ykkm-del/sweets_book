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

document.addEventListener('turbolinks:load', () => {
  console.log("Turbolinks load: JS ready!");

  // --- 工程番号と属性名を振り直す共通関数 ---
  const updateStepNumbers = () => {
    const stepContainer = document.getElementById('step-container');
    if (!stepContainer) return;
    
    const fields = stepContainer.getElementsByClassName('step-field');
    Array.from(fields).forEach((field, index) => {
      const newNum = index + 1;
      
      // 1. バッジ番号の更新（text-whiteで白文字を確定）
      const badge = field.querySelector('.badge');
      if (badge) {
        badge.textContent = newNum;
        badge.classList.add('text-white'); 
      }
      
      // 2. hidden_field (position) の更新
      const positionField = field.querySelector('.step-position');
      if (positionField) positionField.value = newNum;
      
      // 3. input/textarea の name と id を正しいインデックスに更新
      field.querySelectorAll('textarea, input').forEach(el => {
        el.name = el.name.replace(/\[\d+\]/, `[${index}]`);
        el.id = el.id.replace(/_\d+_/, `_${index}_`);
      });
    });
  };

  // --- 材料追加ボタン ---
  const addIngredientBtn = document.getElementById('add-ingredient');
  if (addIngredientBtn) {
    addIngredientBtn.onclick = () => {
      const container = document.getElementById('ingredient-container');
      const fields = container.getElementsByClassName('ingredient-field');
      
      const newIndex = fields.length;
      if (newIndex > 0) {
        const newField = fields[0].cloneNode(true);
        newField.querySelectorAll('input').forEach(input => {
          input.value = '';
          input.name = input.name.replace(/\[\d+\]/, `[${newIndex}]`);
          input.id = input.id.replace(/_\d+_/, `_${newIndex}_`);
        });
        container.appendChild(newField);
      } else {
        const html = `
          <div class="ingredient-field row g-2 mb-2 align-items-center">
            <div class="col-7">
              <input class="form-control form-control-sm" placeholder="材料名" type="text" name="post[post_ingredients_attributes][0][ingredient_name]" id="post_post_ingredients_attributes_0_ingredient_name">
            </div>
            <div class="col-4">
              <input class="form-control form-control-sm" placeholder="分量" type="text" name="post[post_ingredients_attributes][0][quantity]" id="post_post_ingredients_attributes_0_quantity">
            </div>
            <div class="col-1 text-end">
              <button type="button" class="btn btn-outline-danger btn-sm remove-ingredient w-100">✕</button>
            </div>
          </div>`;
        container.insertAdjacentHTML('beforeend', html);
      }
    };
  }

  // --- 材料の削除 ---
  const ingredientContainer = document.getElementById('ingredient-container');
  if (ingredientContainer) {
    ingredientContainer.addEventListener('click', (e) => {
      if (e.target.classList.contains('remove-ingredient')) {
        e.target.closest('.ingredient-field').remove();
        
        const fields = ingredientContainer.getElementsByClassName('ingredient-field');
        Array.from(fields).forEach((field, index) => {
          field.querySelectorAll('input').forEach(input => {
            input.name = input.name.replace(/\[\d+\]/, `[${index}]`);
            input.id = input.id.replace(/_\d+_/, `_${index}_`);
          });
        });
      }
    });
  }

  // --- 工程追加ボタン ---
  const addStepBtn = document.getElementById('add-step');
  if (addStepBtn) {
    addStepBtn.onclick = () => {
      const container = document.getElementById('step-container');
      const fields = container.getElementsByClassName('step-field');
      
      const newIndex = fields.length;
      if (newIndex > 0) {
        const newField = fields[0].cloneNode(true);
        newField.querySelectorAll('textarea, input').forEach(el => {
          el.value = '';
          el.name = el.name.replace(/\[\d+\]/, `[${newIndex}]`);
          el.id = el.id.replace(/_\d+_/, `_${newIndex}_`);
        });
        container.appendChild(newField);
        updateStepNumbers();
      } else {
        const html = `
          <div class="step-field card bg-light p-3 mb-3">
            <div class="d-flex align-items-center mb-2">
              <span class="badge bg-secondary text-white me-2">1</span>
              <input class="form-control form-control-sm" type="file" name="post[steps_attributes][0][image]" id="post_steps_attributes_0_image">
              <button type="button" class="btn btn-outline-danger btn-sm ms-auto remove-step">✕</button>
            </div>
            <textarea class="form-control" rows="2" placeholder="手順を入力" name="post[steps_attributes][0][content]" id="post_steps_attributes_0_content"></textarea>
            <input value="1" class="step-position" type="hidden" name="post[steps_attributes][0][position]" id="post_steps_attributes_0_position">
          </div>`;
        container.insertAdjacentHTML('beforeend', html);
      }
    };
  }

  // --- 工程の削除 ---
  const stepContainer = document.getElementById('step-container');
  if (stepContainer) {
    stepContainer.addEventListener('click', (e) => {
      if (e.target.classList.contains('remove-step')) {
        e.target.closest('.step-field').remove();
        updateStepNumbers();
      }
    });
  }
});