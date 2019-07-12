class ApplicationPolicy
  attr_reader :user, :object

  def initialize(user, object = nil)
    @user = user
    @object = object
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
