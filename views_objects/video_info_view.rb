# frozen_string_literal: true

class VideoInfoView < Video
  def description_html
    description.gsub(/\n/, '<br>')
  end

  def channel_url
    'https://www.youtube.com/channel/'
  end

  def description_first(first_n = 3)
    return @description_first.gsub(/\n/, '<br>') if @description_first && @first_n == first_n
    split_description first_n
    @description_first.gsub(/\n/, '<br>')
  end

  def description_remain(first_n = 3)
    return @description_remain.gsub(/\n/, '<br>') if @description_remain && @first_n == first_n
    split_description first_n
    @description_remain.gsub(/\n/, '<br>')
  end

  private

  def split_description(first_n)
    @first_n = first_n
    description_lines = description.split "\n"
    line_num = description_lines.length
    @description_first = description_lines[0..first_n].join "\n"
    @description_remain = description_lines[first_n + 1..line_num].join "\n"
  end
end
