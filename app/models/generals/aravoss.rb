class Aravoss < General
  def attack_with_mods(profile,recruit)
    ## recruit object used in cases where something unique
    ## occurs to the general's attack on a level up which is
    ## not accounted for with a standard integer increment
    ## i.e. Cartigan, Kobo, Malekus don't increment linearly
    attack = super

    attack += 2 if profile.inventory_exists?('weapons','Chasm Scythe')

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

    defense += 1 if profile.inventory_exists?('items','Cranial Helm')
    defense += 1 if profile.inventory_exists?('items','Skeletal Necklace')
    
    return defense
  end

  def e_attack_with_bonus(profile,recruit)
    e_attack = super

    case recruit.level
    when 1
      e_attack += 0.002 * e_attack
    when 2
      e_attack += 0.004 * e_attack
    when 3
      e_attack += 0.006 * e_attack
    when 4
      e_attack += 0.008 * e_attack
    else
      e_attack += 0.008 * e_attack
    end
    return e_attack.round(1)
  end

  def e_defense_with_bonus(profile,recruit)
    e_defense = super
    return e_defense.round(1)
  end
end
