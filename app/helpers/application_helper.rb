module ApplicationHelper
  
  def titre
    base_titre="Exemple - Tutoriel Ruby On Rails"
    if @titre.nil?
      base_titre
    else
      "#{base_titre} | #{@titre}"
    end
  end
  
end
