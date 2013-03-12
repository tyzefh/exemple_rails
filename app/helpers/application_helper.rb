module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Application exemple", :class => "round")
  end
  
  def titre
    base_titre="Exemple - Tutoriel Ruby On Rails"
    if @titre.nil?
      base_titre
    else
      "#{base_titre} | #{@titre}"
    end
  end
  
end
