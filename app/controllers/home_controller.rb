class HomeController < ApplicationController
  def index
    @cats = Cat.all.order(:id)
  end

  def post1
    # 3歳未満 かつ にぼし15個未満の場合は煮干し1個増やす
    target_cats = Cat.where('age < ?', 3).where('fee < ?', 15)
    target_cats.update_all(fee: 15)
    flash[:notice] = "#{target_cats.map(&:name).join(',')}を更新しました"
    return redirect_to home_index_path

  end

  def post2
    target_cats = Cat.where('age < ?', 3).where(fee: 15)
    target_cats.update_all(fee: 10)
    flash[:notice] = "#{target_cats.map(&:name).join(',')}を更新しました"
    return redirect_to home_index_path
  end
end
