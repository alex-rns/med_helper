class Expert < ApplicationRecord
   has_many :events
   has_many :users, :through => :events
   # has_many :clients, :through => :events
   belongs_to :category
   belongs_to :level, optional: true
   has_one_attached :image
   validates :category, presence: false
   belongs_to :user
   geocoded_by :address
   scope :searcher, lambda {|params|
    search_scope = Expert.all
    search_scope = search_scope.query(params[:query]) if params[:query].present?
    search_scope = search_scope.filters(params[:filter]) if params[:filter].present?
    search_scope
   }
   scope :query, lambda { |params|
                       where('full_name ILIKE :search', search: "%#{params}%")
                       .or(where(category_id: Category.where('name ILIKE :search', search: "%#{params}%").ids))
                   }
  scope :filters, lambda { |parameter|
                        if parameter == "upexperience"
                          order(experience: :asc)
                        elsif parameter == "downexperience"
                          order(experience: :desc)
                        elsif parameter == "upcategory"
                          order(level_id: :desc)
                        else
                          order(level_id: :asc)
                        end
                        }
end
