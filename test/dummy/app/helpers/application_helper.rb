module ApplicationHelper
  
  def can?(*args)
    false
  end
  
  def link_if_can(*args, &block)
    ""
  end
  
end
