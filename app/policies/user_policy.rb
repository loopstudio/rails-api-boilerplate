class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(id: user.id)
    end
  end

  def show?
    user.id.eql?(object.id)
  end
end
