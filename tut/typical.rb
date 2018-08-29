class Product < ApplicationRecord
  def self.visible(at = Date.current)
    where("
      announce_on <= :at
    OR (
      announce_on IS NULL AND
      preorder_on <= :at
    ) OR (
      announce_on IS NULL AND
      publication_on IS NULL AND
      release_on <= :at
    )
    ", at: at)
  end

  def self.buyable(at = Date.current)
    where("
      preorder_on <= :at
    ) OR (
      preorder_on IS NULL AND
      publication_on <= :at
    ", at: at)
  end

  def visible?(at = Date.current)
    (announce_on && announce_on <= at) ||
    (preorder_on && preorder_on <= at) ||
    publication_on <= at
  end

  def buyable?(at = Date.current)
    (preorder_on && preorder_on <= at) ||
    publication_on <= at
  end

end


