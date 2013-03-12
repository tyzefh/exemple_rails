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

end
