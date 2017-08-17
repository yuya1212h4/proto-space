require 'rails_helper'

describe UsersController, type: :controller do
  let(:user){ create(:user) }

  context "with user login" do
    before do
      sign_in user
    end

    describe "GET #show" do
      before do
        get :show, params: { id: user.id }
      end

      it "assigns the requested to @user" do
        expect(assigns(:user)).to eq user
      end

      it "renders the :show templates" do
        expect(response).to render_template :show
      end
    end

    describe "GET #edit" do
      before do
        get :edit, params: { id: user.id }
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      before do
        patch :update, params: { id: user.id, user: attributes_for(:user) }
      end

      it "changes current_user attributes" do
        user.name = "hoge"
        expect(user.name).to eq "hoge"
      end

      it "redirect_to root_path" do
        expect(response).to redirect_to root_path
      end

      it "sends flash mesages" do
        expect(flash[:success]).to eq "Successfully edit your profile."
      end
    end
  end
