require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(200) }
  end
end
