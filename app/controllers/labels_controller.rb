class LabelsController < ApplicationController
  load_and_authorize_resource
  # GET /labels
  # GET /labels.json
  def index
    @labels = Label.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @labels }
    end
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
    @label = Label.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @label }
    end
  end

end
