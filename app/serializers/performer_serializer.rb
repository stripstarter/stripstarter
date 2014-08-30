class PerformerSerializer < UserSerializer
  has_many :performances

  attributes :name

end