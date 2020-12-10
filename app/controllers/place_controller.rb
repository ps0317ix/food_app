class PlaceController < ApplicationController

  def index
    @places = Place.search(params[:search])
  end

  # 新規登録
  def new
    @place = Place.new
  end

  def show
    @places = Place.where(name: params[:name])
    @services = Place.services(name: params[:name])
    @tabelog = Place.find_by(name: params[:name], service: "食べログ")
    @retty = Place.find_by(name: params[:name], service: "Retty")
    @tabelogTitles = Place.tabelogTitles(params[:name])
    @tabelogImgs = Place.tabelogImgs(params[:name], @tabelogTitles)
    @rettyTitles = Place.rettyTitles(params[:name])
  end

  def create
    @place = Place.new(name: params[:name], link: params[:link], service: params[:service])
    if @place.save
      flash[:notice] = "地域登録が完了しました"
      redirect_to("/place/#{@place.name}")
    else
      flash[:notice] = "地域登録が失敗しました"
      render("insert")
    end
  end

  def search
    if params[:search]
      @places = Place.search(params[:search])
      @services = Place.services(params[:search])
      @tabelogContents = Place.tabelogContents(params[:search])
      @tabelogTitles = Place.tabelogTitles(params[:search])
      @tabelogImgs = Place.tabelogImgs(params[:search])
      @rettyTitles = Place.rettyTitles(params[:search])
    else
      @places = Place.all
    end
  end

  def search_exe
    @places = Place.search(params[:search])
    @services = Place.services(params[:search])
    @tabelogTitles = Place.tabelogTitles(params[:search])
    @rettyTitles = Place.rettyTitles(params[:search])
  end
end
