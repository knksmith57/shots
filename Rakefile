require 'sinatra/activerecord/rake'
require './app'

namespace :token do
  ActiveRecord::Base.logger = nil

  desc "Generate new token"
  task :new do
    @t = Token.new
    @t.save!
    puts @t.token_id
  end

  desc "List all tokens"
  task :list do
    @tokens = Token.all
    @tokens.each do |t|
      puts "[#{t.id}]\t\t#{t.token_id}\t\t#{t.is_valid? ? 'active' : 'expired'}"
    end
  end

  ## TODO: this doesn't work right now, can't figure out the syntax
  desc "Deactivate a token"
  task :deactivate, :id do |t, id|
    puts id

    # first try to find by id
    @t = Token.find(id)
    unless @t.nil?
      return @t.destroy
    end

    # that didn't work, try to find by token_id
    @t = Token.find_by(:token_id => id)
    unless @t.nil?
      return @t.destroy
    end

    # that didn't work, print an error message
    puts "failed to find token: #{id}!"
  end

end
