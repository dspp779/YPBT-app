# frozen_string_literal: true

class TimeTagsDetailView < SimpleDelegator
  def initialize(timetag)
    super(timetag)
  end

  def text_display_html
    to_html comment_text_display
  end

  private

  def to_html(text)
    url_pattern = %r/(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/
    text.gsub(url_pattern, '<a href=\1>\1</a>').gsub(/\n/, '<br>')
  end

end
