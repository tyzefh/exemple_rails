# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :nom => "Test User", :email => "user@example.com" }
  end

  it "devrait creer une nouvelle instance dotee des attributs valides" do
    User.create!(@attr)
  end

  # Contrôle sur le nom
  it "devrait exiger un nom" do
    bad_guy = User.new(@attr.merge(:nom => ""))
    bad_guy.should_not be_valid
  end
  
  it "devrait rejeter les noms trop longs" do
    nom_long =  "a"*51
    too_long = User.new(@attr.merge(:nom => nom_long))
    too_long.should_not be_valid
  end
  
  # Contrôle sur l'email
  it "devrait exiger une adresse mail" do
    bad_guy = User.new(@attr.merge(:email => ""))
    bad_guy.valid?.should_not == true  
  end
  
  it "devrait accepter les emails valides" do
    mailsValides = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp foo213@132.domain]
    mailsValides.each do |valideMail|
      validEmailUser = User.new(@attr.merge( :email => valideMail))
      validEmailUser.should be_valid
    end   
  end
  
  it "devrait rejeter les emails invalides" do
    mailsInValides = %w[us/er@foo.com user@foo,com user_at_foo.org example.user@foo.]
    mailsInValides.each do |invalideMail|
      invalidEmailUser = User.new(@attr.merge( :email => invalideMail))
      invalidEmailUser.should_not be_valid
    end   
  end
  
  it "devrait rejeter les emails doubles" do
    User.create!(@attr)
    user_email_double = User.new(@attr)
    user_email_double.should_not be_valid
  end
  
  it "devrait rejeter les emails doubles quelque soit la casse" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    user_email_double = User.new(@attr)
    user_email_double.should_not be_valid
  end
  
end
