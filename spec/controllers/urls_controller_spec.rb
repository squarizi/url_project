require 'rails_helper'

RSpec.describe UrlsController, type: :controller do

  describe "parameter whitelisting" do
    let(:params) { {other: "stuff", url: {token: "ABC1234", long_url: "http://example.org"}} }
    it { is_expected.to permit(:long_url).for(:create, params: params).on(:url) }
  end

  describe "GET #new" do
    subject(:action) { get :new }

    before do
      action
    end

    it "returns a HTTP 200 (success) status" do
      expect(action).to have_http_status :success
    end

    it "assigns a new Url to @url" do
      action
      expect(assigns(:url)).to be_a Url
    end

    it "renders the :new template" do
      expect(action).to render_template :new
    end
  end

  describe "POST #create" do
    let(:original_url) { "http://this.url.is.very.long.com/some/path" }
    let(:params) { {url: {long_url: original_url}} }
    subject(:action) { post :create, params }

    context "with valid attributes" do
      it "creates a new Url" do
        expect { action }.to change(Url, :count).by(1)
      end

      it "redirects to the #show page with redirect=false" do
        expect(action).to redirect_to action: :show,
                                      token: assigns(:url).token,
                                      redirect: "no"
      end

      it "sets the success flash message" do
        action
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      let(:original_url) { "invalid.url" }

      it "does not create a new Url" do
        expect { action }.not_to change(Url, :count)
      end

      it "re-renders the :new template" do
        expect(action).to render_template :new
      end

      it "returns a HTTP 422 (unprocessable entity) status" do
        expect(action).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "GET #show" do
    let!(:url) { create :url }
    subject(:action) { get :show, params }

    context "for a valid token" do
      let(:params) { {token: url.token} }

      it "assigns the requested Url to @url" do
        action
        expect(assigns(:url)).to eq url
      end

      context "given a redirect=no parameter" do
        let(:params) { {token: url.token, redirect: "no"} }

        it "renders the :show template" do
          expect(action).to render_template :show
        end

        it "returns a HTTP 200 (success) status" do
          expect(action).to have_http_status :success
        end
      end

      context "without the redirect=no parameter" do
        it "redirects to the original URL" do
          expect(action).to redirect_to url.long_url
        end
      end
    end

    context "for an invalid token" do
      let(:params) { {token: "ABC"} }

      it "returns a HTTP 404 (not found) status" do
        expect(action).to have_http_status :not_found
      end
    end
  end
end
