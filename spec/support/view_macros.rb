module ViewMacros

  def title(title)
    /<title>#{title}<\/title>/i
  end

  def message(message)
    /<p>『#{message}』<\/p>/i
  end

end