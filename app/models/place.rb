# プレイスクラス
# 製作日 2020/11/29
# 更新日 2020/12/12

class Place < ApplicationRecord
  validates :name, {presence: true}

  def self.search(search)
    if search
      Place.where(['name LIKE ?', "%#{search}%"])
    else
      Place.all
    end
  end


  def self.getDoc(link)
    #取得するhtml用charset
    charset = nil

    html = open(link) do |page|
      #charsetを自動で読み込み、取得
      charset = page.charset
      #中身を読む
      page.read
    end

    # Nokogiri で切り分け
    # @contents = Nokogiri::HTML.parse(html,nil,charset)
    @doc = Nokogiri::HTML(open(link))
    return @doc
  end

  def self.tabelogTitles(name)
    if @tabelog = Place.find_by(name: name, service: "食べログ")
      @tabelogUrl = @tabelog.link
      @tabelogDoc = Place.getDoc(@tabelogUrl)
      @tabelogTitles = @tabelogDoc.xpath("//a[@class='list-rst__rst-name-target cpy-rst-name js-ranking-num']")
      return @tabelogTitles
    else
      @tabelogUrl = 'https://tabelog.com/tokyo/rstLst/?SrtT=rt&Srt=D&sort_mode=1'
      @tabelogDoc = Place.getDoc(@tabelogUrl)
      @tabelogTitles = @tabelogDoc.xpath("//a[@class='list-rst__rst-name-target cpy-rst-name js-ranking-num']")
      return @tabelogTitles
    end
  end

  def self.tabelogContents(name)
    if @tabelog = Place.find_by(name: name, service: "食べログ")
      @tabelogUrl = @tabelog.link
      @tabelogDoc = Place.getDoc(@tabelogUrl)
      @tabelogContents = @tabelogDoc.xpath("//div[@class='list-rst__wrap js-open-new-window']")
      return @tabelogContents
    else
      return "データがありません"
    end
  end

  def self.tabelogLinks(name)
    # @tabelog = Place.services()
    if @tabelog = Place.find_by(name: name, service: "食べログ")
      @tabelogUrl = @tabelog.link
      @tabelogDoc = Place.getDoc(@tabelogUrl)
      @tabelogLinks = @tabelogDoc.xpath("//a[@class='list-rst__rst-name-target cpy-rst-name js-ranking-num']").attribute("href")
      return @tabelogLinks
    else
      return "データがありません"
    end
  end

  def self.tabelogReputations(name)
    # @tabelog = Place.services()
    if @tabelog = Place.find_by(name: name, service: "食べログ")
      @tabelogUrl = @tabelog.link
      @tabelogDoc = Place.getDoc(@tabelogUrl)
      @tabelogReputations = @tabelogDoc.xpath("//span[@class='c-rating__val c-rating__val--strong list-rst__rating-val']")
      return @tabelogReputations
    else
      return "データがありません"
    end
  end

  def self.tabelogImgs(name)
    @tabelogTitles = Place.tabelogTitles(name)
    if @tabelog = Place.find_by(name: name, service: "食べログ")
      @tabelogUrl = @tabelog.link
      @tabelogDoc = Place.getDoc(@tabelogUrl)
      @tabelogImgs = @tabelogDoc.css("img.p-main-photos__slider-image").attribute("src")
      if not @tabelogImgs
        @tabelogImgs = @tabelogDoc.css("a.js-imagebox-trigger img").attribute('src')
      end
      return @tabelogImgs
    else
      @tabelogUrl = 'https://tabelog.com/tokyo/rstLst/?SrtT=rt&Srt=D&sort_mode=1'
      @tabelogDoc = Place.getDoc(@tabelogUrl)
      @tabelogImgs = @tabelogDoc.css("img.p-main-photos__slider-image").attribute("src")
      if not @tabelogImgs
        @tabelogImgs = @tabelogDoc.css("a.js-imagebox-trigger img").attribute('src')
      end
      return @tabelogImgs
    end
  end

  def self.rettyTitles(name)
    # @tabelog = Place.services()
    if @retty = Place.find_by(name: name, service: "Retty")
      @rettyUrl = @retty.link
      @rettyDoc = Place.getDoc(@rettyUrl)
      @rettyTitles = @rettyDoc.xpath("//h3[@class='restaurant__name']")
      return @rettyTitles
    else
      return "データがありません"
    end
  end

  def self.rettyContents(name)
    if @retty = Place.find_by(name: name, service: "Retty")
      @rettyUrl = @retty.link
      @rettyDoc = Place.getDoc(@rettyUrl)
      @rettyContents = @rettyDoc.xpath("//li[@class='restaurants__item']")
      return @rettyContents
    end
  end

  def self.ikkyuContents(name)
    if @ikkyu = Place.find_by(name: name, service: "一休")
      ikkyuUrl = @ikkyu.link
      @ikkyuDoc = Place.getDoc(ikkyuUrl)
      @ikkyuContents = @ikkyuDoc.xpath("//section[@class='restaurantCard_jpBMy']")
      return @ikkyuContents
    end
  end

  def self.ikkyuTitles(name)
    # @tabelog = Place.services()
    if @ikkyu = Place.find_by(name: name, service: "一休")
      @ikkyuUrl = @ikkyu.link
      @ikkyuDoc = Place.getDoc(@ikkyuUrl)
      @ikkyuTitles = @ikkyuDoc.xpath("//h3[@class='restaurantName_2s_sg']")
      return @ikkyuTitles
    end
  end





  def self.services(name)
  end


end
