require 'rails_helper'

describe PrototypesController, type: :controller do
  let(:user){ create(:user) }
  let(:prototype){ create(:prototype, user: user) }
  let(:comment){ create(:comment) }
  let(:like){ create(:like, prototype: prototype) }


  context "with usr login" do
    before do
      sign_in user
    end

    describe 'GET #index' do
      before do
        get :index
      end

      it 'assigns the requested prototypes to @prototypes' do
        expect(assigns(:prototypes)).to include prototype
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
end
