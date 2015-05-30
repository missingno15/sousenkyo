module FilepathHelper
  private

  def test_dirpath
    @test_dirpath ||= File.expand_path("../../../test", __FILE__)
  end

  def fixtures_dirpath
    @fixtures_dirpath ||= "#{test_dirpath}/fixtures"
  end

  def images_dirpath
    @images_dirpath ||= "#{test_dirpath}/images"
  end
end
