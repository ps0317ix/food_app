
# ホーム関連
# 製作日 2020/11/29
# 更新日 2020/12/02

require "open-uri"
require "nokogiri"

class HomeController < ApplicationController

  before_action :forbid_login_user, {only: [:top]}
  before_action :allPlace, {only: [:top]}

  def top
    @allPlaces = Place.all
    if @allPlaces
      @tabelogUrl = 'https://tabelog.com/tokyo/rstLst/?SrtT=rt&Srt=D&sort_mode=1'
      charset = nil
      html = open(@tabelogUrl) do |page|
        #charsetを自動で読み込み、取得
        charset = page.charset
        #中身を読む
        page.read
      end
      @tabelogDoc = Nokogiri::HTML(open(@tabelogUrl))
      @tabelogContents = @tabelogDoc.xpath("//div[@class='list-rst__wrap js-open-new-window']")
      @tabelogImgs = @tabelogDoc.css("img.js-cassette-img").attribute("src")
    end
  end

  def about
  end
end
