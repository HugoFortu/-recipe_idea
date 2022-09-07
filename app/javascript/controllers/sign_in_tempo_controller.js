import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["loading", "form"]

  connect() {
  }

  submit(event) {
    event.preventDefault();
    let form_target = this.formTarget;
    this.formTarget.classList.add('d-none');
    this.loadingTarget.classList.remove('d-none');
    setTimeout(function () {
      form_target.submit();
    }, 3000);
  }
}
