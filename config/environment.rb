# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Use Active Record for Liquid templates.
Liquid::Template.file_system = SnippetFileSystem.new
