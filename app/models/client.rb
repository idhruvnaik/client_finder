class Client
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :user_id, :name, :latitude, :longitude

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true
  validates :latitude, :longitude, presence: true, numericality: true

  def initialize(user_id:, name:, latitude:, longitude:)
    @user_id = user_id
    @name = name
    @latitude = latitude.to_f
    @longitude = longitude.to_f
  end
end
