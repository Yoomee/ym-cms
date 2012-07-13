module YmCms::TextHelper

  def contentize(text, options={})
      auto_link(raw(text))
  end

end