require 'rails_helper'

describe ItemsController do

  it_renders_404_when_item_not_found :show, :edit, :update, :destroy

  describe 'show action' do

    it 'renders show template if an item is found' do
      item = create(:item)
      get :show, id: item.id
      response.should render_template('show')
    end

  end

  describe 'create action' do

    it 'redirects to created item page if validation pass' do
      post :create, item: { name: 'Item1', price: '10' }, admin: 1
      response.should redirect_to(item_path(assigns(:item)))
    end

    it 'renders new page again if validation fails' do
      post :create, item: { name: 'Item1', price: 0 }, admin: 1
      response.should render_template('new')
    end

    it 'renders 403 page if user is not an admin' do
      response.status.should == 403
    end

  end

  describe 'action destroy' do

    it 'redirects to index when item is deleted' do
      item = create(:item)
      delete :destroy, id: item.id, admin: 1
      response.should redirect_to(items_path)
    end

  end

end
