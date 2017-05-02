class RanksController < ApplicationController
  before_action :set_rank, only: [:show, :edit, :update, :destroy]

  # GET /ranks
  def index
    @ranks = Rank.all
  end

  # GET /ranks/1
  def show
  end

  # GET /ranks/new
  def new
    @rank = Rank.new
  end

  # GET /ranks/1/edit
  def edit
  end

  # POST /ranks
  def create
    @rank = Rank.new(rank_params)

    if @rank.save
      redirect_to @rank, notice: 'Rank was successfully created.'
    else
      flash[:alert] = @rank.errors.full_messages.join(", ")
      render :new
    end
  end

  # PATCH/PUT /ranks/1
  def update
    if @rank.update(rank_params)
      redirect_to @rank, notice: 'Rank was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ranks/1
  def destroy
    @rank.destroy
    redirect_to ranks_url, notice: 'Rank was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rank
      @rank = Rank.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rank_params
      params.require(:rank).permit(:score_from, :score_to, :name)
    end
end
