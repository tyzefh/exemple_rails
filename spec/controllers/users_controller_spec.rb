require 'spec_helper'

describe UsersController do

  render_views

  # Page d'incription
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "doit avoir le bon titre" do
      get 'new'
      response.should have_selector("title", :content => "Inscription")
    end
  end

  #Page de l'utilisateur
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end

    it "devrait existe" do
      get 'show', :id => @user
      response.should be_success
    end

    it "doit avoir le bon titre" do
      get 'show', :id => @user
      response.should have_selector("title", :content => @user.nom )
    end

    it "devrait inclure le nom de l'utilisateur" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end

    it "doit avoir le bon utilisateur" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "devrait avoir une image de profil" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

  end

end
