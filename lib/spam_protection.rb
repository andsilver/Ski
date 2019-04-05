module SpamProtection
  # spam protection based on Jack Born's Safer Contact Forms Without CAPTCHA's
  # http://15daysofjquery.com/examples/contact-forms/

  # returns the current time, according to the server, and sets
  # a cookie containing the time + session secret hashed
  def current_time
    current_time = Time.now.to_i.to_s
    session[:enquiry_token] = hash current_time
    render partial: "spam/current_time", object: current_time
  end

  private

  def hash plain
    Digest::SHA1.hexdigest("--#{plain}--#{MySkiChalet::Application.config.secret_token}--")
  end

  def good_token?
    return true if Rails.env == "test"
    completed_time = Time.now.to_i
    # check required parameter and cookie
    if params[:current_time].nil? || session[:enquiry_token].nil?
      flash.now[:notice] = "We could not send your form. Check that you have an " \
        "up-to-date browser with JavaScript switched on and cookies enabled."
      return false
    end

    start_time = params[:current_time]

    # check that the submitted timestamp, when hashed, is the same as the
    # cookie we set earlier
    if hash(start_time) != session[:enquiry_token]
      flash.now[:notice] = "We could not send your form. Please try again."
      return false
    end

    shortest_time_allowed = 3
    longest_time_allowed = 10 * 60

    delta = completed_time - start_time.to_i

    if (delta < shortest_time_allowed) || (delta > longest_time_allowed)
      flash.now[:notice] = "We could not send your form as it was submitted too quickly or too slowly."
      return false
    end

    true
  end
end
