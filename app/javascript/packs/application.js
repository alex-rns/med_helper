// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
// import '../stylesheets/application'
import "@fortawesome/fontawesome-free/js/all";
import "@fortawesome/fontawesome-free/css/all";
import "channels"
import "bootstrap"
import "jquery-ui/ui/widgets/autocomplete"
Rails.start()
Turbolinks.start()
ActiveStorage.start()
// THIS IS MAKING jQuery AVAILABLE EVEN INSIDE Views FOLDER
// global.$ = require("jquery")

// import "jquery" // Don't really need to require this...
import "jquery-ui/ui/widgets/autocomplete"

$(document).on('ready', function () {
  $('#eventStartDate').on('change', function () {
    debugger
  })
})
