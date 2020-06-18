class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
    @user = current_user
    @users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def create
    @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
    if @book.save #入力されたデータをdbに保存する。
      redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
    else
      @books = Book.all
      render templete: 'book/index'
    end
  end
  
  def edit
    @user = User.find(params[:id])
     @book = Book.new
    unless @user.id == current_user.id
      redirect_to  user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "successfully updated user!"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
   end

end

