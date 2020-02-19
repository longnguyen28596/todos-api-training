require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe "Association" do
    it { have_many :items }
  end
end
