require "net/http"
require "json"

module Client
  def get(uri)
    uri = URI(uri)
    request = Net::HTTP.get_response(uri)
    JSON.parse(request.body) if request.code == "200"
  end
end
