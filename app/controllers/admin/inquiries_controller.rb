class Admin::InquiriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @inquiries = Inquiry.all.page(params[:page]).per(10)
  end

  def edit
    @inquiry = Inquiry.find(params[:id])
    @genres = Genre.all
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  def update
    @inquiry = Inquiry.find(params[:id])
    if @inquiry.update(inquiry_params)
      redirect_to admin_inquiry_path(@inquiry), notice: "お問い合わせの編集に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.update(is_deleted: true)
    flash[:notice] = "削除処理を実行しました"
    redirect_to admin_path
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:genre_id, :company, :name, :name_kana, :email, :telephone_number, :body, :is_deleted)
  end
end