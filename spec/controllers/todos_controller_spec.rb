require "rails_helper"

RSpec.describe TodosController, type: :controller do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe "GET #todos" do
    before { get :index }

    it "Should return todos" do
      expect(response.body).to eq todos.to_json
    end

    it "Should return status code 200" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET #show" do
    let(:params) { { id: todo_id } }
    before { get :show, params: params }

    context "When the record exists" do
      it "Should return the todo" do
        expect(response.body).to eq todos.first.to_json
      end

      it "Should return status code 200" do
        expect(response).to have_http_status 200
      end
    end

    context "When the record not found" do
      let(:params) { { id: 11 } }

      it "Should return status code 404" do
        expect(response).to have_http_status 404
      end

      it "Should return a not found message" do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe "POST #create" do
    context "When params is valid" do
      let(:params){ { todo: { title: "Long" } } }
      before{ post :create, params: params }

      it "Should create todos" do
        expect(JSON.parse(response.body)["title"]).to eq params[:todo][:title]
      end

      it "Should return status code 201" do
        expect(response).to have_http_status 201
      end
    end

    context "When params is invalud" do
      let(:params){ { todo: { title: "" } } }
      before { post :create, params: params}

      it "Returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "Return a validation failure message" do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end
end
