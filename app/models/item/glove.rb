class Item::Glove < Item
  def self.search(*args)
    options = args.extract_options!

    options[:c] = Item.permitted_columns.include?(options[:c]) ? options[:c] : 'e_attack'

    Item::Glove.order(options[:c] + " " + ((options[:d] == 'up') ? "ASC" : "DESC")).paginate(:page => options[:page])
  end
end