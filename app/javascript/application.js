// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import '@hotwired/turbo-rails'
import 'alpine-turbo-drive-adapter'
import Alpine from 'alpinejs'
import "chartkick"
import "Chart.bundle"

window.Alpine = Alpine
Alpine.start()
