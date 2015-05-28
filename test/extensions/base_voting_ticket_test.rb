module BaseVotingTicketTest
  def setup
    @voting_ticket = Sousenkyo::VotingTicket.new(
      expected_filepath,
      measurements
    )
  end
   
  def test_filepath_method
    assert_equal(
      expected_filepath,
      @voting_ticket.filepath
    )
  end

  def test_width_in_px
    assert_equal(
      expected_width_in_px,
      @voting_ticket.width_in_px
    )
  end

  def test_height_in_px
    assert_equal(
      expected_height_in_px,
      @voting_ticket.height_in_px
    )
  end

  def test_upper_left_x
    assert_equal(
      expected_upper_left_x,
      @voting_ticket.upper_left_x
    )
  end

  def test_upper_left_y
    assert_equal(
      expected_upper_left_y,
      @voting_ticket.upper_left_y
    )
  end

  def test_serial_code_width
    assert_equal(
      expected_serial_code_width,
      @voting_ticket.serial_code_width
    )
  end

  def test_serial_code_height
    assert_equal(
      expected_serial_code_height, 
      @voting_ticket.serial_code_height
    )
  end

  def test_width_in_cm
    assert_equal(
      expected_width_in_cm,
      @voting_ticket.width_in_cm
    )
  end

  def test_height_in_cm
    assert_equal(
      expected_height_in_cm,
      @voting_ticket.height_in_cm
    )
  end

  private

  def measurements
    YAML.load_file(measurements_filepath)
  end

  def expected_filepath
    File.expand_path(
      File.join(
        Sousenkyo.root,
        "test",
        ticket_path
      )
    )
  end
end
