class Splatt
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :body, type: String
  embedded_in :user
  embeds_many :splatts
end
