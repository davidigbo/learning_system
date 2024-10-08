import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  toggle() {
    const ele = document.getElementById("mobile-link")
    const eleBar = document.getElementById("bars")
    const closeBar = document.getElementById("close")
    ele.classList.toggle("hidden")
    eleBar.classList.toggle("hidden")
    closeBar.classList.toggle("hidden")
  }
}
