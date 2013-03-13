
# En utilisant le symbole ':user', nous faisons que
# Factory Girl simule un modèle User.
Factory.define :user do |user|
  user.nom                      "Vincent Marier"
  user.email                    "vincent.marier@gmail.com"
  user.password                 "foobar"
  user.password_confirmation    "foobar"
end
