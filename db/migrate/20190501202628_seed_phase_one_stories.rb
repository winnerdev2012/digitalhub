require 'csv'

class SeedPhaseOneStories < ActiveRecord::Migration[5.2]
  def up
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'phase_1_stories.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      ::Refinery::Stories::Story.create( question: 'question' + row[0],
                                         submitter_name: row['Name'],
                                         response: row['Text'],
                                         display: true)
    end
  end

  def down
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'phase_1_stories.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      ::Refinery::Stories::Story.find_by(submitter_name: row['Name']).destroy
    end
  end
end
