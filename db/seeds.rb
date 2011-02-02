# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

alice = User.create(:name => 'Alice', :email => 'alice@myskichalet.co.uk')

france = Country.create(:name => 'France')

Country.create([
  {:name => 'Austria'},
  {:name => 'Italy'},
  {:name => 'Switzerland'}
  ])

chamonix = Resort.create(:country_id => france.id, :name => 'Chamonix')
