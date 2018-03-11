class ProfileController < ApplicationController
  def show
  end

  def edit
  end

  def update
    # # current_userとか使ってるけどヘルパーも定義していない && deviseとかも入れてないのでただの例示
    # mass assignment 脆弱性を含むコード
    # user = current_user
    # user.update(params[:user])

    # 外部から渡されるパラメータを信用せず
    # ホワイトリスト形式で検査する
    user = current_user
    user.update(user_params)
  end

  private

  def user_params
    if current_user.admin?
      params.require(:user).permit(:name, :email, :admin)
    else
      params.require(:user).permit(:name, :email)
    end
  end
end
