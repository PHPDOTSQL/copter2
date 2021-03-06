class Halcyon < General
  def attack_with_mods(profile,recruit)
    ## recruit object used in cases where something unique
    ## occurs to the general's attack on a level up which is
    ## not accounted for with a standard integer increment
    ## i.e. Cartigan, Kobo, Malekus don't increment linearly
    attack = super

    attack += 2 if profile.inventory_exists?('weapons','Halcyon Grinder')

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

    defense += 2 if profile.inventory_exists?('items','Halcyon Glove')
    
    # end
    return defense
  end

  def e_attack_with_bonus(profile,recruit)
    e_attack = super

    attack = profile.attack
    defense = profile.defense
    case recruit.level
    when 1
      attack -= (defense * 0.10)
      defense += (defense * 0.10)
    when 2
      attack -= (defense * 0.15)
      defense += (defense * 0.15)
    when 3
      attack -= (defense * 0.20)
      defense += (defense * 0.20)
    when 4..50
      attack -= (defense * 0.25)
      defense += (defense * 0.25)
    end
    
    e_attack = ((attack + profile.attack_rune + profile.attack_ia) + (defense + profile.defense_rune + profile.defense_ia)*0.7)
    return e_attack.round(1)
  end

  def e_defense_with_bonus(profile,recruit)
    e_defense = super
    
    attack = profile.attack
    defense = profile.defense
    case recruit.level
    when 1
      attack -= (defense * 0.10)
      defense += (defense * 0.10)
    when 2
      attack -= (defense * 0.15)
      defense += (defense * 0.15)
    when 3
      attack -= (defense * 0.20)
      defense += (defense * 0.20)
    when 4..50
      attack -= (defense * 0.25)
      defense += (defense * 0.25)
    end
    
    e_defense = ((defense + profile.defense_rune + profile.defense_ia) + (attack + profile.attack_rune + profile.attack_ia)*0.7)
    return e_defense.round(1)
  end
end
