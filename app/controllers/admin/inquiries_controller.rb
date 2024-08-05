class Admin::InquiriesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_admin!
  def index
    search_params = build_search_params
    @q = Inquiry.ransack(search_params)
    @inquiries = @q.result(distinct: true).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
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
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.update_column(:is_deleted, true)
    flash[:notice] = "削除処理を実行しました"
    redirect_to admin_path
  end

  private

  def sort_column
    Inquiry.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def build_search_params
    search_params = {}
    if params[:company_search_type].present? && params[:company_value].present?
      search_params["company_#{params[:company_search_type]}"] = params[:company_value]
    end
    if params[:name_search_type].present? && params[:name_value].present?
      search_params["name_#{params[:name_search_type]}"] = params[:name_value]
    end
    search_params
  end
end
