class ChampionshipsController < ApplicationController
  # GET /championships
  # GET /championships.xml
  def index
    #@championships = Championship.find_all_by_user_id(session[:user_id])
    @championships = Championship.paginate :page => params[:page], :per_page => 4,
                                          :conditions => {:user_id => session[:user_id]}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @championships }
    end
  end

  # GET /championships/1
  # GET /championships/1.xml
  def show
    @championship = Championship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @championship }
    end
  end

  # GET /championships/new
  # GET /championships/new.xml
  def new
    @championship = Championship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @championship }
    end
  end

  # GET /championships/1/edit
  def edit
    begin
      @championship = Championship.find(params[:id], :conditions => {:user_id => session[:user_id]})
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to(:action => 'index')
    end
  end

  # POST /championships
  # POST /championships.xml
  def create
    @championship = Championship.new(params[:championship])

    respond_to do |format|
      #if @championship.save
      if @user_logged.championships << @championship
        flash[:notice] = 'Championship was successfully created.'
        format.html { redirect_to(@championship) }
        format.xml  { render :xml => @championship, :status => :created, :location => @championship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @championship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /championships/1
  # PUT /championships/1.xml
  def update
    @championship = Championship.find(params[:id], :conditions => {:user_id => session[:user_id]})

    respond_to do |format|
      if verify_attributes() and @championship.update_attributes(params[:championship])
        flash[:notice] = 'Championship was successfully updated.'
        format.html { redirect_to(@championship) }
        format.xml  { head :ok }
      else
        flash[:notice] = 'Error while trying to update.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @championship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /championships/1
  # DELETE /championships/1.xml
  def destroy
    begin
      @championship = Championship.find(params[:id], :conditions => {:user_id => session[:user_id]})
      @championship.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to(championships_url) }
      format.xml  { head :ok }
    end
  end

  private
  def verify_attributes
    if params[:championship][:match_type] and params[:match_type] != @championship.match_type
      return false
    end
    return true
  end
end
