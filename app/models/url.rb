class Url < ActiveRecord::Base

  before_validation :set_token, on: :create

  validates :token, presence: true, uniqueness: true
  validates :long_url, presence: true, url: true

  def to_param
    token
  end

  def self.with_token(token)
    tokens = TokenMachine.conversion_token(token)
    where(token: tokens).first
  end

  private

  def set_token
    self.token = make_unique_token
  end

  def make_unique_token
    loop do
      token = build_token_value
      return token if token_is_unique?(token)
    end
  end

  def token_is_unique?(token)
    tokens = TokenMachine.nearby_tokens(token)

    token_free?(tokens)
  end

  def token_free?(tokens)
    tokens.map { |token| self.class.select(:id).where("token Like ?", token) }.join.size.zero?
  end

  def build_token_value
    TokenMachine.generate_token
  end
end
