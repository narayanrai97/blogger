module CategoriesHelper
    def categories_for_select 
        Category.all.collect {|c| [c.name, c.id]}
    end 
end