module ApplicationHelper

  def urls_to_images(str)
    sanitize str.gsub(/\s(http:\/\/.*?\.(png|jpg))\s/, '<p><img src="\1"/></p>')

  end

  def urls_to_links(str)
    sanitize str.gsub(/\s(http:\/\/.*?)\s/, '<a href="\1">\1</a>')
  end
end
