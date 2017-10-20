require 'rails_helper'

require 'flip_key'

RSpec.describe FlipKeyPropertiesController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe 'POST send_message' do
    let(:flip_key_property) { FactoryGirl.create(:flip_key_property) }
    let!(:property) { FactoryGirl.create(:property, flip_key_property_id: flip_key_property.id) }

    let(:valid_check_in)    { '28 August, 2014' }
    let(:invalid_check_in)  { '29 August, 2014' }
    let(:valid_check_out)   { '30 August, 2014' }
    let(:invalid_check_out) { '31 August, 2014' }

    let(:ok_guests)       { '2' }
    let(:too_many_guests) { '3' }

    let(:valid_params) {{
      id: flip_key_property.id,
      check_in: valid_check_in,
      check_out: valid_check_out,
      comment: 'Can my pet lizard stay?',
      email: 'ian@example.com',
      guests: ok_guests,
      name: 'Ian',
      phone_number: '01234 567890'
    }}

    before do
      allow(FlipKeyProperty).to receive(:find).and_return(flip_key_property)
      allow(flip_key_property).to receive(:check_in_on?).with(Date.parse(valid_check_in)).and_return(true)
      allow(flip_key_property).to receive(:check_in_on?).with(Date.parse(invalid_check_in)).and_return(false)
      allow(flip_key_property).to receive(:check_in_and_out_on?).with(Date.parse(valid_check_in), Date.parse(valid_check_out)).and_return(true)
      allow(flip_key_property).to receive(:check_in_and_out_on?).with(Date.parse(invalid_check_in), Date.parse(valid_check_out)).and_return(false)
      allow(flip_key_property).to receive(:check_in_and_out_on?).with(Date.parse(valid_check_in), Date.parse(invalid_check_out)).and_return(false)
      allow(flip_key_property).to receive(:occupancy).and_return(2)
      allow(flip_key_property).to receive(:provider_property_id).and_return('123')
    end

    context 'with valid params' do
      it 'redirects to message_sent' do
        allow(controller).to receive(:save_copy_as_enquiry)
        allow(FlipKey::MessageSender).to receive(:new).and_return double(FlipKey::MessageSender).as_null_object
        post 'send_message', params: valid_params
        expect(response).to redirect_to(message_sent_flip_key_property_path(flip_key_property))
      end

      it 'instantiates a FlipKey::MessageSender' do
        allow(controller).to receive(:save_copy_as_enquiry)
        expect(FlipKey::MessageSender).to receive(:new).with(hash_including(
        check_in: Date.parse(valid_params[:check_in]),
        check_out: Date.parse(valid_params[:check_out]),
        comment: valid_params[:comment],
        email: valid_params[:email],
        guests: valid_params[:guests],
        phone_number: valid_params[:phone_number],
        property_id: flip_key_property.provider_property_id,
        user_ip: request.remote_ip
        )).and_return double(FlipKey::MessageSender).as_null_object
        post 'send_message', params: valid_params
      end

      it 'tells the MessageSender to send' do
        ms = double(FlipKey::MessageSender)
        allow(FlipKey::MessageSender).to receive(:new).and_return(ms)
        expect(ms).to receive(:send_message)
        post 'send_message', params: valid_params
      end

      context 'when message sending succeeds' do
        let(:message_sender) { double(FlipKey::MessageSender, send_message: true) }

        before do
          FactoryGirl.create(:user, email: FlipKey::user_email)
          allow(FlipKey::MessageSender).to receive(:new).and_return(message_sender)
        end

        it 'creates an enquiry' do
          post 'send_message', params: valid_params
          expect(Enquiry.find_by(user_id: FlipKey::user.id)).to be
        end

        it 'sends an email notification' do
          expect(EnquiryNotifier).to receive(:notify).and_call_original
          post 'send_message', params: valid_params
        end
      end

      context 'when message sending fails' do
        let(:message_sender) { double(FlipKey::MessageSender, send_message: false) }

        it 'should redirect back to the property' do
          allow(FlipKey::MessageSender).to receive(:new).and_return(message_sender)
          post 'send_message', params: valid_params
          expect_redirect
        end
      end
    end

    context 'without a name' do
      it 'should redirect back to the property' do
        post 'send_message', params: valid_params.merge(name: '')
        expect_redirect
      end
    end

    context 'without a phone number' do
      it 'should redirect back to the property' do
        post 'send_message', params: valid_params.merge(phone_number: '')
        expect_redirect
      end
    end

    context 'without a message' do
      it 'should redirect back to the property' do
        post 'send_message', params: valid_params.merge(comment: '')
        expect_redirect
      end
    end

    context 'with too many guests' do
      it 'should redirect back to the property' do
        post 'send_message', params: valid_params.merge(guests: too_many_guests)
        expect_redirect
      end
    end

    context 'with an invalid email address' do
      it 'should redirect back to the property' do
        post 'send_message', params: valid_params.merge(email: 'invalid@hotmail.')
        expect_redirect
      end
    end

    context 'with an invalid check-in date' do
      it 'should redirect back to the property' do
        post 'send_message', params: valid_params.merge(check_in: invalid_check_in)
        expect_redirect
      end
    end

    context 'with a valid check-in date and invalid check-out date' do
      it 'should redirect back to the property' do
        post 'send_message', params: valid_params.merge(check_out: invalid_check_out)
        expect_redirect
      end
    end

    def expect_redirect
      expect(response).to redirect_to(property_path(property))
    end
  end

  describe 'GET message_sent' do
    it 'finds and assigns @flip_key_property' do
      pending
      fkp = double(FlipKeyProperty)
      expect(FlipKeyProperty).to receive(:find).with('1').and_return fkp
      get 'message_sent', params: { id: '1' }
      expect(assigns(:flip_key_property)).to eq fkp
    end
  end
end
