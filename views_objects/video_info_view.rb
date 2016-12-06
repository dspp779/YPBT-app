# frozen_string_literal: true

class VideoInfoView < SimpleDelegator
  def initialize(video)
    super(video)
  end

  def description_html
    description.gsub(/\n/, '<br>')
  end

  def channel_url
    'https://www.youtube.com/channel/' + channel_id
  end

  def description_first(first_n = 3)
    return @description_first if @description_first && @first_n == first_n
    split_description first_n
    @description_first
  end

  def description_remain(first_n = 3)
    return @description_remain if @description_remain && @first_n == first_n
    split_description first_n
    @description_remain
  end

  private

  def split_description(first_n)
    description_lines = description.split "\n"
    @first_n = first_n
    line_num = description_lines.length
    if line_num > first_n
      @description_first = to_html(description_lines[0..first_n].join("\n"))
      @description_remain = to_html(description_lines[first_n + 1..line_num].join("\n"))
    elsif line_num > 1
      @description_first = to_html(description_lines[0..first_n].join("\n"))
      @description_remain = ''
    else
      @description_first = ''
      @description_remain = ''
    end
  end

  def to_html(text)
    url_pattern = %r/(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/
    text.gsub(url_pattern, '<a href=\1>\1</a>').gsub(/\n/, '<br>')
  end
end
