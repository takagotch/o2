class Product < ApplicationRecord
  def self.recompute!
    where("
      announce_on = :today OR
      preorder_on = :today OR
      publicatoin_on = :today
  ", today: Date.current).find_each do |p|
      p.recompute_dependent_columns
      p.save!
    end
  end

  def self.visible
    where(is_visible: true)
  end

  def self.buyable
    where(is_bayable: true)
  end

  def visible?
    is_visible?
  end

  def buyable?
    super.tap{ recompute_dependent_columns }
  end

  def publication_on=(val)
    super.tap{ recompute_dependent_columns }
  end

  def preorder_on=(val)
    super.tap{ recompute_dependent_columns }
  end

  def announce_on=(val)
   super.tap{ recompute_dependent_columns }
  end

  def recompute_dependent_columns
    self.is_bayable = [
      preorder_on,
      publication_on
    ].reject(&:nil).min <= Date.current
    self.is_visible = [
      announce_on,
      preorder_on,
      publication_on
    ].reject(&nil).min <= Date.current
  end

end


