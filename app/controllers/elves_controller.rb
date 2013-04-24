class ElvesController < ApplicationController
  def index
    @elves = Elf.where 'name != ""'
  end

  def show
    @elf = Elf.find params[:id]
  end

  def new
  end

  def create
    @elf = Elf.create params[:elf]
    @elf.tasks.create :name => ''
    flash[:notice] = "A new elf has been born! Its name is #{@elf.name}."
    redirect_to elves_path
  end

  def edit
    @elf = Elf.find params[:id]
  end

  def update
    @elf = Elf.find params[:id]
    @elf.update_attributes! params[:elf]
    flash[:notice] = "The elf #{@elf.name} was successfully updated."
    redirect_to elf_path(@elf)
  end

  def destroy
    @elf = Elf.find params[:id]
    @elf.tasks.each do |t|
      t.elf = (Elf.where 'name = ""').first
      t.save
    end
    @elf.destroy
    flash[:notice] = "#{@elf.name} is dead. None will mourne his/her passing."
    redirect_to elves_path
  end
end
