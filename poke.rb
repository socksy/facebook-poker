require 'net/http'
#require 'net/https'
require 'uri'

email = "example@gmail.com"
pass = "password"
uid = "1000001########"
useragent = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1'

url = URI.parse('http://m.facebook.com/login.php')
http = Net::HTTP.new(url.host, 80)

resp = http.get(url.path, nil)
cookie = resp.response['set-cookie']



data = 'login.php?m=m&refsrc=http%3A%2F%2Fm.facebook.com%2F&refid=9&http&email='+email+"&pass="+pass
headers = {
	'Cookie' => cookie,
	'Referer' => url.scheme+url.host+url.path,
	'Content-Type' => 'application/x-www-form-urlencoded',
	'User-Agent' => useragent
}

resp = http.post(url.path, data, headers)


puts 'Code = ' + resp.code
puts 'Message = ' + resp.message

url = URI.parse('http://m.facebook.com/')
resp = http.request_get(url.path)

#gfid1 = /gfid=(.*?)&amp/.match(resp.body)
#puts 'gfid1 = ' + gfid1[1]

resp.body.scan(/gfid=(.*?)&amp/) {|gfid|


	resp = http.get('/a/home.php?poke='+uid+'&gfid'+gfid.to_s+'&refid=17&http', headers)
 #'&gfid='+gfid[1]+
puts 'Code = ' + resp.code
puts 'Message = ' + resp.message
}
puts 'poked '+uid 
