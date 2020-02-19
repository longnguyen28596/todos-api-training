require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Association" do
    it { should belong_to :todo }
  end
end
