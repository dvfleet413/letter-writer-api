class User < ApplicationRecord
    has_secure_password
    belongs_to :congregation
    validates :email, {uniqueness: true, presence: true}
    validates :name, presence: true
    validates :role, {presence: true, format: {with: /\AAdmin\z|\APublisher\z/}}
end
