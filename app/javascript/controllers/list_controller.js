import { Controller } from "@hotwired/stimulus"
import { patch } from '@rails/request.js'

export default class extends Controller {
  static targets = ['checked'];

  async updateElement() {
    await patch(this.data.get("update-url"), { body: { checked: this.checkedTarget.checked } })
    }
  }
