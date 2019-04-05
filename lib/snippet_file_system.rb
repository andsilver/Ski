# Provides a file system for Liquid that get snippets from ActiveRecord.
class SnippetFileSystem
  def read_template_file(template_path, context)
    Snippet.find_by(name: template_path, locale: "en").try(:snippet)
  end
end
