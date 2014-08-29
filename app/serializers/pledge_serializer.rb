class PledgeSerializer < ActiveModel::Serializer
  attributes :id, :pledger_id, :campaign_id
end
