class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end
  
  post '/pets' do 
    # binding.pry
    @pet = Pet.create(params[:pet])
      # if !params["owner"]["name"].empty?
      #   @pet.owners << Owner.create(name: params["owner"]["name"])
      # end
      if !params["owner"]["name"].empty?
        owner = Owner.create(params[:owner])
        owner.pets << @pet
      end
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 

    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      # owner = Owner.create(params) ## this works, but is less specific
      owner = Owner.create(name: params["owner"]["name"]) 
      owner.pets << @pet
    end      
    redirect to "pets/#{@pet.id}"
  end
end