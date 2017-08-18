require 'rails_helper'

describe PrototypesController, type: :controller do
  let(:user){ create(:user) }
  let(:prototype){ create(:prototype, user: user) }
  let(:comment){ create(:comment) }
  let(:like){ create(:like, prototype: prototype) }


  context "with user login" do
    before do
      login_user(user)
    end

    describe 'GET #index' do
      before do
        get :index
      end

      it 'assigns the requested prototypes to @prototypes' do
        prototypes = create_list(:prototype, 3)
        expect(assigns(:prototypes)).to match(prototypes.sort{ |a,b| b.created_at <=> a.created_at })
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      before do
        get :new
      end

      it "assigns the requested prototype to @prototype" do
        expect(assigns(:prototype)).to be_a_new(Prototype)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        before do
          post :create, params: { prototype: attributes_for(:prototype) }
        end

        it "saves the new prototype in the database" do
          expect{ prototype }.to change{ Prototype.count }.by(1)
        end

        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end

        it "shows flash messages to show save the prototype successfully" do
          expect(flash[:notice]).to eq 'Successful posting of prototype.'
        end
      end

      describe "with invalid attributed" do
        before do
          post :create, params: { prototype: attributes_for(:prototype, title: nil) }
        end

        it "does not save the new prototype in the database" do
          prototype = build(:prototype, title: nil)
          expect{ prototype }.not_to change { Prototype.count }
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end

        it "shows flash messages to show save the prototype unsuccessfully" do
          expect(flash[:alert]).to eq 'prototype do not create'
        end
      end
    end

    describe "GET #show" do
      before do
        get :show, params: { id: prototype.id }
      end

      it "assigns the requested prototype to @prototype" do
        expect(assigns(:prototype)).to eq prototype
      end

      it "assigns the requested comment to @comment" do
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "assigns the requested comment to @comments" do
        comments =  create_list(:comment, 3, prototype: prototype)
        expect(assigns(:comments)).to eq comments
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end

    describe "GET #edit" do
      before do
        get :edit, params: { id: prototype.id }
      end

      it "assigns the requested prototype to @prototype" do
        expect(assigns(:prototype)).to eq prototype
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        subject {
          Proc.new { patch :update, params: { id: prototype.id, prototype: attributes_for(:prototype)} }
        }

        it "assigns the requested prototype to @prototype" do
          subject.call
          expect(assigns(:prototype)).to eq prototype
        end

        it "updates attributes of prototype" do
          prototype = build(:prototype, title: "hoge")
          expect(prototype.title).to eq "hoge"
        end

        it "redirects to root_path" do
          subject.call
          expect(response).to redirect_to root_path
        end

        it "shows flash message to show update prototype successfully" do
          subject.call
          expect(flash[:notice]).to eq 'Prototype was successfully updated.'
        end
      end

      context "with invalid attributes" do
        subject {
          Proc.new { patch :update, params: { id: prototype.id, prototype: attributes_for(:prototype, title: nil) } }
        }

        it "assigns the requested prototype to @prototype" do
          subject.call
          expect(assigns(:prototype)).to eq prototype
        end

        it "does not save the new prototype" do
          expect(prototype.title).not_to eq "hoge"
        end

        it "renders the :show template" do
          subject.call
          expect(response).to render_template :edit
        end

        it "shows flash message to show updatee prototype unsuccessfully" do
          subject.call
          expect(flash[:alert]).to eq 'Prototype do not update.'
        end
      end
    end

    describe "DELETE #destroy" do
      let!(:prototype){ create(:prototype, user: user) }

      subject {
        Proc.new { delete :destroy, params: { id: prototype.id } }
      }

      it "assigns the requested prototype to @prototype to @prototype" do
        subject.call
        expect(assigns(:prototype)).to eq prototype
      end

      it "deletes the prototype" do
        expect{ subject.call }.to change{ Prototype.count }.by(-1)
      end

      it "redirects to root_path" do
        subject.call
        expect(response).to redirect_to root_path
      end

      it "shows flash messaeg to show delete prototype successfully" do
        subject.call
        expect(flash[:notice]).to eq 'Prototype was successfully deleted.'
      end
    end

  end

  context "without user login" do
    describe "GET #new" do
      it "redirects sign_in page" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      it "redirects sign_in page" do
        post :create, params: { prototype: attributes_for(:prototype) }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #edit" do
      it "redirects sign_in page" do
        get :edit, params: { id: prototype.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PATCH #update" do
      it "redirects sign_in page" do
        patch :update, params: { id: prototype.id, prototype: attributes_for(:prototype) }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      it "redirects sign_in page" do
        delete :destroy, params: { id: prototype.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
