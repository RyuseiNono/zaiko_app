class EntrancesController < ApplicationController
  before_action :authenticate_user!, only: [:user_chanege_desroy]
  def registrations
  end

  def sessions
  end

  def user_chanege_desroy
  end
end
