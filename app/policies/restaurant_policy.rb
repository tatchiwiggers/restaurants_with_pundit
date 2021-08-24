class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # this is for the index
    def resolve
      # Restaurant.all
      # scope.where(user: user)
      scope.all
    end
  end

# there is no def new here but
# RestaurantPolicy < ApplicationPolicy
# and inside ApplicationPolicy there is
# a def new that call a method create
# that returns false - this is why the
# user is not allowed to create a restaurant

# we always have to think about:
# which users are allowed to create a new restaurant
# EVERYONE - so my method will return true.

  # def new?
  #   true
  # end

  # the first thing pundit will do is come here and look for the
  # method new, if it doesnt find it, it will go inside APP POLICY and run
  # it from there. this will override the new method inside APP POLICY.
  # but bc there is a new method here, it doesnt go inside APP POLICY
  # when it comes here and finds it here it runs it from here.

  # WE DONT NEED NEW? ANYMORE

  def create?
  # again lets think about who is allowed to create a restaurant
  # it will take us to the show page - remember to allow it in controller!!
    true
  end

  def show?
    # again lets think about who is allowed to create a restaurant
    true
  end

  # again lets think about who is allowed to edit a restaurant
  # if the user is the owner of the restaurant it should be true
  # else it should be false
  # i cannot user current_user inside pundit
  # there are only two helpers we can use that are defined
  # inside out app policy whi are
  # @user = user -> this will refer to the current user
  # @record = record -> @restaurant (arg passed to authorize)

  # def edit?
  #   if user == record.user
  #     true
  #   else
  #     false
  #   end
  # end

  # WE DONT NEED EDIT? ANYMORE

  # again lets think about who is allowed to update a restaurant
  def update?
    owner_admin
    # user == record.user || user.admin
  end

  # again lets think about who is allowed to destroy a restaurant
  def destroy?
    owner_admin
    # user == record.user || user.admin
  end

  # FOR THE ADMIN:
  # i would like to make sure that the admin of my app
  # can perform any action - we need to change update and destroy


  private

  def owner_admin?
    user == record.user || user.admin
  end
end
