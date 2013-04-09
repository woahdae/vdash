require 'open-uri'

class RemoteLink
  attr_accessor :url, :document

  # Throws SocketError if URL cannot be resolved. Not sure about timeouts.
  def initialize(url)
    self.url      = url
    self.document = Nokogiri::HTML(open url)
  end

  def title
    document.title
  end

  def first_paragraph
    document.xpath('//p').first.try(:text)
  end

  def as_json
    {
      title:           title,
      first_paragraph: first_paragraph
    }
  end
end
