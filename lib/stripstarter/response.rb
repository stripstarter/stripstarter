module Stripstarter
  module Response

    # Campaign
    CAMPAIGN_CREATE_SUCCESS = "Campaign was successfully created."
    CAMPAIGN_DESTROY_SUCCESS = "Campaign was successfully destroyed."
    CAMPAIGN_DESTROY_FAILURE = "Campaign could not be destroyed."
    CAMPAIGN_UPDATE_SUCCESS = "Campaign was successfully updated."
    CAMPAIGN_SUBMIT_SUCCESS = "Campaign has been submitted for review \
      by administrator. In the meantime, why don't you check out some \
      other campaigns?"
    CAMPAIGN_SUBMIT_FAILURE = "This campaign cannot be submitted for review. \
      Please contact an administrator."
    CAMPAIGN_NOT_FOUND = "That campaign doesn't exist!"

    # Customer
    CUSTOMER_CREATE_SUCCESS = "Success!  Your card was added."
    CUSTOMER_CREATE_FAILURE = "We could not add you at this time!"

    # Photo
    PHOTO_CREATE_SUCCESS = "Photo successfully created. \
      Add another or hit 'finalize' to move campaign to review."
    PHOTO_CREATE_FAILURE = "We could not save this photo."
    PHOTO_DESTROY_SUCCESS = "Photo successfully destroyed."

    # Pledge
    PLEDGE_CONFIRM_SUCCESS = "Pledge successful, but you won't \
      be charged until the campaign completes."
    PLEDGE_DESTROY_SUCCESS = "Pledge successfully deleted."
    PLEDGE_DESTROY_FAILURE = "Pledge could not be deleted."
    NOT_A_CUSTOMER = "We don't have a card for you on file! \
      Please add one by clicking the button below."
    
    # Misc
    UNAUTHORIZED_ACTION = "You are not permitted to perform this action."

  end
end