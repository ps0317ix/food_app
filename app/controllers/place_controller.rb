class PlaceController < ApplicationController

  before_action :insert_shops, {only: [:create]}

  def index
    @places = Place.search(params[:search])
  end

  # 新規登録
  def new
    @place = Place.new
  end

  def show
    @places = Place.where(name: params[:name])
    @Shops = Shop.where(area: params[:name])
    @services = Place.services(name: params[:name])
    @tabelog = Place.find_by(name: params[:name], service: "食べログ")
    @retty = Place.find_by(name: params[:name], service: "Retty")
    @tabelogContents = Place.tabelogContents(params[:name])
    @rettyTitles = Place.rettyTitles(params[:name])
    @ikkyuTitles = Place.ikkyuTitles(params[:name])
  end


  def create
    @place = Place.new(name: params[:name], link: params[:link], service: params[:service])
    link = params[:link]
    charset = nil
    html = open(link) do |page|
      #charsetを自動で読み込み、取得
      charset = page.charset
      #中身を読む
      page.read
    end
    @Doc = Nokogiri::HTML(open(link))

    if params[:service] == "食べログ"
      @tabelogContents = @Doc.xpath("//div[@class='list-rst__wrap js-open-new-window']")
      @tabelogContents.each do |content|
        @tabelogTitle = content.xpath(".//a[@class='list-rst__rst-name-target cpy-rst-name js-ranking-num']")
        @tabeloghref = @tabelogTitle.attribute("href")
        charset = nil
        html = open(@tabeloghref) do |page|
          #charsetを自動で読み込み、取得
          charset = page.charset
          #中身を読む
          page.read
        end
        @tabelogDoc = Nokogiri::HTML(open(@tabeloghref))
        @tabelogImg = @tabelogDoc.css("img.p-main-photos__slider-image").attribute("src")
        if not @tabelogImg
          @tabelogImg = @tabelogDoc.css("a.js-imagebox-trigger img").attribute('src')
        end
        @tabelogJenre = @tabelogDoc.at_css('#rst-data-head > table:nth-child(2) > tbody > tr:nth-child(3) > td > span > text()')
        @Shops = Shop.new(name: @tabelogTitle.inner_text, link: @tabeloghref, area: params[:name], service: params[:service], img: @tabelogImg, jenre: @tabelogJenre)
        @Shops.save
      end
    elsif params[:service] == '一休'
      @Doc.each do |content|
        @ikkyuhref = content.xpath(".//a[@class='cover_3Ae77']").attribute("href")
        @ikkyuTitle = content.xpath(".//h3[@class='restaurantName_2s_sg']")
        charset = nil
        html = open(@ikkyuhref) do |page|
          #charsetを自動で読み込み、取得
          charset = page.charset
          #中身を読む
          page.read
        end
        @ikkyuDoc = Nokogiri::HTML(open(@ikkyuhref))
        @ikkyuImg = @ikkyuDoc.css("img.image_3ZIQh").attribute('src')
        @Shops = Shop.new(name: @ikkyuTitle.inner_text, link: @ikkyuhref, area: params[:name], service: params[:service], img: @ikkyuImg)
        @Shops.save
      end
    end

    if @place.save
      flash[:notice] = "地域登録が完了しました"
      redirect_to("/place/#{@place.name}")
    else
      flash[:notice] = "地域登録が失敗しました"
      render("insert")
    end
  end


  def search
    @allPlaces = Place.all
    @tabelogs = Place.where(service: "食べログ")

    if params[:search]
      @places = Place.search(params[:search])
      @shops = Shop.search(params[:search])
      @services = Place.services(params[:search])
      @tabelogContents = Place.tabelogContents(params[:search])
      @rettyContents = Place.rettyContents(params[:search])
      @ikkyuContents = Place.ikkyuContents(params[:search])
    else
      @places = Place.all
    end
  end

  def search_exe
    @places = Place.search(params[:search])
    @Shops = Shop.where(area: params[:search])
    @services = Place.services(params[:search])
    @tabelogTitles = Place.tabelogTitles(params[:search])
    @rettyTitles = Place.rettyTitles(params[:search])
  end
