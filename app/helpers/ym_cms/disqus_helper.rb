module YmCms::DisqusHelper

  def disqus_thread(object, shortname)
    out = content_tag(:div, nil, :id => 'disqus_thread')
    disqus_js =<<-JAVASCRIPT
    var disqus_shortname = '#{disqus_shortname(shortname)}'; // required: replace example with your forum shortname
    var disqus_identifier = '#{disqus_id(object)}';
    var disqus_developer = #{(Rails.env == 'development' || http_basic_authenticated?) ? 1 : 0};
    (function() {
      var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
      dsq.src1 = 'http://' + disqus_shortname + '.disqus.com/embed.js';
      (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
    JAVASCRIPT
    out << javascript_tag(disqus_js)
    out << link_to("blog comments powered by <span class='logo-disqus'>Disqus</span>", "http://disqus.com")    
  end
  
  def disqus_counts
    disqus_js =<<-JAVASCRIPT
    var disqus_shortname = '#{disqus_shortname(shortname)}'; // required: replace example with your forum shortname
    var disqus_developer = #{(Rails.env =='development' || http_basic_authenticated?) ? 1 : 0};

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function () {
        var s = document.createElement('script'); s.async = true;
        s.type = 'text/javascript';
        s.src = 'http://' + disqus_shortname(shortname) + '.disqus.com/count.js';
        (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
    }());
    JAVASCRIPT
    javascript_tag(disqus_js)
  end
  
  def disqus_latest
    url = "http://#{disqus_shortname(shortname)}.disqus.com/recent_comments_widget.js?num_items=3&hide_avatars=1&avatar_size=32&excerpt_length=200"
    javascript_include_tag(url)
  end 
  
  def disqus_id(object)
    "#{Rails.env =='development' ? 'Dev' : ''}#{object.class.to_s}#{object.id}"
  end
  
  def disqus_shortname(shortname)
    Rails.env == 'production' ? shortname : 'yoomeedev'
  end

  private
  def http_basic_authenticated?
    !Settings.http_basic_username.blank?
  end

end