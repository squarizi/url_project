class UrlsController < ApplicationController

  def show
    load_url
    redirect_to @url.long_url unless params[:redirect] == 'no'
  end

  def new
    build_url
  end

  def create
    build_url(permitted_params)
    save_url or render action: 'new', status: :unprocessable_entity
  end

  private

  def load_url
    @url ||= Url.with_token(params[:token])
    raise ActiveRecord::RecordNotFound unless @url
  end

  def build_url(url_params = nil)
    @url ||= Url.new
    return unless url_params

    @url.attributes = url_params
  end

  def save_url
    return unless @url.save

    flash[:notice] = 'Success!'
    redirect_to action: :show, token: @url.token, redirect: 'no'
  end

  def permitted_params
    params.require(:url).permit(:long_url)
  end
end
