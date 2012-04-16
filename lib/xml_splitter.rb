# A class for splitting large XML documents into multiple smaller documents
class XMLSplitter
  XML_HEADER = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

  # Root level element, for example: 'accommodations'
  attr_accessor :root_element
  # Main child element, for example: 'accommodation'
  attr_accessor :child_element
  # Path to the large source XML file.
  # Smaller files will be named filename.n.xml where n begins at 0
  attr_accessor :xml_filename
  # Number of main child elements to place into each smaller document
  attr_accessor :elements_per_file
  # Maximum number of XML files to create. Extra data is ignored.
  attr_accessor :max_files

  def initialize(opts)
    @root_element = opts[:root_element] if opts[:root_element]
    @child_element = opts[:child_element] if opts[:child_element]
    @xml_filename = opts[:xml_filename] if opts[:xml_filename]
    @elements_per_file = opts[:elements_per_file] if opts[:elements_per_file]
    @max_files = opts[:max_files]
    @max_files = nil if @max_files == 0
  end

  def split
    tag = ''
    in_tag = false
    open_tag = "<#{@child_element}>"
    close_tag = "</#{@child_element}>"
    chunk = 0
    started = false
    current = 0
    filenames = []

    src = File.open(@xml_filename, 'r')

    # Output is discarded until the root element has been read
    dst = File.open('/dev/null', 'w')

    until (c=src.getc).nil? do
      dst.putc(c)

      if c.chr == '>'
        tag += c.chr
        in_tag = false

        if tag == close_tag
          dst.putc("\n")
          current += 1
          if current == @elements_per_file
            current = 0
            chunk += 1
            break if @max_files && chunk >= @max_files
            dst.puts "</#{@root_element}>"
            dst.close

            dst = start_file(chunk, filenames)
          end
        end
        if tag == open_tag && !started
          dst.close
          dst = start_file(chunk, filenames)
          dst.puts(tag)
          started = true
        end
        tag = ''
      elsif c.chr == '<'
        in_tag = true
      end
      tag += c.chr if in_tag
    end

    dst.puts "</#{@root_element}>"
    dst.close
    filenames
  end

  protected

  def xml_output_filename(chunk)
    @xml_filename.gsub('.xml', ".#{chunk}.xml")
  end

  def start_file(chunk, filenames)
    filenames << xml_output_filename(chunk)
    dst = File.open(xml_output_filename(chunk), 'w')
    dst.puts XML_HEADER
    dst.puts "<#{@root_element}>"
    dst
  end
end
