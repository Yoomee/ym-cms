#= require redactor

window.YmCms =
  Page:
    Form:
      init: () ->
        Redactor.init()
        YmCms.Page.Form.showViewTab()
        $('#page_view_name').change =>
          YmCms.Page.Form.showViewTab()
        $('button.btn.current-view-name').click (event) ->
          event.preventDefault()
        $('.set-view-name').click (event) ->
          event.preventDefault()
          YmCms.Page.Form.updateView($(this).data('view-name'))
      showViewTab: () ->
        $('#page_view_name option').not(':selected').each (idx,option) =>
          $('.tabbable .nav li').has("a[href='##{$(option).val()}']").hide()
        view_name = $('#page_view_name').val()
        $('.tabbable .nav li').has("a[href='##{view_name}']").show()
      saveOrder: ->
        $('#orderable_pages li').each (idx, el) =>
          $('#sortable_id_' + idx).val $(el).data('sortable-id')
      updateView: (view_name) ->
        $('input#page_view_name').val(view_name)
        $('#view-name-inputs .btn.current-view-name span').removeClass('active')
        $("#view-name-inputs .btn.current-view-name span##{view_name}").addClass('active')
      
  Slideshow:
    Form:
      slideHtml: "",
      newSlidesCount: 0,
      init: () ->
        $('fieldset .delete_slide_link').live ('click'), ->
          event.preventDefault()
          YmCms.Slideshow.Form.deleteSlide(`$(this)`)
        $('#add_slide_link').click =>
          event.preventDefault()
          YmCms.Slideshow.Form.addSlide()
        YmCms.Slideshow.Form.updateMediaType()
        $('.media_type_choice').live 'click', ->
          YmCms.Slideshow.Form.updateMediaType()
      addSlide: () ->
        $('#add_slide_link').before(YmCms.Slideshow.Form.formattedSlideHtml())
      deleteSlide: (linkElem) ->
        if (confirm("Are you sure?"))
          fieldsetParent = linkElem.parents("fieldset:first")
          fieldsetParent.find(".destroy_input").val(1)
          fieldsetParent.fadeOut()
      formattedSlideHtml: () ->
        html = YmCms.Slideshow.slideHtml
        html = html.replace /(slides_attributes_)(\d)/g, (wholeMatch, firstMatch, secondMatch) ->
          return (firstMatch + (YmCms.Slideshow.Form.newSlidesCount + parseInt(secondMatch, 10)))
        html = html.replace /(\[slides_attributes\])\[(\d)\]/g, (wholeMatch, firstMatch, secondMatch) ->
          return (firstMatch + "[" + (YmCms.Slideshow.Form.newSlidesCount + parseInt(secondMatch, 10)) + "]")
        YmCms.Slideshow.Form.newSlidesCount += 1
        return html
      updateMediaType: () ->
        $('.image_field, .video_field').hide()
        checkedSlideInputs = $('.media_type_choice:checked')#.closest '.slide_inputs'
        checkedSlideInputs.each (idx, element) =>
          element = $(element)
          checkedVal = element.val()
          slideInputs = element.closest '.slide_inputs'
          $(slideInputs.find(".#{checkedVal}_field")).show()
    init: (options) ->
      options = {} if options == undefined
      $('#slideshow-carousel').carousel(options)
