import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "input"]

  check(event) {
    this.imageTargets.forEach(img => img.classList.remove('border-dark'))
    this.inputTarget.value = event.currentTarget.id
    event.currentTarget.classList.add('border-dark');
  }
}
