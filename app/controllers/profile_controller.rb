class ProfileController < ApplicationController
  def show
  end

  def edit
  end

  def update
    # current_userとか使ってるけどヘルパーも定義していない && deviseとかも入れてないのでただの例示
    # mass assignment 脆弱性を含むコード
    user = current_user
    user.update(params[:user])
  end
end
