class MatchesController < ApplicationController
  # GET /matches
  # GET /matches.xml
  def index
    @championship = Championship.find(params[:championship_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @championship }
    end
  end

  # GET /matches/1
  # GET /matches/1.xml
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.xml
  def new
    @match = Match.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
    if @match.championship.user_id != @user_logged.id
      flash[:notice] = 'User not allowed.'
      redirect_to championships_url
    end
  end

  # POST /matches
  # POST /matches.xml
  def create
    @match = Match.new(params[:match])

    respond_to do |format|
      if @match.save
        flash[:notice] = 'Match was successfully created.'
        format.html { redirect_to(@match) }
        format.xml  { render :xml => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  def generate
    begin
      @championship = Championship.find(params[:championship_id])
      if @championship.user_id != @user_logged.id or !@championship.matches.empty?
        flash[:notice] = 'Not allowed.'
      else
        match_generator
      end
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to(:controller => :matches, :championship_id => @championship) }
      format.xml  { head :ok }
    end
  end

  # PUT /matches/1
  # PUT /matches/1.xml
  def update
    @match = Match.find(params[:id])
    if @match.championship.user_id != @user_logged.id
      flash[:notice] = 'User not allowed.'
      redirect_to championships_url
    else
      respond_to do |format|
        if @match.update_attributes(params[:match])
          flash[:notice] = 'Match was successfully updated.'
          format.html { redirect_to(@match) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.xml
  def destroy
    @match = Match.find(params[:id])
    if @match.championship.user_id != @user_logged.id
      flash[:notice] = 'User not allowed.'
      redirect_to championships_url
    else
      @match.destroy

      respond_to do |format|
        format.html { redirect_to(matches_url) }
        format.xml  { head :ok }
      end
    end
  end


  private
    def match_generator
      # for 1 turn
      rounds = (@championship.number_teams - 1)
      teams = @championship.teams
      matches = teams.combination(2).to_a

      for i in (1..rounds) do
        m = []
        k = 0
        for j in (0..(matches.size-1)) do
          t = matches.at(j)
          if !m.include?(t[0].id) and !m.include?(t[1].id)
            create_match(t, i)
            matches.delete_at(j)
            m = m.concat([t[0].id, t[1].id])
            k = k+1
          end
          if k == teams.size/2
            break
          end
          if k == (teams.size/2) -1 and i == rounds
            create_match(matches.at(0), i)
            break
          end
        end
      end
    end

    def create_match(item, round)
      match = Match.new
      match.home_team = item[0]
      match.away_team = item[1]
      match.status = 0
      match.championship = @championship
      match.home_score = 0
      match.away_score = 0
      match.round = round
      match.save!
    end
end
