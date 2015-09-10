class User < ActiveRecord::Base
  # Others available are:
  # :confirmable, :lockable, :omniauthable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
end
