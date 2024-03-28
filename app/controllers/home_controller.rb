class HomeController < ApplicationController
  include ExcelTemplateHelper
  include ExcelTemplateHelper2
  def index
    @cats = Cat.all.order(:id)
  end

  def post1
    # 3歳未満 かつ にぼし15個未満の場合は煮干し15個に更新
    target_cats = Cat.where('age < ?', 3).where('fee < ?', 15)
    target_cats.update_all(fee: 15)
    flash[:notice] = "#{target_cats.map(&:name).join(',')}を更新しました"
    return redirect_to home_index_path

  end

  def post2
    # にぼし15個の猫をにぼし10個に更新する
    target_cats = Cat.where(fee: 15)
    target_cats.update_all(fee: 10)
    # flash[:notice] = "#{target_cats.map(&:name).join(',')}を更新しました"
    flash[:notice] = "もとに戻しました"
    return redirect_to home_index_path
  end

  def post3
    # 3歳未満 かつ にぼし15個未満の場合は煮干し15個に更新
    target_cats = Cat.where('age < ?', 3).where('fee < ?', 15)
    target_cats.reload # ここでSQL発行させておく
    target_cats.update_all(fee: 15)
    flash[:notice] = "#{target_cats.map(&:name).join(',')}を更新しました"
    return redirect_to home_index_path
  end

  def download
    create_data
    send_data(
      excel_render('lib/excel_templates/sample1.xlsx').stream.string,
      type: 'application/vnd.ms-excel',
      filename: "#{@datetime.strftime("%Y%m%d_%H%M%S")}_sample1（#{@staff.name}）.xlsx"
    )
  end

  def download2
    create_data
    send_data(
      excel_render2('lib/excel_templates/sample2.xlsx').stream.string,
      type: 'application/vnd.ms-excel',
      filename: "#{@datetime.strftime("%Y%m%d_%H%M%S")}_sample2（#{@staff.name}）.xlsx"
    )
  end

  private

  def create_data
    @datetime = Time.current
    @staff = Staff.find(5)
    @cats = Cat.all.order(:id)
    @title = '猫一覧'
  end
end
