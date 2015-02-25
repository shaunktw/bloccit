class Post < ActiveRecord::Base
  attr_accessor :geolocation

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  belongs_to :user
  belongs_to :topic
  belongs_to :location

  after_create :create_vote

  mount_uploader :image, ImageUploader
  acts_as_taggable

  default_scope { order('created_at DESC') }
  scope :visible_to, ->(user) {user ? all : joins(:topic).where('topics.public' => true)}

  validate :update_location
  
  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic , presence: true
  validates :user, presence: true

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value).to_i
  end

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    self.update_attribute(:rank, new_rank)
  end

  private

  def create_vote
    user.votes.create(value: 1, post: self)
  end

  def update_location
    loc = Geocoder.search(geolocation).first
    if loc.blank?
      errors.add(:location_id, "are not valid")
    else
      place = Location.find_or_create_place(loc.data["place_id"], loc)
      self.location_id = place.id
    end
  end

end
