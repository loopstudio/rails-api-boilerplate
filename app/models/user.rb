# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  email                  :string           not null
#  uid                    :string           not null
#  encrypted_password     :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  unconfirmed_email      :string
#  sign_in_count          :integer          default(0)
#  tokens                 :json             default({}), not null
#  must_change_password   :boolean          default(FALSE)
#

class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :registerable

  include DeviseTokenAuth::Concerns::User
  serialize :tokens

  validates :first_name, :last_name, presence: true
end
