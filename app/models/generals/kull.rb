class Kull < General
  def attack_with_mods(profile,recruit)
    ## recruit object used in cases where something unique
    ## occurs to the general's attack on a level up which is
    ## not accounted for with a standard integer increment
    ## i.e. Cartigan, Kobo, Malekus don't increment linearly
    attack = super

    ### Strider example
    # attack += 2 if profile.weapons.find{|p| p.name == 'Assassins Blade'}
    
    # end
    # attack += 2 if profile.items.find{|p| p.name == 'Amulet of Despair'}
    #   attack += 2.0
    # end
    # attack += 2 if profile.items.find{|p| p.name == 'Assassins Cloak'}
    #   attack += 5.0
    # end

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
    # attack += 2 if profile.weapons.find{|p| p.name == 'Scepter of Light'}
    
    # end
    return defense
  end

  def e_attack_with_bonus(profile,recruit)
    e_attack = super

    attack = profile.attack
    count = profile.inventory_count('soldiers','Orc Marauder')
    case recruit.level
    when 1
      attack += (count * 0.5) > 50 ? 50 : (count * 0.5)
    when 2
      attack += count > 50 ? 50 : count
    when 3
      attack += (count * 1.5) > 50 ? 50 : (count * 1.5)
    when 4
      attack += (count * 2.0) > 50 ? 50 : (count * 2.0)
    when 5..50
      max = step_function(recruit.level,{pos_index: 38, multiplier: 3, offset: 4, period: 3})
      attack += (count * 2.0) > max ? max : (count * 2.0)
    end
    
    e_attack = ((attack + profile.attack_rune + profile.attack_ia) + profile.ri_defense*0.7)
    return e_attack.round(1)
  end

  def e_defense_with_bonus(profile,recruit)
    e_defense = super
    
    attack = profile.attack
    count = profile.inventory_count('soldiers','Orc Marauder')
    case recruit.level
    when 1
      attack += (count * 0.5) > 50 ? 50 : (count * 0.5)
    when 2
      attack += count > 50 ? 50 : count
    when 3
      attack += (count * 1.5) > 50 ? 50 : (count * 1.5)
    when 4
      attack += (count * 2.0) > 50 ? 50 : (count * 2.0)
    when 5..50
      max = step_function(recruit.level,{pos_index: 38, multiplier: 3, offset: 4, period: 3})
      attack += (count * 2.0) > max ? max : (count * 2.0)
    end
    e_defense = (profile.ri_defense + (attack + profile.attack_rune + profile.attack_ia)*0.7)
    return e_defense.round(1)
  end
end
