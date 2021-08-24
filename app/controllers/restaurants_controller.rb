class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  def index
    # @restaurants = Restaurant.all
    # it will call the policy scope inside our restaurant
    # it will look inside out policy restaurant inside our
    # scope class and this class and calls all.
    # the reason why this is different is bc we are authorizing
    # all and not only one instance
    @restaurants = policy_scope(Restaurant)
  end

  # GET /restaurants/1
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    # the instance of restaurant is what i wanna authorize
    # we will then go inside policy and decide which user is authorized
    # to perform this action
    authorize @restaurant
    # REFRESH LOCALHOST -> unable to find policy `RestaurantPolicy
    # so what pundit does is look at this @restaurant and tries to
    # find the restaurant policy
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    # WE WANT TO DO THIS B4 WE SAVE IT
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
    redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
      # i will put it inside the set restaurant method instead of
      # the show bc then it will be called for all of the before
      # actions set in my controller - that way i wont need to put
      # it everywhere keeping the code DRY
      authorize @restaurant
    end

    # Only allow a trusted parameter "white list" through.
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
