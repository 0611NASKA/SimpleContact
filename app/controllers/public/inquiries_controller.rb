class Public::InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new(session[:inquiry_params] || {})
    session.delete(:inquiry_params)
    @genres = Genre.all
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      session[:inquiry_params] = inquiry_params
      render :confirm
    else
      @genres = Genre.all
      render :new
    end
  end

  def create
    @inquiry = Inquiry.new(session[:inquiry_params])
    if @inquiry.save
      session.delete(:inquiry_params)
      redirect_to inquiries_complete_path
    else
      @genres = Genre.all
      render :new
    end
  end

  def complete
    
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:genre_id, :company, :name, :name_kana, :email, :email_confirmation, :telephone_number, :body, :is_deleted)
  end
end
