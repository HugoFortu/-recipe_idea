import { Controller } from "@hotwired/stimulus"
import { patch } from '@rails/request.js'


export default class extends Controller {
  static targets = ["img", "category"]
  connect() {
    this.imgTargets.forEach(img =>
    img.ondragstart = () => {
      return false;
      });
  }

  dragstart(event) {
    event.dataTransfer.setData("application/drag-key", event.target.getAttribute("data-ingredient-id"))
    event.dataTransfer.effectAllowed = "move"
  }

  dragover(event) {
    event.preventDefault()
    return true
  }

  dragenter(event) {
    event.preventDefault()
    this.categoryTargets.forEach(category => {
      category.classList.remove("drag-over")
    })
    if (event.target.classList.contains("category-parent")) {
      event.target.classList.add("drag-over")
    }
    // this.categoryTargets.forEach(div =>
    // div.classList.add("drag-over"));
  }

  async drop(event) {
    var ingredientData = event.dataTransfer.getData("application/drag-key")
    // console.log(ingredientData)
    var categoryData = event.target.dataset.categoryId
    const draggedItem = this.element.querySelector(`[data-ingredient-id='${ingredientData}']`);
    // const dropTarget = event.target
    // console.log(categoryData)
    // console.log(draggedItem.dataset.dragUpdateUrl)
    if (this.categoryTargets.includes(event.target)) {
      const response = await patch(draggedItem.dataset.dragUpdateUrl, { body: { user_category_id: categoryData } })
      if (response.ok) {
        draggedItem.classList.add("d-none")
        this.categoryTargets.forEach(category => {
          category.classList.remove("drag-over")
        })
      }
    }
    // console.log(draggedItem)
    // const positionComparison = dropTarget.compareDocumentPosition(draggedItem)
    // if (positionComparison & 4) {
    //   event.target.insertAdjacentElement('beforebegin', draggedItem);
    // } else if (positionComparison & 2) {
    //   event.target.insertAdjacentElement('afterend', draggedItem);
    // }

    event.preventDefault()
  }

  dragend(event) {
  }
}
