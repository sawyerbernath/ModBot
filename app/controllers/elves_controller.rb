class ElvesController < ApplicationController
  def index
    @elves = Elf.where 'name != ""'
  end

  def show
    @elf = Elf.find params[:id]
    @elf_links = @elf.tasks.map do |t|
      ["#{t.id}: #{t.task_type.name} on #{t.updated_at.strftime("%l:%M%p %B %d, %Y")}",
       task_path(t.id)]
    end
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

  def select_index
    @elf = Elf.find params[:id]
    @ptasks = Task.select {|t| t.status =='Posted'}
  end

  def punch_in
    @elf = Elf.find params[:id]
    @username = CLOCK_NAMES[@elf.name].gsub(/ /, '%20')
    @password = params[:password]
    response = HTTParty.get("#{API_URL}?operation=100&username=#{@username}&password=#{@password}")
    r = JSON.parse(response.parsed_response)
    if r["status"] == 0
      flash[:notice] = "#{@elf.name} punched in."
    else
      flash[:warning] = "Punch in failed. (Incorrect password?)"
    end

    redirect_to home_path
  end

  def punch_out
    @elf = Elf.find params[:id]
    @username = CLOCK_NAMES[@elf.name].gsub(/ /, '%20')
    @password = params[:password]
    response = HTTParty.get("#{API_URL}?operation=101&username=#{@username}&password=#{@password}")
    r = JSON.parse(response.parsed_response)
    if r["status"] == 0
      flash[:notice] = "#{@elf.name} punched out."
    else
      flash[:warning] = "Punch out failed. (Incorrect password?)"
    end

    redirect_to home_path
   end
end
