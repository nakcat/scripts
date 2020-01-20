# sinatraで動かすことを前提に作成
# とあるアプリケーションで画像ファイルのソースが
# httpsでないと表示できないという要求があった。
# その要件に対応するためにhttp->https化するプロキシとして作成。
# 対象とする画像はjpegファイル
require 'sinatra'
require 'base64'
require 'net/http'
require 'uri'

# 死活監視用API
get '/' do
  'OK'
end

# プロキシ経由で取得したい画像ファイルのURLを指定する
get '/images/:urlbase64' do |urlbase64|
  image = nil
  url = (Base64.urlsafe_decode64 urlbase64).chomp
  content_type 'image/jpeg'
  image = Net::HTTP.get_response(URI.parse(url)).body
end

# プロキシ経由で取得したい画像ファイルのURLを指定する
# URLがファイル名でないと気になる場合用に作成
get '/images/:urlbase64/dummy.jpg' do |urlbase64|
  image = nil
  url = (Base64.urlsafe_decode64 urlbase64).chomp
  content_type 'image/jpeg'
  image = Net::HTTP.get_response(URI.parse(url)).body
end

