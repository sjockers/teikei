class Api::V1::PlacesController < Api::V1::BaseController
  def index
    @places = Place.all.includes(:places).includes(:reverse_places).includes(:users)
    @places
  end
end
