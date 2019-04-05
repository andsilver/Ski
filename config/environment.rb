# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Use Active Record for Liquid templates.
Liquid::Template.file_system = SnippetFileSystem.new
