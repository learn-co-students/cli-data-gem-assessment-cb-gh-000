class Meta
  attr_accessor :author, :date, :section

  def initialize(hash)
    hash.each { |key, value| self.send(("#{key}="), value) }
  end

end
