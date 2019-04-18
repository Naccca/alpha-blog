require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: 'john', email: 'john@mail.com', password: 'password')
    sign_in_as(@user, 'password')
    @category = Category.create!(name: 'sport')
  end

  test 'get new article form and create article' do
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'Some title', description: 'Some title description', user_id: 1, category_ids: [@category.id] } }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match 'Some title', response.body
  end

  test 'invalid article submission results in failure' do
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: 'Some title', description: 'Some title description', user_id: 1, category_ids: [] } }
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
