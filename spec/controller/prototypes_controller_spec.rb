require 'rails_helper'

describe PrototypesController, type: :controller do
  let(:user){ create(:user) }
  let(:prototype){ create(:prototype, user: user) }
  let(:comment){ create(:comment) }
  let(:like){ create(:like, prototype: prototype) }


end
