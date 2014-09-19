class Admin < User

  def method_missing(meth, *args, &block)
    nil
  end

end