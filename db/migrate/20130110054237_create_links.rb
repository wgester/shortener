# Put your database migration here!
#
# Each one needs to be named correctly:
# timestamp_[action]_[class]
#
# and once a migration is run, a new one must
# be created with a later timestamp.

class CreateLinks < ActiveRecord::Migration
    # PUT MIGRATION CODE HERE TO SETUP DATABASE

    def self.up
      create_table :shortLinks do |t|
        t.string :url
        t.string :shortUrl
      end
    end

    def self.down
    end

end