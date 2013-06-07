class General < ActiveRecord::Base
  attr_accessible :name, :attack, :defense, :upkeep, :base_cost, :avatar, :e_attack, :e_defense, :div_power, :attack_increment, :defense_increment, :description
  
  validates :name, :presence => true
  validates :attack, :defense, :presence => true, :numericality => { :only_integer => true }
  validates :attack_increment, :defense_increment, :base_cost, :upkeep, :div_power, :numericality => { :only_integer => true }, :allow_nil => true
  
  has_attached_file :avatar, :styles => { :medium => "160x160>", :thumb => "50x50>" },
    :path => "/system/generals/:attachment/:id_partition/:style/:basename.:extension",
    :url => "/system/generals/:attachment/:id_partition/:style/:basename.:extension"
  validates_attachment :avatar,
    :size => { :in => 0..100.kilobytes }
  
  before_save :update_e_attack
  before_save :update_e_defense
  
  cattr_reader :per_page
  @@per_page = 25
  @permitted_columns = ['name','attack','defense','e_attack','e_defense','base_cost','upkeep','div_power']
    
  def update_e_attack
    self.e_attack = attack + defense*0.7
  end
  
  def update_e_defense
    self.e_defense = defense + attack*0.7
  end
  
  def self.search(*args)
    options = args.extract_options!

    options[:c] = @permitted_columns.include?(options[:c]) ? options[:c] : 'e_attack'

    General.order(options[:c] + " " + ((options[:d] == 'up') ? "ASC" : "DESC")).paginate(:page => options[:page])
  end
  
  def attack_with_mods(profile,recruit)
    return recruit.attack
  end

  def defense_with_mods(profile,recruit)
    return recruit.defense
  end

  def e_attack_with_bonus(profile,recruit)
    return profile.ri_e_attack.round(1)
  end

  def e_defense_with_bonus(profile,recruit)
    return profile.ri_e_defense.round(1)
  end
  
  def self.stub_model(name)
    model_name = name.gsub(/\*/,'').gsub(/\s/,'_').classify.underscore
    class_name = name.gsub(/\*/,'').gsub(/\s/,'_').classify
    content = <<-RUBY
class #{class_name} < General
  def attack_with_mods(profile,recruit)
    ## recruit object used in cases where something unique
    ## occurs to the general's attack on a level up which is
    ## not accounted for with a standard integer increment
    ## i.e. Cartigan, Kobo, Malekus don't increment linearly
    attack = super

    ### Strider example
    # attack += 3.0 if profile.weapons.exists?(name: 'Assassins Blade')
    # attack += 2.0 if profile.items.exists?(name: 'Amulet of Despair')
    # attack += 5.0 if profile.items.exists?(name: 'Assassins Cloak')

    ### Penelope
    # Nothing as no gear modifies Penelope's attack
    return attack
  end

  def defense_with_mods(profile,recruit)
    ## recruit object used in cases where something unique
    ## occurs to the general's defense on a level up which is
    ## not accounted for with a standard integer increment
    ## i.e. Cartigan, Kobo, Malekus don't increment linearly
    defense = super

    ### Strider
    # Nothing as no gear modifies Strider's defense

    ### Penelope example
    # defense += 3.0 if profile.weapons.exists?(name: 'Scepter of Light')
    return defense
  end

  def e_attack_with_bonus(profile,recruit)
    e_attack = super

    ## Aesir example
    # case recruit.level
    # when 1
    #   e_attack += 0.01 * profile.e_attack
    # when 2
    #   e_attack += 0.02 * profile.e_attack
    # when 3
    #   e_attack += 0.03 * profile.e_attack
    # when 4
    #   e_attack += 0.04 * profile.e_attack
    # else
    #   e_attack += 0.04 * profile.e_attack
    # end
    return e_attack.round(1)
  end

  def e_defense_with_bonus(profile,recruit)
    e_defense = super
    return e_defense.round(1)
  end
end
    RUBY
    unless File.exists?(File.join("app/models/generals/", "#{model_name}.rb"))
      File.open(File.join("app/models/generals/", "#{model_name}.rb"), 'w') do |f|
        f.puts content
      end
      return "Created #{File.join("app/models/generals/", "#{model_name}.rb")}"
    else
      Rails.logger.info "#{File.join("app/models/generals/", "#{model_name}.rb")} exists!"
      return "#{File.join("app/models/generals/", "#{model_name}.rb")} exists!"
    end
  end
end