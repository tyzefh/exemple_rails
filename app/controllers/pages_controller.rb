class PagesController < ApplicationController
  
  
  
  def home
    @titre="Accueil"
    @base_title="Exemple - Tutoriel Ruby On Rails"
  end

  def contact
    @titre="Contact"
    @base_title="Exemple - Tutoriel Ruby On Rails"
  end
  
  def about
    @titre="A propos"
    @base_title="Exemple - Tutoriel Ruby On Rails"
  end
  
  def help
    @titre="Aide"
    @base_title="Exemple - Tutoriel Ruby On Rails"
  end
  
end
