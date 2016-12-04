# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Video viewer Page' do
  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end

  it '(HAPPY) should see video viewer page' do
    @browser.goto video_viewer_page(EXISTS_VIDEO_URL)
    # @browser.trs(class: 'group_row').count.must_be :>=, 10
    # first_row = @browser.trs(class: 'group_row').first
    # first_row.img(class: 'group_media').visible?.must_equal true
  end
end
