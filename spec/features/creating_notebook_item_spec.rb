require "rails_helper"

RSpec.describe "Creating a budget item for a notebook" do
  let(:user) { create(:user) }
  let!(:first_notebook) { create(:notebook, name: "My first notebook", user: user) }

  before do
    sign_in_as user
  end

  describe "on the notebooks listing" do
    it "has button to create a budget item" do
      within("#notebook_#{first_notebook.id}") do
        expect(page).to have_css "a.new-budget-item", text: "Add budget item for this notebook"
      end
    end

    describe "creating a budget item" do
      describe "that passes validation" do
        before do
          create_valid_budget_item(first_notebook)
        end

        it "shows a successful message" do
          expect(page).to have_content "New budget item added to #{first_notebook.name}"
        end

        it "shows the count of budget item" do
          expect(page).to have_content "My first notebook (1)"
        end
      end

      describe "that did not pass validation" do
        before do
          create_invalid_budget_item(first_notebook)
        end

        it "shows an error message" do
          expect(page).to have_content "Name can't be blank"
          expect(page).to have_content "Amount can't be blank"
        end
      end
    end
  end
end

