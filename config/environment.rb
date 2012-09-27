# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ideasbulb::Application.initialize!

# Application Constant
IDEA_STATUS_UNDER_REVIEW = 'under_review'
IDEA_STATUS_REVIEWED_SUCCESS = 'reviewed_success'
IDEA_STATUS_LAUNCHED = 'launched'
IDEAS_SORT_HOT = 'hot'
IDEAS_SORT_NEWEST = 'new'
SEARCH_SOLR_FILTER = /&&|\|\||[\+\-!\(\)\{\}\[\]\^"~\*\?:\\]/
