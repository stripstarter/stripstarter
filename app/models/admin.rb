class Admin < User

  def method_missing(meth, *args, &block)
    self
  end

end