# coding: utf-8

require 'sinatra/base'
require 'haml'
require 'todo'


module Todo
  class Application < Sinatra::Base

    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader

      set :haml, escape_html: true
    end

    get '/' do
      haml :index
    end

    # get '/tasks' do
    #
    #   DB.prepare unless DB.connected?
    #
    #   @tasks = Task.order("created_at DESC")
    #   if @status = params[:status]
    #     case @status
    #     when 'not_yet'
    #       @tasks = @tasks.status_is_not_yet
    #     when 'done'
    #       @tasks = @tasks.status_is_done
    #     when 'pending'
    #       @tasks = @tasks.status_is_pending
    #     else
    #       @status = nil
    #     end
    #   end
    #   haml :index
    # end

    get '/tasks' do
      todo = Todo::Command.new({})
      @status = params['status'] || nil
      @tasks = todo.find_tasks(@status)
      haml :index
    end
  end

end
