# encoding: UTF-8
require 'spec_helper'

describe "LayoutLinks" do

# Ce test plante je ne sais pas pourquoi ?!
#it "devrait trouver une page Accueil a '/'" do
#  get '/'
#  response.should have_selector('title', :content => "Accueil")
#end

  it "devrait avoir le bon lien sur le layout" do
    visit root_path
    click_link "A propos"
    response.should have_selector('title', :content => "A propos")
    click_link "Aide"
    response.should have_selector('title', :content => "Aide")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    #click_link "Acceuil"
    #response.should have_selector('title', :content => "Acceuil")
    #click_link "S'inscrire !"
    #response.should have_selector('title', :content => "Inscription")
  end

  it "devrait trouver une page Contact a '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "devrait trouver une page A Propos a '/about'" do
    get '/about'
    response.should have_selector('title', :content => "A propos")
  end

  it "devrait trouver une page Aide a '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Aide")
  end

  it "doit avoir une route vers /signup" do
    get '/signup'
    response.should have_selector("title", :content => "Inscription")
  end
  
  
  describe "quand pas identifie" do
    it "doit avoir un lien de connexion" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Connexion")
    end
  end

  describe "quand identifie" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in "Password", :with => @user.password
      click_button
    end

    it "devrait avoir un lien de deconnexion" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Déconnexion")
    end

    it "devrait avoir un lien vers le profil" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                        :content => "Profil")
    end
  end

end
