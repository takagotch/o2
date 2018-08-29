class Product < ApplicationRecord
  def self.visible(at = Date.current)
    where("announce_on_computed <= ?", at)
  end

  def self.buyable(at = Date.current)
    where("preorder_on_computed <= ?", at)
  end

  def visible?(at = Date.current)
    announce_on_computed <= at
  end

  def buyable?(at = Date.current)
    preorder_on_computed <= at
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

  private

  def recompute_dependent_columns
    self.preorder_on_computed = preorder_on ||
publication_on
    self.announce_on_computed = announce_on ||
preorder_on_computed
  end

end


