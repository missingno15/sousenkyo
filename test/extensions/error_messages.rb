module ErrorMessages
  def error_message(expected, actual) 
    "Expected #{expected} but got #{actual}"
  end
end
