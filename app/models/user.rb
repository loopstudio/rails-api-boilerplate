# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string           indexed
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           not null, indexed
#  encrypted_password     :string           not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locale                 :string
#  must_change_password   :boolean          default(FALSE)
#  provider               :string           default("email"), not null, indexed => [uid]
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  sign_in_count          :integer          default(0)
#  tokens                 :json             not null
#  uid                    :string           not null, indexed => [provider]
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :registerable

  include DeviseTokenAuth::Concerns::User
  serialize :tokens

  validates :locale,
            inclusion: { in: I18n.available_locales.map(&:to_s), allow_blank: true },
            if: :locale_changed?

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
