import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "input"]

  connect() {

  }

  check(event) {
    this.imageTargets.forEach(img => img.classList.remove('selected'))
    this.inputTarget.value = event.currentTarget.id
    event.currentTarget.classList.add('selected');
  }
}
