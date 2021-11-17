class User < ApplicationRecord
    has_secure_password
    belongs_to :congregation
    has_many :assignments
    has_many :territories, through: :assignments
    validates :name, presence: true
    validates :role, {presence: true, format: {with: /\AAdmin\z|\APublisher\z/}}
end
