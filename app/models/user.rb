class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  #field :search_queue, type: Array

  embeds_one :twitter_credential
  embeds_one :queue

  has_many :searches
  has_many :packages
  has_many :studies

  def data_count
    @count = {tweets: 0, users: 0, geo: 0}
    self.searches.each do |search|
      @count[:tweets] += search.tweets ? search.tweets.count : 0
      @count[:users] += search.twitter_users ? search.twitter_users.count : 0
      if search.tweets
        search.tweets.each do |t|
          @count[:geo] += t.twitters_tweet[:geo] ? 1 : 0
        end
      end
    end
    @count
  end

  def has_pending_queue_searches
    result = queue ? (queue.searches.count > 0) : false
    result
  end

  def has_credentials
    return (twitter_credential.consumer_key or twitter_credential.access_token)
  end

  def get_twitter_client
    self.twitter_credential ? self.twitter_credential.get_client : nil
  end
end
