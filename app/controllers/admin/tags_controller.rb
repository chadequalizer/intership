class Admin::TagsController < Admin::BaseController
  before_action :authenticate_admin!
  before_action :find_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def show; end

  def edit; end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_path, notice: t('tags.notice.tag_created')
    else
      render 'new'
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: t('tags.notice.tag_edited')
    else
      render 'edit'
    end
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path, notice: t('tags.notice.tag_deleted')
  end

  private

  def tag_params
    params.require(:tag).permit(:name,
                                :keywords)
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end
end
