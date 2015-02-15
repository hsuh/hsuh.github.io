require 'bundler/setup'
require 'sinatra/base'

# The project root directory
$root = ::File.dirname(__FILE__)
require $root+'/primes.rb'

class SinatraStaticServer < Sinatra::Base

  #get(/.+/) do
  #  send_sinatra_file(request.path) {404}
  #end

  get('/') do
    send_sinatra_file(request.path) {404}
  end

  get('/about') do
    send_sinatra_file(request.path) {404}
  end

  get('/fun') do
    send_sinatra_file(request.path) {404}
  end

  get('/contact') do
    send_sinatra_file(request.path) {404}
  end

  get('/archives') do
    send_sinatra_file(request.path) {404}
  end

  get('/primes') do
    if params['limit']
      @sum = Primes.sum_to(params['limit'].to_i)
    end

    if request.xhr?
      'The sum is ' + @sum.to_s
    else
      redirect_to '/primes'
    end
  end

  not_found do
    send_file(File.join(File.dirname(__FILE__), 'public', '404.html'), {:status => 404})
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
