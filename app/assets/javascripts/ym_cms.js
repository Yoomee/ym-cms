#= require redactor
window.YmCms = {
  Page: {
    Form: {
      init: function() {
        // Redactor.init();
        YmCms.Page.Form.showViewTab();
        $('#page_view_name').change((function(_this) {
          return function() {
            return YmCms.Page.Form.showViewTab();
          };
        })(this));
        $('button.btn.current-view-name').click(function(event) {
          return event.preventDefault();
        });
        return $('.set-view-name').click(function(event) {
          event.preventDefault();
          return YmCms.Page.Form.updateView($(this).data('view-name'), $(this).data('view-title'));
        });
      },
      showViewTab: function() {
        var view_name;
        $('#page_view_name option').not(':selected').each((function(_this) {
          return function(idx, option) {
            return $('.tabbable .nav li').has("a[href='#" + ($(option).val()) + "']").hide();
          };
        })(this));
        view_name = $('#page_view_name').val();
        return $('.tabbable .nav li').has("a[href='#" + view_name + "']").show();
      },
      saveOrder: function() {
        return $("[id ^= 'orderable_'] li").each((function(_this) {
          return function(idx, el) {
            return $('#sortable_id_' + idx).val($(el).data('sortable-id'));
          };
        })(this));
      },
      updateView: function(view_name, view_title) {
        $('input#page_view_name').val(view_name);
        $('span#page-view-title').html(view_title);
        $('ul.dropdown-menu.page-view-names li').removeClass('active');
        return $("ul.dropdown-menu.page-view-names li#" + view_name).addClass('active');
      }
    }
  },
  Slideshow: {
    Form: {
      slideHtml: "",
      newSlidesCount: 0,
      init: function() {
        $('fieldset .delete_slide_link').live('click', function() {
          event.preventDefault();
          return YmCms.Slideshow.Form.deleteSlide($(this));
        });
        $('#add_slide_link').click((function(_this) {
          return function() {
            event.preventDefault();
            return YmCms.Slideshow.Form.addSlide();
          };
        })(this));
        YmCms.Slideshow.Form.updateMediaType();
        return $('.media_type_choice').live('click', function() {
          return YmCms.Slideshow.Form.updateMediaType();
        });
      },
      addSlide: function() {
        return $('#add_slide_link').before(YmCms.Slideshow.Form.formattedSlideHtml());
      },
      deleteSlide: function(linkElem) {
        var fieldsetParent;
        if (confirm("Are you sure?")) {
          fieldsetParent = linkElem.parents("fieldset:first");
          fieldsetParent.find(".destroy_input").val(1);
          return fieldsetParent.fadeOut();
        }
      },
      formattedSlideHtml: function() {
        var html;
        html = YmCms.Slideshow.slideHtml;
        html = html.replace(/(slides_attributes_)(\d)/g, function(wholeMatch, firstMatch, secondMatch) {
          return firstMatch + (YmCms.Slideshow.Form.newSlidesCount + parseInt(secondMatch, 10));
        });
        html = html.replace(/(\[slides_attributes\])\[(\d)\]/g, function(wholeMatch, firstMatch, secondMatch) {
          return firstMatch + "[" + (YmCms.Slideshow.Form.newSlidesCount + parseInt(secondMatch, 10)) + "]";
        });
        YmCms.Slideshow.Form.newSlidesCount += 1;
        return html;
      },
      updateMediaType: function() {
        var checkedSlideInputs;
        $('.image_field, .video_field').hide();
        checkedSlideInputs = $('.media_type_choice:checked');
        return checkedSlideInputs.each((function(_this) {
          return function(idx, element) {
            var checkedVal, slideInputs;
            element = $(element);
            checkedVal = element.val();
            slideInputs = element.closest('.slide_inputs');
            return $(slideInputs.find("." + checkedVal + "_field")).show();
          };
        })(this));
      }
    },
    init: function(options) {
      if (options === void 0) {
        options = {};
      }
      return $('#slideshow-carousel').carousel(options);
    }
  }
};

$(document).ready(function(){

  if ($('[data-ym-cms-form-init="true"]').length) {
    YmCms.Page.Form.init()
  }

  if ($('[data-slideshow-form-init="true"]').length) {
    YmCms.Slideshow.Form.init();
  }

  if ($('[data-load-slideshow-html]').length) {
    YmCms.Slideshow.slideHtml = $('[data-load-slideshow-html]').data('load-slideshow-html');
  }

  if ($('[data-slideshow-init="true"]').length) {
    YmCms.Slideshow.init();
  }

  if ($('#orderable_pages').length) {
    $('#orderable_pages').sortable({
      axis: "y",
      handle: ".handle",
      stop: function(event, ui) {
        YmCms.Page.Form.saveOrder();
      }
    });
  }

});
