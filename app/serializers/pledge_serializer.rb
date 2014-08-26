class PledgeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :campaign_id
end
