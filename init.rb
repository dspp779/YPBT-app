# frozen_string_literal: true
folders = 'models,values,representers,forms,services,controllers,views_objects'
Dir.glob("./{#{folders}}/init.rb").each do |file|
  require file
end
