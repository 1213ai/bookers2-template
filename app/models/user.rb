class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :articles, dependent: :destroy
   has_many :books, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :book_comments, dependent: :destroy

   validates :name, length: { minimum:2, maximum: 20 }
   validates :name, uniqueness: true


   validates :introduction, length: { maximum: 50 }
   attachment :profile_image

  def books
   return Book.where(user_id: self.id)
  end

end
