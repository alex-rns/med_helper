class Expert < ApplicationRecord
   belongs_to :category
   belongs_to :level, optional: true
   scope :searcher, lambda {|params|
    search_scope = Expert.all
    search_scope = search_scope.by_query(params[:query]) if params[:query].present?
    search_scope = search_scope.filters(params[:filter]) if params[:filter].present?
   }
   scope :by_query, lambda { |parameter|
                     if parameter.present?
                       where('full_name ILIKE :search', search: "%#{parameter}%")
                       .or(where(category_id: Category.where('name ILIKE :search', search: "%#{parameter}%").ids))
                     end
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
  # scope :upcategory, lambda { |parameter| if parameter.present? }
  # scope :downexperience, lambda { |parameter| if parameter.present? }
  # scope :upexperience, lambda { |parameter| if parameter.present? }
end
