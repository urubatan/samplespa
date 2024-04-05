class PeopleController < ApplicationController
  before_action :load_everyone
  def index
    if @people.any?
      @person = @people.first
    end
  end

  def show
    @person = Person.find params[:id]
    respond_to do |format|
      format.turbo_stream
    end
  end

  def new
    @person = Person.new
    respond_to do |format|
      format.turbo_stream
    end
  end

  def edit
    @person = Person.find params[:id]
    respond_to do |format|
      format.turbo_stream do
        render :new
      end
    end
  end

  def create
    @person = Person.create params.require(:person).permit(:name, :email, :description)
    respond_to do |format|
      format.turbo_stream do 
        if @person.valid?
          render :show
        else
          render :new
        end
      end
    end
  end

  def update
    @person = Person.find(params[:id])
    @person.update params.require(:person).permit(:name, :email, :description)
    respond_to do |format|
      format.turbo_stream do 
        if @person.valid?
          render :show
        else
          render :new
        end
      end
    end
  end
  

  private
  def load_everyone
    @people = Person.order(id: :desc)
  end
end
