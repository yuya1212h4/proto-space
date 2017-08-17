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
        before do
          patch :update, params: { id: prototype.id, prototype: attributes_for(:prototype) }
        end

        it "assigns the requested prototype to @prototype" do
          expect(assigns(:prototype)).to eq prototype
        end

        it "updates attributes of prototype" do
          prototype = build(:prototype, title: "hoge")
          expect(prototype.title).to eq "hoge"
        end

        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end

        it "shows flash message to show update prototype successfully" do
          expect(flash[:notice]).to eq 'Prototype was successfully updated.'
        end
      end

      context "with invalid attributes" do
        before do
          patch :update, params: { id: prototype.id, prototype: attributes_for(:prototype, title: nil) }
        end

        it "assigns the requested prototype to @prototype" do
          expect(assigns(:prototype)).to eq prototype
        end

        it "does not save the new prototype" do
          expect(prototype.title).not_to eq "hoge"
        end

        it "renders the :show template" do
          expect(response).to render_template :edit
        end

        it "shows flash message to show updatee prototype unsuccessfully" do
          expect(flash[:alert]).to eq 'Prototype do not update.'
        end
      end
    end
end
