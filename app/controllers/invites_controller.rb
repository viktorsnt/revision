class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.all
  end

  # GET /invites/1
  # GET /invites/1.json
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites
  # POST /invites.json
  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id # set the sender to the current user
    # @invite.invited_at = Time.now.utc

    respond_to do |format|
      if @invite.save
        # if the user already exists
        if @invite.recipient != nil
          InvitationMailer.existing_user_invite(@invite).deliver
          @invite.recipient.projects.push(@invite.project)
          flash.now[:notice] = "User convidado"
        else
          InvitationMailer.deliver_invitation(@invite, invite_sign_up_url(:invite_token => @invite.token)).deliver

          format.html { redirect_to @invite, notice: 'Invite was successfully created.' }
          format.json { render :show, status: :created, location: @invite }
        end
      else
        format.html { redirect_to "/", notice: "Não enviou convite" }
        # format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invites/1
  # PATCH/PUT /invites/1.json
  def update
    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to @invite, notice: 'Invite was successfully updated.' }
        format.json { render :show, status: :ok, location: @invite }
      else
        format.html { render :edit }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.json
  def destroy
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to invites_url, notice: 'Invite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def sign_up
    @user = User.new
    @token = params[:invite_token]
  end

  def create_user
    @user = User.new(user_params)
    token = params[:invite_token]
    @invite = Invite.find_by_token(token)
 
    # Invite code is present, there is an associated invite, and it is the user's invite
    if token && @invite && @invite.email == @user.email
      if @user.save
        @invite.redeemed!

        @project = @invite.project # find the user group attached to the invite
        @user.projects.push(@project) # add this user to the new user group as a member

        InvitationMailer.deliver_confirmation(@user).deliver
        
        # flash[:notice] = "You will receive an email within the next few minutes. It contains instructions for confirming your account."
        sign_in(@user)
        redirect_to @project
      else
        render :action => "sign_up"
      end
    else
      flash.now[:notice] = "Sorry, that code is not redeemable"
      redirect_to sign_up_path
      # render :action => "new"
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_params
      params[:invite].permit(:email, :project_id)
    end

    def user_params
      params[:user].permit(:email, :password, :invite_token)
    end
end
