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
    it "devrait existe"
    
    it "doit avoir le bon titre"
  end

end
