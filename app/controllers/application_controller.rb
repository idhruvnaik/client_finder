class ApplicationController < ActionController::API
  include Request::Validation
  include Request::ResponseHandlers
end
