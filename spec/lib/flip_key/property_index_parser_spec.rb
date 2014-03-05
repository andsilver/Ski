require 'spec_helper'

module FlipKey
  describe PropertyIndexParser do
    let(:test_index) {
      <<-EOHTML
      <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
      <html>
       <head><title>Index of /pfe</title></head>
       <body>
      <h1>Index of /pfe</h1>
      <pre>      <a href="?C=N;O=D">Name</a>                    <a href="?C=M;O=A">Last modified</a>      <a href="?C=S;O=A">Size</a>  <a href="?C=D;O=A">Description</a><hr>      <a href="/">Parent Directory</a>                             -   
            <a href="locations/">locations/</a>              2014-02-25 10:54    -   
            <a href="property_data_0.xml.gz">property_data_0.xml.gz</a>  2014-02-25 10:53  7.7M  
            <a href="property_data_1.xml.gz">property_data_1.xml.gz</a>  2014-02-25 10:53  7.5M  
            <a href="property_data_23.xml.gz">property_data_23.xml.gz</a>  2014-02-25 10:53  8.2M  
            <a href="test">test</a>                    2013-01-22 09:40    0   
      <hr></pre>
      <address>Apache Server at ws.flipkey.com Port 80</address>
      </body></html>
      EOHTML
    }
    let(:source) { double(IO, read: test_index) }
    let(:parser) { PropertyIndexParser.new(source) }

    describe '#parse' do
      it 'returns an array of property data files' do
        expect(parser.parse).to eq [
          'property_data_0.xml.gz',
          'property_data_1.xml.gz',
          'property_data_23.xml.gz'
        ]
      end
    end
  end
end
