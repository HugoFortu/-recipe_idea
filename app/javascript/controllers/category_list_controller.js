import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "ingredient"]

  connect() {
    var firstCategory = this.categoryTargets[0];
    firstCategory.classList.add('bg-active');
    this.ingredientTargets.forEach(ingredient => {
      if (ingredient.id == firstCategory.id) {
        ingredient.classList.remove('d-none')
      }
  })
}

  click(event) {
    this.categoryTargets.forEach(category => category.classList.remove('bg-active'))
    this.categoryTargets.forEach(category => category.classList.add('bg-inactive'))
    this.ingredientTargets.forEach(ingredient => ingredient.classList.add('d-none'))
    event.currentTarget.classList.add('bg-active');
    this.ingredientTargets.forEach(ingredient => {
      if (ingredient.id == event.currentTarget.id) {
          ingredient.classList.remove('d-none')
        }
    })
  }
}
