require 'rails_helper'

describe UsersController, type: :controller do
  let(:user){ create(:user) }
  let(:prototype){ create(:prototype) }

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

      it "assigns the requested to @prototypes" do
        prototypes = create_list(:prototype, 3, user: user)
        expect(assigns(:prototypes)).to match(prototypes.sort{ |a,b| b.created_at <=> a.created_at })
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

  context "without user login" do
    describe "GET #edit" do
      it "redirects sign_in page" do
        get :edit, params: { id: user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PATCH #update" do
      it "redirects sign_in page" do
        patch :update, params: { id: user.id, user: attributes_for(:user) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
