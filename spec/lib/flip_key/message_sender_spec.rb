module FlipKey
  describe MessageSender do
    describe '#xml' do
      let(:comment)      { 'Any Wi-Fi?' }
      let(:email)        { 'ianf@yesl.co.uk' }
      let(:guests)       { '4' }
      let(:name)         { 'Ian <dodgy> XML' }
      let(:phone_number) { '01234 567890' }
      let(:property_id)  { '201027' }
      let(:user_ip)      { '127.0.0.1' }
      let(:ms) { MessageSender.new({
        check_in: Date.new(2014, 1, 1),
        check_out: Date.new(2014, 1, 8),
        comment: comment,
        email: email,
        guests: guests,
        name: name,
        phone_number: phone_number,
        property_id: property_id,
        user_ip: user_ip,
      }) }

      let(:xml) { XmlSimple.xml_in(ms.xml) }

      it 'has FK as the source' do
        expect(xml['header'][0]['source'][0]).to eq 'FK'
      end

      it 'includes the request date' do
        expect(xml['data'][0]['request_date'][0]).to be_present
      end

      it 'includes name' do
        expect(xml['data'][0]['name'][0]).to eq name
      end

      it 'includes total_guests' do
        expect(xml['data'][0]['total_guests'][0]).to eq guests
      end

      it 'includes check_in' do
        expect(xml['data'][0]['check_in'][0]).to eq '2014-01-01'
      end

      it 'includes check_out' do
        expect(xml['data'][0]['check_out'][0]).to eq '2014-01-08'
      end

      it 'includes comment' do
        expect(xml['data'][0]['comment'][0]).to eq comment
      end

      it 'includes property_id' do
        expect(xml['data'][0]['property_id'][0]).to eq property_id
      end

      it 'includes email' do
        expect(xml['data'][0]['email'][0]).to eq email
      end

      it 'includes phone_number' do
        expect(xml['data'][0]['phone_number'][0]).to eq phone_number
      end

      it 'includes newsletter_opt_in' do
        expect(xml['data'][0]['newsletter_opt_in'][0]).to eq '0'
      end

      it 'includes user_ip' do
        expect(xml['data'][0]['user_ip'][0]).to eq user_ip
      end

      it 'includes point_of_sale' do
        expect(xml['data'][0]['point_of_sale'][0]).to eq 'mychaletfinder.com'
      end

      it 'includes utm_medium' do
        expect(xml['data'][0]['utm_medium'][0]).to eq 'csynd'
      end

      it 'includes utm_source' do
        expect(xml['data'][0]['utm_source'][0]).to eq 'mychaletfinder'
      end

      it 'includes utm_campaign' do
        expect(xml['data'][0]['utm_campaign'][0]).to eq 'Host&Post'
      end
    end
  end
end
