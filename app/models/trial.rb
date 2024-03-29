class Trial < ApplicationRecord
    validates :name, presence: true
    validates :name_kana, presence: true
    validates :address, presence: true
    validates :tell, presence: true
    validates :email, presence: true
    validates :participants, presence: true
    validates :date, presence: true
    validates :arrival_time, presence: true
    validates :transportation, presence: true

    
    DATE_ITEMS = %w(
        2024年3月30日（土） 2024年4月13日（土） 2024年4月20日（土） 2024年4月27日（土）
    )
end
