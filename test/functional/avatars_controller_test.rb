require 'test_helper'

class AvatarsControllerTest < ActionController::TestCase
  
  test "should get index (logged in or not)" do
    get :index
    assert_response :success
    login!
    get :index
    assert_response :success
  end

  test "should get new if logged in" do
    login!
    get :new
    assert_response :success
  end
  
  test "should not get new if not logged in" do
    get :new
    assert_redirected_to login_path
  end
  
  test "should create avatar if logged in" do
    login!
    assert_difference 'Avatar.count' do
      post :create, :avatar => { :attachment => fixture_file_upload('files/rails.png', 'image/png') }
    end
    assert_redirected_to avatars_path
  end
  
  test "should not create avatar if not logged in" do
    assert_no_difference 'Avatar.count' do
      post :create, :avatar => { :attachment => fixture_file_upload('files/rails.png', 'image/png') }
    end
    assert_redirected_to login_path
  end
            
  test "should not create avatar if not an image" do
    login!
    assert_no_difference 'Avatar.count' do
      post :create, :avatar => { :attachment => fixture_file_upload('files/test.css', 'text/css') }
    end
    assert_response :success # TODO figure out how to test with unit tests instead
  end
  
  test "should select avatar and deselect old avatar" do
    flunk
  end
  
  test "should not select/deselect if not logged in" do
    flunk
  end
  
  test "should not select avatar if already selected by a different user" do
    flunk
  end
    
  # def test_should_select_avatar
  #   login_as :Timothy
  #   post :select, :id => avatars(:calvin).id
  #   users(:Timothy).reload
  #   assert_equal users(:Timothy).avatar, avatars(:calvin).attachment.url
  #   avatars(:calvin).reload
  #   assert_equal users(:Timothy).id, avatars(:calvin).current_user_id
  # end
  
  test "should deselect avatar" do
    flunk
  end
  
  test "should not deselect avatar if selected by a different user" do
    flunk
  end
  
  # def test_should_deselect_avatar
  #   login_as :Timothy
  #   post :select, :id => avatars(:calvin).id
  #   users(:Timothy).reload
  #   assert_equal users(:Timothy).avatar, avatars(:calvin).attachment.url
  #   post :deselect, :id => avatars(:calvin).id
  #   users(:Timothy).reload
  #   assert_nil users(:Timothy).avatar
  #   avatars(:calvin).reload
  #   assert_nil avatars(:calvin).current_user_id
  # end
    
end
