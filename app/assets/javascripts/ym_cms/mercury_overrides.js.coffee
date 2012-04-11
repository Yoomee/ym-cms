jQuery(window).on "mercury:ready", ->
  link = $("#mercury_iframe").contents().find("#mercury_edit_link")
  Mercury.saveURL = link.data("save-url")
  link.hide()

jQuery(window).on "mercury:saved", ->
  window.location = window.location.href.replace(/\/editor\//i, "/")