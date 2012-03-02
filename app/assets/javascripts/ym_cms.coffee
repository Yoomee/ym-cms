YmCms =
  Page:
    Form:
      init: () ->
        YmCms.Page.Form.showViewTab()
        $('#page_view_name').change =>
          YmCms.Page.Form.showViewTab()
      showViewTab: () ->
        $('#page_view_name option').not(':selected').each (idx,option) =>
          $('.tabbable .nav li').has("a[href='##{$(option).val()}']").hide()
        view_name = $('#page_view_name').val()
        $('.tabbable .nav li').has("a[href='##{view_name}']").show()

$(document).ready ->
  YmCms.Page.Form.init()




jQuery(window).on "mercury:ready", ->
  link = $("#mercury_iframe").contents().find("#mercury_edit_link")
  Mercury.saveURL = link.data("save-url")
  link.hide()

jQuery(window).on "mercury:saved", ->
  window.location = window.location.href.replace(/\/editor\//i, "/")