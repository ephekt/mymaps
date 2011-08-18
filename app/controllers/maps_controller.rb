class MapsController < ApplicationController
  # GET /maps
  # GET /maps.xml
  def index
    @maps = Map.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @maps }
    end
  end

  # GET /maps/1
  # GET /maps/1.xml
  def show
    @map = Map.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @map }
    end
  end

  # GET /maps/new
  # GET /maps/new.xml
  def new
    @map = Map.new

    puts @saved_locations
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @map }
    end
  end

  # GET /maps/1/edit
  def edit
    @map = Map.find_by_id(params[:id])
    @saved_locations = @map.points.for_editing.to_json
  end

  # POST /maps
  # POST /maps.xml
  def create
    @map = Map.new(params[:map])
    @map.name = "Map Created #{Time.now.strftime('at %I:%M%p')}" if @map.name.blank?
    @map.description = "No Description Provided" if @map.description.blank?
    if points = params['markers']
      points.each do |marker_identifier, point|
        @map.points.build(:lat => point['lat'].to_f,:lng => point['lng'].to_f,:description =>point['description'], :marker_identifier => marker_identifier)
      end
    end
    respond_to do |format|
      if @map.save
        format.html { redirect_to(@map, :notice => 'Map was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /maps/1
  # PUT /maps/1.xml
  def update
    @map = Map.find_by_id(params[:id])
    new_points = []
    if points = params['markers']
      points.each do |marker_identifier,point|
        new_points << @map.points.build(:marker_identifier => marker_identifier, :lat => point['lat'], :lng => point['lng'],:description =>point['description'])
      end
    end
    @map.points = new_points    
    respond_to do |format|
      if @map.update_attributes(params[:map])
        format.html { redirect_to(@map, :notice => 'Map was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.xml
  def destroy
    @map = Map.find_by_id(params[:id])
    @map.destroy

    respond_to do |format|
      format.html { redirect_to(maps_url) }
      format.xml  { head :ok }
    end
  end
end
