window.YmCms =
  Page:
    Form:
      init: () ->
        YmCms.Page.Form.showViewTab()
        $('#page_view_name').change =>
          YmCms.Page.Form.showViewTab()
        YmCms.Page.Form.updatePublishedAt()
        $('#page_published_at').change =>
          YmCms.Page.Form.updatePublishedAt()
      showViewTab: () ->
        $('#page_view_name option').not(':selected').each (idx,option) =>
          $('.tabbable .nav li').has("a[href='##{$(option).val()}']").hide()
        view_name = $('#page_view_name').val()
        $('.tabbable .nav li').has("a[href='##{view_name}']").show()
      saveOrder: ->
        $('#orderable_pages li').each (idx, el) =>
          $('#sortable_id_' + idx).val $(el).data('sortable-id')
      updatePublishedAt: () ->
        datePickerField = $('#page_published_at_s_input')
        if $('#page_published_at').attr('checked')
          datePickerField.find('input').val ''
          datePickerField.hide()
        else
          datePickerField.show()
        
      
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
      slideCount = $('div.slideshow .slide').length
      if slideCount > 0
        YmCms.Slideshow.slideWidth = $('div.slideshow .slide').outerWidth(true)
        $('div.slideshow div.slideshow_inner').css('width', YmCms.Slideshow.slideWidth * $('div.slideshow .slide').length)
        $('div.slideshow .slide img:first').load ->  
          $('.slideshow_container').css('height', `$(this).parent().height()`)
        if slideCount > 1
          # for auto scrolling
          YmCms.Slideshow.intervalTime = options.interval
          YmCms.Slideshow.resetInterval()
          $('div.slideshow .slide').click (event) ->
            event.preventDefault()
            YmCms.Slideshow.nextSlide()
      $(window).resize ->
        YmCms.Slideshow.reAlign()
      YmCms.Slideshow.reAlign()
    reAlign: () ->
      leftPos = ($(window).width() - 940)/2
      leftPos = 0 if leftPos < 0
      $('.slideshow .slide_inner').css('left', leftPos)
    resetInterval: () ->
      if YmCms.Slideshow.intervalTime != undefined
        if YmCms.Slideshow.interval != undefined
          window.clearInterval(YmCms.Slideshow.interval)
        YmCms.Slideshow.interval = window.setInterval("YmCms.Slideshow.nextSlide()", YmCms.Slideshow.intervalTime)
    nextSlide: () ->
      $('div.slideshow .slide').removeClass("next_slide")
      if $('div.slideshow .slide').length > 2
        $($('div.slideshow .slide')[2]).addClass("next_slide")
      currentHeight = $('.slideshow_container').height()
      nextSlideHeight = $($('div.slideshow .slide .slide_inner')[1]).height();
      if currentHeight < nextSlideHeight
        $('.slideshow_container').animate {height: "+=#{nextSlideHeight-currentHeight}"}, 500
      else
        $('.slideshow_container').animate {height: "-=#{currentHeight-nextSlideHeight}"}, 500
      $('div.slideshow div.slideshow_inner').animate {left: "-=#{YmCms.Slideshow.slideWidth}"}, 500, ->
        currentSlide = $('div.slideshow .slide:first')
        if $('div.slideshow .slide').length <= 2
          currentSlide.addClass("next_slide")
        $.scrollTo(currentSlide, 500, {offset: -10})
        $('div.slideshow div.slideshow_inner').append(currentSlide.detach()).css('left', 0)
        YmCms.Slideshow.resetInterval()
