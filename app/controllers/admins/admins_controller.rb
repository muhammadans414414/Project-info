class Admins::AdminsController < ApplicationController
    def index
        @users=User.all
        authorize [:admins,@users]
    end
end
