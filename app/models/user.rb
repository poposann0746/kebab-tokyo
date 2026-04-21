class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy

  validates :nickname, length: { maximum: 20 }, allow_blank: true

  def display_name
    nickname.presence || "名称未設定"
  end
end
