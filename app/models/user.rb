class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  has_many :orders

  has_many :paid_orders, -> { where( :is_paid => true) }, :class_name => "Order", :foreign_key => "user_id"

end
