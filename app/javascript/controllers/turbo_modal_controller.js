import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  connect() {
    // Add event listener for ESC key to close modal
    document.addEventListener('keydown', this.handleKeydown.bind(this))
  }

  disconnect() {
    document.removeEventListener('keydown', this.handleKeydown.bind(this))
  }

  handleKeydown(event) {
    if (event.key === 'Escape' && !this.dialogTarget.classList.contains('hidden')) {
      this.closeModal()
    }
  }

  openModal() {
    this.dialogTarget.classList.remove('hidden')
    document.body.classList.add('overflow-hidden')
  }

  closeModal() {
    this.dialogTarget.classList.add('hidden')
    document.body.classList.remove('overflow-hidden')
  }
}
