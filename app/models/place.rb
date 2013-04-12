class Place < ActiveRecord::Base

  #
  # Attribute Handlers
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  attr_accessible :name, :city, :address, :accepts_new_members,
    :is_established, :description, :contact_name,
    :contact_email, :contact_phone, :type

  #
  # Constants
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  #
  # Settings
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  #
  # Plugins
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  geocoded_by :location

  #
  # Scopes
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  #
  # Associations
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  belongs_to :user

  has_and_belongs_to_many :places, association_foreign_key: :place_b_id, foreign_key: :place_a_id, join_table: :place_connections, class_name: Place
  has_and_belongs_to_many :reverse_places, association_foreign_key: :place_a_id, foreign_key: :place_b_id, join_table: :place_connections, class_name: Place

  validates_presence_of :user

  #
  # Nested Attributes
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  #
  # Validations
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  validates :name, presence: true, length: { :in => 5..50 }
  validates :city, presence: true, length: { :in => 2..40 }
  validates :address, presence: true, length: { :in => 6..40 }
  validates :accepts_new_members, inclusion: { within: [ "yes", "no", "waitlist" ], message: "is a invalid value" }
  validates :is_established, inclusion: { within: [true, false], message: "is not a boolean value" }
  validates :latitude, numericality: true, presence: { message: "address could not be geocoded" }
  validates :longitude, numericality: true, presence: { message: "address could not be geocoded" }
  validates :contact_email, presence: true, email: true, length: { maximum: 100 }


  #
  # Callbacks
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  before_validation :geocode

  #
  # Instance Methods
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  def all_places
    # return all places from the bi-directional association
    (places + reverse_places).uniq
  end

  def location
    result = []
    [self.address, self.city].each do |param|
      result << param unless param.blank?
    end
    result.join(' ') unless result.blank?
  end

  #
  # Class Methods
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  #
  # Protected
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

protected

  #
  # Private
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

private


end
