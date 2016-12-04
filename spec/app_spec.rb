# frozen_string_literal: true
require_relative 'spec_helper'

describe 'APP basics' do
  it 'should find configuration information' do
    app.config.YOUTUBE_API_KEY.length.must_be :>, 0
    app.config.YPBT_API.length.must_be :>, 0
  end

  it 'should successfully find the root route' do
    get homepage
    last_response.status.must_equal 200
  end
end
