# encoding: UTF-8
require 'spec_helper'

describe "Users" do

  describe "une inscription" do

    describe "ratee" do

      it "ne devrait pas creer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "Nom",          :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "reussie" do

      it "devrait creer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "Nom",          :with => "Utilisateur Test"
          fill_in "Email",        :with => "utilisateur@test.org"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Bienvenue")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "Identification" do
    describe "l'échec" do
      it "ne devrait pas identifier l'utilisateur" do
        user = User.new(:email => "", :password => "")
        integration_sign_in user
        response.should have_selector("div.flash.error", :content => "invalid")
      end
    end

    describe "le succès" do
      it "devrait identifier un utilisateur puis le déconnecter" do
        user = Factory(:user)
        integration_sign_in user
        controller.should be_signed_in
        click_link "Déconnexion"
        controller.should_not be_signed_in
      end
    end
  end
end
