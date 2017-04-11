class Class
  def descendants
    descendants = []
    ObjectSpace.each_object(singleton_class) do |klass|
      descendants.unshift klass unless klass == self
    end
    descendants
  end

  def subclasses
    subclasses = []
    chain = descendants
    chain.each do |klass|
      subclasses << klass unless chain.any? { |c| c > klass }
    end
    subclasses
  end
end
