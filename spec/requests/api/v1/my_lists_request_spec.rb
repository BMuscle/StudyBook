require 'rails_helper'

RSpec.describe "Api::V1::MyLists", type: :request do
  let(:user) { create(:user) }

  describe 'GET /my_lists' do
    context "マイリストだけが存在する場合" do
      let(:my_lists) { create_list(:my_list, 2, user: user) }

      before do
        my_lists
        get api_v1_my_lists_path, params: { user_id: user.id, token: user.token }
      end

      it 'ステータス OK が返ってくる' do
        expect(response).to have_http_status(:ok)
      end

      it "タグの一覧が返ってくる" do
        expect(response_json).to include({ title: my_lists[0].title, category_id: my_lists[0].category_id, description: my_lists[0].description, notes: [] }, { title: my_lists[1].title, category_id: my_lists[1].category_id, description: my_lists[1].description, notes: [] })
      end
    end

    context "マイリスト購買中のものが存在する場合" do
      let(:my_lists) { create_list(:my_list, 2, user: user) }
      let(:subscribe_my_list) { create(:subscribe_my_list, user: user) }

      before do
        my_lists
        subscribe_my_list
        get api_v1_my_lists_path, params: { user_id: user.id, token: user.token }
      end

      it ' ステータス OK が返ってくる' do
        expect(response).to have_http_status(:ok)
      end

      it "タグの一覧が返ってくる" do
        expect(response_json).to include({ title: subscribe_my_list.my_list.title, category_id: subscribe_my_list.my_list.category_id, description: subscribe_my_list.my_list.description, notes: [] }, { title: my_lists[0].title, category_id: my_lists[0].category_id, description: my_lists[0].description, notes: [] }, { title: my_lists[1].title, category_id: my_lists[1].category_id, description: my_lists[1].description, notes: [] })
      end
    end
  end
end
