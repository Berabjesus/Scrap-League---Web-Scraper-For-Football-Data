class Parser
  def parse
    Nokogiri::HTML(URI.open(@url))
  rescue OpenURI::HTTPError => e
    raise e unless e.message == '404 Not Found'
  end
end
