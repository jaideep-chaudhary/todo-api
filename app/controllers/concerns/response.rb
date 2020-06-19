module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def respond_with_errors(object)
    render json: { errors: ErrorSerializer.serialize(object) }, status: :unprocessable_entity
  end
end