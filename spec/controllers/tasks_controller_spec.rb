require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new task' do
        expect {
          post :create, params: { task: { description: 'New task' } }
        }.to change(Task, :count).by(1)
      end

      it 'redirects to tasks#index' do
        post :create, params: { task: { description: 'New task' } }
        expect(response).to redirect_to(tasks_url)
      end

      it 'sets a success notice' do
        post :create, params: { task: { description: 'New task' } }
        expect(flash[:notice]).to eq('Task created successfully.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new task' do
        expect {
          post :create, params: { task: { description: '' } }
        }.not_to change(Task, :count)
      end

      it 'redirects to tasks#index' do
        post :create, params: { task: { description: '' } }
        expect(response).to redirect_to(tasks_url)
      end

      it 'sets an alert notice' do
        post :create, params: { task: { description: '' } }
        expect(flash[:alert]).to eq('Task not created.')
      end
    end
  end

  describe 'PATCH #toggle' do
    let(:task) { create(:task) }

    it 'updates the completed attribute of the task' do
      patch :toggle, params: { id: task.id, completed: true }
      expect(task.reload.completed).to eq(true)
    end
  end

  describe 'PUT #update' do
    let(:task) { create(:task) }

    context 'with valid parameters' do
      it 'updates the task' do
        put :update, params: { id: task.id, task: { description: 'Updated task' } }
        expect(task.reload.description).to eq('Updated task')
      end

      it 'redirects to tasks#index' do
        put :update, params: { id: task.id, task: { description: 'Updated task' } }
        expect(response).to redirect_to(tasks_url)
      end

      it 'sets a success notice' do
        put :update, params: { id: task.id, task: { description: 'Updated task' } }
        expect(flash[:notice]).to eq('Task updated successfully.')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the task' do
        put :update, params: { id: task.id, task: { description: '' } }
        expect(task.reload.description).not_to eq('')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { create(:task) }

    it 'deletes the task' do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it 'redirects to tasks#index' do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(tasks_url)
    end

    it 'sets a success notice' do
      delete :destroy, params: { id: task.id }
      expect(flash[:notice]).to eq('Task deleted successfully.')
    end
  end
end
