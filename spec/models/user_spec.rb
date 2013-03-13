# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  nom                :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :nom => "Test User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
      }
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

  describe "password validations" do

    it "devrait exiger un mot de passe" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "devrait exiger une confirmation de mot de passe qui correspond" do
      User.new(@attr.merge(:password_confirmation => "invalide")).should_not be_valid
    end

    it "devrait rejet les mot de passe trop courts" do
      short_passwd = "a"*5
      User.new(@attr.merge(:password => short_passwd)).should_not be_valid
    end

    it "devrait rejeter les mots de passe trop longs" do
      long_passwd = "z"*41
      User.new(@attr.merge(:password => long_passwd)).should_not be_valid
    end
  end

  describe "encrypted password" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "devrait avoir un attribut encrypted_password" do
      @user.should respond_to(:encrypted_password)
    end

    it "devrait definir le mot de passe encrypte" do
      @user.encrypted_password.should_not be_blank
    end

    describe "Methode hasPassword?" do
      it "doit retourner true si les mots de passe sont identiques" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "doit retourner false si les mots de passe sont differents" do
        @user.has_password?("invalide").should be_false
      end
    end

    describe "authenticate method" do

      it "devrait retourner nul en cas d'inequation entre email/mot de passe" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "devrait retourner nil quand un email ne correspond a aucun utilisateur" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end

  end

end
