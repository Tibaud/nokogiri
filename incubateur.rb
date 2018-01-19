require 'rubygems'
require 'nokogiri'
require 'open-uri'
#on créé la boucle pour récupérer le site web de l'incubateur en question
def get_the_webpage(url)
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//div[2]/div/p[2]/a/@href')
	scrap.each do |node| return "Site:" + node.text
	end
end
#on découpe l'URL initiale
def get_all_the_webpages(url)
	h = {}
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//td[2]/p/span/a')
	scrap.each do |node|
		nom = node.text.split.each do |text| text.capitalize!
		end
		nom = "Nom: " + nom * "-"
		url = 'http://mon-incubateur.com/' + node['href'].slice!(1..-1)
		#on lance la boucle pour href des incubateurs
		site = get_the_webpage(url)
		#on stock les datas
		h.store(nom,site)
	end

#on génère le fichier avec les datas dans un format lisible pour le seo
fname = "my_incub.out"
somefile = File.open(fname,"w")
somefile.puts h
somefile.close
end

get_all_the_webpages("http://mon-incubateur.com/site_incubateur/incubateurs")
