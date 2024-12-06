class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

         has_many :lesson_users
         has_many :course_users
         has_many :courses, through: :course_users
         has_many :course_unlocks
         has_many :unlocked_courses, through: :course_unlocks, source: :course

end
