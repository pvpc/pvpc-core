require 'rails_helper'

RSpec.describe TeamsController do
  before do
    @user = FactoryGirl.create(:user)
    @teams = FactoryGirl.create_list(:team, 3, founder: @user)
  end

  describe '#index' do
    context 'with access_token parameter' do
      it 'renders teams with current_user_relation' do
        index access_token: @user.session.access_token

        expect(response.status).to eql(200)
        expect(response_body['models'].size).to eql(3)
        response_body['models'].each do |hash|
          expect(hash['current_user_relation']).not_to be_nil
        end
      end
    end

    context 'without access_token parameter' do
      it 'renders teams without current_user_relation' do
        index

        expect(response.status).to eql(200)
        expect(response_body['models'].size).to eql(3)
        response_body['models'].each do |hash|
          expect(hash['current_user_relation']).to be_nil
        end
      end
    end
  end

  describe 'GET #show' do
    context 'with access_token paramter' do
      it 'renders team' do
        show access_token: @user.session.access_token, id: @teams[0].id

        expect(response.status).to eql(200)
        expect(response_body.keys.size).to be > 2
      end
    end

    context 'without access_token parameter' do
      it 'renders team' do
        show id: @teams[0].id
        
        expect(response.status).to eql(200)
        expect(response_body.keys.size).to be > 2
      end
    end
  end

  describe 'POST #create' do
    it 'creates team' do
      create access_token: @user.session.access_token,
        name: 'tim', description: 'nice team', tag: 'hdp', founder_id: @user.id
      expect(response.status).to eql(201)
      expect(Team.count).to eql(4)
    end

    it 'cannot create team as other user' do
      @other_user = FactoryGirl.create(:user)
      create access_token: @user.session.access_token,
        name: 'tim', description: 'nice team', tag: 'hdp', founder_id: @other_user.id
      expect(response.status).to eql(403)
      expect(Team.count).to eql(3)
    end
  end
end
