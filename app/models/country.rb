class Country < ActiveRecord::Base
  has_many :posts

  validates :name, presence: true

  def self.get_countries
    response = HTTParty.get("http://www.geognos.com/api/en/countries/info/all.json")
    doc = JSON.parse(response.body)["Results"].sort_by { |key, value| value["Name"] }
    countries = doc.collect { |key, value|
      Hash.new.tap { |hash|
        hash[:name] = value["Name"]
        hash[:url] = value["CountryInfo"]
      }
    }

    countries.each {|country|
      Country.create(country)
    }
  end
end