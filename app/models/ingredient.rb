class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :inventories
  belongs_to :category
  belongs_to :kind, optional: true
  belongs_to :alcohol_tolerance, class_name: 'Degree', foreign_key: 'alcohol_tolerance_id', optional: true
  belongs_to :flocculation, class_name: 'Degree', foreign_key: 'flocculation_id', optional: true
  belongs_to :origin, optional: true

  validates :name, presence: true


  def self.ingredient_to_table(category_name=false)
    return '' if !category_name

    if (category_name == 'Fermentables')
      cols = {name: 'Name', origin: 'Origin', kind: 'Kind', color: 'Color', ppg: 'PPG'}
    elsif (category_name == 'Yeasts')
      cols = {name: 'Name', kind: 'Kind', origin: 'Origin', product_id: 'Product ID', alcochol_tolerance: 'Alcohol Tolerance', flocculation: 'Flocculation'}
    elsif (category_name == 'Hops')
      cols = {name: 'Name', kind: 'Kind', alpha: 'AA'}
    elsif (category_name == 'Others')
      cols = {name: 'Name'}
    end

    header = "
    <table id=\"#{category_name}_list\">
      <tr>"

    cols.each do |col|
      header += "<th class=\"ingredients\">#{col.second}</th>"
    end
    header += '</tr>'

    body = ''
    Ingredient.joins(:category).where(categories: {name: category_name}).each do |ingredient|
      body += "
      <tr>
        <td>#{ingredient.name}</td>"
      if cols.key?(:kind)
        body += ingredient.kind.nil? ? "<td></td>" : "<td>#{ingredient.kind.name}</td>"
      end
      if cols.key?(:origin)
        body += ingredient.origin.nil? ? "<td></td>" : "<td>#{ingredient.origin.name}</td>"
      end
      if cols.key?(:product_id)
        body += ingredient.product_id.blank? ? "<td></td>" : "<td>#{ingredient.product_id}</td>"
      end
      if cols.key?(:alcochol_tolerance)
        body += ingredient.alcohol_tolerance_id.nil? ? "<td></td>" : "<td>#{ingredient.alcohol_tolerance.name}</td>"
      end
      if cols.key?(:flocculation)
        body += ingredient.flocculation_id.nil? ? "<td></td>" : "<td>#{ingredient.flocculation.name}</td>"
      end
      if cols.key?(:color)
        body += ingredient.color.blank? ? "<td></td>" : "<td>#{ingredient.color} &deg;L</td>"
      end
      if cols.key?(:ppg)
        body += ingredient.ppg.blank? ? "<td></td>" : "<td>#{ingredient.ppg.round(0)} PPG</td>"
      end
      if cols.key?(:alpha)
        body += ingredient.alpha.blank? ? "<td></td>" : "<td>#{ingredient.alpha} AA</td>"
      end
      body += "</tr>"
    end
    return header + body + '</table>'
  end

end
