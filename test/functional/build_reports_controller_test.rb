require 'test_helper'

class BuildReportsControllerTest < ActionController::TestCase
  setup do
    @build_report = build_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:build_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create build_report" do
    assert_difference('BuildReport.count') do
      post :create, build_report: {  }
    end

    assert_redirected_to build_report_path(assigns(:build_report))
  end

  test "should show build_report" do
    get :show, id: @build_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @build_report
    assert_response :success
  end

  test "should update build_report" do
    put :update, id: @build_report, build_report: {  }
    assert_redirected_to build_report_path(assigns(:build_report))
  end

  test "should destroy build_report" do
    assert_difference('BuildReport.count', -1) do
      delete :destroy, id: @build_report
    end

    assert_redirected_to build_reports_path
  end
end
