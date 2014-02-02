require 'sinatra'
require 'sinatra/activerecord'
require 'fileutils'
require 'haml'

require_relative 'models/init'

set :port, 8080
set :database, "sqlite3:///db/db.sqlite3"


get '/' do
  # maybe should show an empty page? or a login page?
  haml :index
end

get '/:image_id' do
  # render the image inside of a minimal UI
  @img = Image.find_by :image_id => params[:image_id]
  if @img.nil?
    status 404
    return haml :no_image
  end

  haml :image, :locals => {:img => @img}
end

get '/:image_id/raw' do
  # return the actual image file
  @img = Image.find_by :image_id => params[:image_id]
  return status 404 if @img.nil?
  send_file @img.path!
end


post '/add' do
  # make sure 2 things:
  unless  ((@token  = request.env['HTTP_X_TOKEN'])        &&  # 1. token provided and valid
           (@token  = Token.find_by(:token_id => @token)) &&
           (@token.valid?))
    # need to provide a valid token!
    return status 401
  end
  unless  ((params[:file])                                &&  # 2. provided a file
           (tmpfile  = params[:file][:tempfile])          &&
           (filename = params[:file][:filename]))
    # need to provide a file!
    return status 404
  end

  # if here, then token is good, file is provided, tmpfile holds the temporary
  # path, and filename holds the original filename
  meow = DateTime.now

  # update token last accessed timestamp
  @token.last_accessed_at = meow
  @token.save!

  # store image meta in database
  @img = Image.new(:title => filename, :extension => File.extname(filename), :created_at => meow)
  @img.save!

  # copy the image from temp space to the uploads directory
  FileUtils.copy(tmpfile.path, @img.path!)

  @img.image_id

end

