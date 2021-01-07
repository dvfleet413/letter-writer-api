class TextController < ApplicationController
    def todays_text
        today = Time.now
        response = HTTParty.get("https://wol.jw.org/wol/dt/r1/lp-e/#{today.year}/#{today.month}/#{today.day}")
        content = response["items"][0]["content"]
        doc = Nokogiri::HTML(content)
        scripture = doc.css('p.themeScrp').text
        comments = doc.css('div.bodyTxt').text
        result = scripture + comments
        render plain: result 
    end
end
