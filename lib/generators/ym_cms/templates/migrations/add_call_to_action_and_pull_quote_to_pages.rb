def AddCallToActionAndPullQuoteToPages

  def change
    add_column :pages, :call_to_action, :text
    add_column :pages, :pull_quote, :text
  end

end