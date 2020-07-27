class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    Captain.all.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.all.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    Captain.all.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    Captain.all.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    Captain.all.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
