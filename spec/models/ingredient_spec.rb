require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  describe "model validations" do
    it "will not save without a name" do

      ingredient = build :ingredient, name: nil

      expect(ingredient).to_not be_valid
      expect(ingredient.errors.keys).to include(:name)
    end

    it "requires a unique name" do
      ingredient =     create :ingredient, name: "yams"
      ingredientsame = build :ingredient, name: "yams"

      expect(ingredientsame).to_not be_valid
      expect(ingredientsame.errors.keys).to include(:name)
    end

    it "unique name is case insensitive" do
      ingredient =     create :ingredient, name: "yams"
      ingredientsame = build :ingredient, name: "YAMs"

      expect(ingredientsame).to_not be_valid
      expect(ingredientsame.errors.keys).to include(:name)
    end

  end

  describe "model associations" do
    it "belongs to user 1" do
      ingredient = create :ingredient

      expect(ingredient.user_id).to eq 1
    end

    it "has and belongs to recipes" do
      recipe = create :recipe
      ingredient = recipe.ingredients.first

      expect(ingredient.recipes.count).to eq 1
      expect(recipe.ingredients.count).to eq 1
    end
  end

  describe "scopes" do
    it "sorts the ingredients in alphabetical order by name" do
      %w(Yam Banana Fig Yogurt Fruit Apple Penguin).each do |name|
        create(:ingredient, name: name)
      end

      expect(Ingredient.alpha_order.first.name).to eq "Apple"
      expect(Ingredient.alpha_order.last.name).to eq "Yogurt"
    end
  end
end
