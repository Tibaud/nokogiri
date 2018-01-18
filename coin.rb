
require 'rubygems'
require 'nokogiri'
require 'open-uri'
#on numérote les valeurs afin de faire corespondre prix et nom
def get_all_values
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	coins_list = []
  	page.xpath('//a[@class="currency-name-container"]').each do |coins|
  		coins_list << coins
  	end
	return coins_list.length
end
#on remonte le nom de monnaies
def get_currencies(x)
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	name_list = []
	page.xpath('//a[@class="currency-name-container"]').each do |name|
		name_list << name.text
	end
	 return name_list[0..x]
end
#on remonte le prix des monnaies
def get_coins_price(x)
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	price_list = []
	page.xpath('//a[@class="price"]').each do |price|
		price_list << price.text
	end
	return price_list[0..x]
end
loop {
#on fait correspondre les numéros des noms avec les prix
num = get_all_values
h = get_currencies(num).zip(get_coins_price(num)).to_h
#on exporte les datas dans un fichier
#je voulais créer un versionnage du fichier mais ... ben j'y suis pas arrivé
fname = "my_thune.out"
somefile = File.open(fname,"w")
somefile.puts h
somefile.close
puts "fichier mis à jour, sera écrasé dans un heure"
sleep(3600)
}
