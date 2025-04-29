import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Auto-dismiss after 5 seconds
    setTimeout(() => {
      this.close()
    }, 5000)
  }

  close() {
    this.element.classList.add('opacity-0')
    setTimeout(() => {
      this.element.remove()
    }, 300) // Remove after transition
  }
}
