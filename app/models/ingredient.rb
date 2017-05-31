class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :inventories
  belongs_to :category
  belongs_to :kind, optional: true
  belongs_to :alcohol_tolerance, class_name: 'Degree', foreign_key: 'alcohol_tolerance_id', optional: true
  belongs_to :flocculation, class_name: 'Degree', foreign_key: 'flocculation_id', optional: true
  belongs_to :origin, optional: true

  validates :name, presence: true

  def self.ingredient_to_table(category_name)
    # [Column Title, column_name, unit, class_name]
    if (category_name == 'Yeasts')
      cols = [['Name', 'name', false, '', ''], ['Kind', 'kind', true, '', 'medium_table center'], ['Origin', 'origin', true, '', ''], ['Product ID', 'product_id', false, '', ''], ['Alcohol Tolerance', 'alcohol_tolerance', true, '', 'medium_table center'], ['Flocculation', 'flocculation', true, '', 'medium_table center']]
    elsif (category_name == 'Hops')
      cols = [['Name', 'name', false, '', ''], ['Kind', 'kind', true, '', 'center'], ['AA', 'alpha', false, 'AA', 'center']]
    elsif (category_name == 'Others')
      cols = [['Name', 'name', false, '', '']]
    else
      category_name = 'Fermentables'
      cols = [['Name', 'name', false, '', ''], ['Origin', 'origin', true, '', 'medium_table'], ['Kind', 'kind', true, '', 'center'], ['Color', 'color', false, '&deg;L', 'medium_table center'], ['PPG', 'ppg', false, '', 'center']]
    end

    header = "
    <table id=\"ingredients_list\"> <tr>"
    cols.each {|col| header += "<th class=\"ingredients #{col[4].to_s}\">#{col[0]}</th>" }
    header += '</tr>'

    body = ''
    Ingredient.joins(:category).where(categories: {name: category_name}).each do |ingredient|
      body += "<tr>"

      cols.each do |col|
        if (ingredient.send(col[1].to_s).nil?)
          body += "<td class=\"#{col[4].to_s}\"></td>"
        elsif (col[2])
          body += "<td class=\"#{col[4].to_s}\">#{ingredient.send(col[1].to_s).name} #{col[3]}</td>"
        else
          body += "<td class=\"#{col[4].to_s}\">#{ingredient[col[1]]} #{col[3]}</td>"
        end
      end

      body += "</tr>"
    end

    return header + body + '</table>'
  end

end
