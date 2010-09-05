class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.xml
  def index
    @championship = Championship.find(params[:championship_id])
    #@teams = Team.find_all_by_championship_id(params[:championship_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @championship.teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
#  def new
#    @team = Team.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @team }
#    end
#  end

  # GET /teams/new_teams
  def new_teams
    begin
      @championship = Championship.find(params[:id], :conditions => {:user_id => session[:user_id]})

      @teams = []
      @championship.number_teams.times {
        @teams << Team.new
      }

      if @championship.teams.size == @championship.number_teams
        flash[:notice] = "Teams already created."
        redirect_to(:action => 'index', :championship_id => @championship)
      end
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to(:controller => 'championships', :action => 'index')
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    if @team.championship.user_id != session[:user_id]
      flash[:notice] = "Team not allowed"
      redirect_to(:controller => 'championships')
    end
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        flash[:notice] = 'Team was successfully created.'
        format.html { redirect_to(@team) }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create_teams
    @championship = Championship.find(params[:championship_id], :conditions => {:user_id => session[:user_id]})
    teams = params[:team]
    if teams.size == (@championship.number_teams - @championship.teams.size)
      Team.create(teams) { |team|
        team.championship = @championship
      }
      flash[:notice] = 'Teams was successfully created.'
    else
      flash[:notice] = 'Teams not created.'
    end
    respond_to do |format|
      format.html { redirect_to(@championship) }
      format.xml  { render :xml => @championship }
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.championship.user_id == session[:user_id] and @team.update_attributes(params[:team])
        flash[:notice] = 'Team was successfully updated.'
        format.html { redirect_to(@team) }
        format.xml  { head :ok }
      else
        flash[:notice] = 'Team was not updated.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end
end
