class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end
  
  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end
  
  post '/owners' do 
    
    @owner = Owner.create(params[:owner]) # controller action that uses mass assignment to create a new owner and associate it to any existing pets that the user selected via checkboxes from new.erb
      if !params["pet"]["name"].empty?    # checks if a user fillrf out the form field to name and create a new pet. If so, create that new pet and add it to the newly-created owner's list of pets
        @owner.pets << Pet.create(name: params["pet"]["name"])
      end
    redirect "/owners/#{@owner.id}"
  end
  
  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end
  
  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end
  
  patch '/owners/:id' do 
    ####### bug fix
    if !params[:owner].keys.include?("pet_ids")
    params[:owner]["pet_ids"] = []
    end
    #######

    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"

  end
end