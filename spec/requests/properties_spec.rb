# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Properties", type: :request do
  before { FactoryBot.create(:website) }

  describe "GET /properties/:id" do
    let(:property) { FactoryBot.create(:property) }
    let(:template) { "show_classic" }

    context "when a property is found" do
      let(:publicly_visible?) { true }

      before do
        allow(Property)
          .to receive(:find_by)
          .and_return(property)

        allow(property)
          .to receive(:publicly_visible?)
          .and_return(publicly_visible?)

        allow(property)
          .to receive(:template)
          .and_return(template)
      end

      def perform
        get "/properties/" + property.to_param
      end

      context "when the property is publicly visible" do
        let(:publicly_visible?) { true }

        it "renders the property template (classic by default)" do
          perform
          assert_select ".property"
        end

        context "when TripAdvisor" do
          let(:template) { "show_trip_advisor" }
          let!(:ta_prop) do
            FactoryBot.create(:trip_advisor_property, property: property)
          end

          it "displays an enquiry form with a _blank target" do
            perform
            url = get_details_trip_advisor_property_path(ta_prop)
            assert_select "form[action='#{url}'][target='_blank']"
          end

          context "with reviews" do
            before do
              Review.create!(
                author_location: "Bergheim, France",
                author_name: "Laetitia P",
                content: "Connu sous le nom de Chalet des Ayes...",
                property: property,
                rating: 5,
                title: "Super!",
                visited_on: Date.new(2017, 4, 1)
              )
            end

            it "displays reviews" do
              perform
              assert_select "h2#reviews"
              assert_select ".reviews"
              assert_select ".review-author-name", text: "Laetitia P"
              assert_select ".review-author-location", text: "Bergheim, France"
              assert_select(
                ".review-content",
                text: "Connu sous le nom de Chalet des Ayes..."
              )
              assert_select ".review-title", text: "5/5 Super!"
              assert_select ".review-visited-on", text: "April 2017"
            end
          end
        end
      end

      context "when the property is not publicly visible" do
        let(:publicly_visible?) { false }
        before do
          allow(property).to receive(:flip_key_property).and_return(nil)
        end

        context "when not signed in as admin" do
          before do
            allow_any_instance_of(ApplicationController)
              .to receive(:admin?).and_return(false)
          end

          context "but signed is as the owner" do
            let(:current_user) { property.user }

            it "shows the property" do
              pending
              perform
              signed_in_user
              allow(property).to receive(:user_id).and_return(current_user.id)
              get "/properties/#{property.to_param}"
              expect(response).to render_template(property.template)
            end
          end

          context "when not the owner either" do
            it "renders not found" do
              perform
              expect(response.status).to eql 404
            end
          end
        end

        context "when signed in as admin" do
          it "shows the property" do
            pending
            perform
            allow(controller).to receive(:admin?).and_return(true)
            get "/properties/#{property.to_param}"
            expect(response).to render_template(property.template)
          end
        end
      end
    end

    context "when a property is not found" do
      before do
        allow(Property).to receive(:find_by).and_return(nil)
      end

      it "renders not found" do
        get "/properties/1-not-found"
        expect(response.status).to eql 404
      end
    end
  end
end
